#include "mlir/Analysis/DataLayoutAnalysis.h"
#include "mlir/Dialect/Affine/Analysis/AffineAnalysis.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/IR/AffineValueMap.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlow.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/Index/IR/IndexDialect.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Utils/StaticValueUtils.h" // Per getValueOrCreateConstantIndexOp e getConstantIntValue
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Rewrite/FrozenRewritePatternSet.h"
#include "mlir/Target/LLVMIR/Import.h"
#include "mlir/Transforms/DialectConversion.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "mlir/Transforms/WalkPatternRewriteDriver.h"

// conversion patterns
#include "mlir/Conversion/AffineToStandard/AffineToStandard.h"
#include "mlir/Conversion/ArithToLLVM/ArithToLLVM.h"
#include "mlir/Conversion/ControlFlowToLLVM/ControlFlowToLLVM.h"
#include "mlir/Conversion/FuncToLLVM/ConvertFuncToLLVM.h"
#include "mlir/Conversion/IndexToLLVM/IndexToLLVM.h"
#include "mlir/Conversion/LLVMCommon/TypeConverter.h"
#include "mlir/Conversion/MemRefToLLVM/MemRefToLLVM.h"
#include "mlir/Conversion/SCFToControlFlow/SCFToControlFlow.h"
#include "mlir/Conversion/UBToLLVM/UBToLLVM.h"
#include "mlir/Conversion/VectorToLLVM/ConvertVectorToLLVM.h"
#include "mlir/Conversion/VectorToSCF/VectorToSCF.h"
#include "mlir/Dialect/Vector/Transforms/LoweringPatterns.h"

#include "ppu/PPUDialect.h"
#include "ppu/PPUOps.h"
#include "ppu/PPUPasses.h"

namespace mlir::ppu {
#define GEN_PASS_DEF_PPUINSERTVECLOAD
#define GEN_PASS_DEF_PPULOWERTOLLVM
#define GEN_PASS_DEF_CONVERTVECTORTOPPU
#define GEN_PASS_DEF_CONVERTLINALGTOPPUALGORITHM
#define GEN_PASS_DEF_PPUADDDLTIINFO
#include "ppu/PPUPasses.h.inc"

namespace {

//===----------------------------------------------------------------------===//
// PPUAddDLTIInfo
//===----------------------------------------------------------------------===//

class PPUAddDLTIInfo : public impl::PPUAddDLTIInfoBase<PPUAddDLTIInfo> {
public:
  using impl::PPUAddDLTIInfoBase<PPUAddDLTIInfo>::PPUAddDLTIInfoBase;

  void runOnOperation() override {
    ModuleOp module = getOperation();
    MLIRContext *ctx = &getContext();
    OpBuilder builder(ctx);

    // DLTI Spec per index a 32-bit
    auto indexType = builder.getIndexType();
    auto bitwidthAttr = builder.getI32IntegerAttr(32);
    auto entry = DataLayoutEntryAttr::get(indexType, bitwidthAttr);
    auto layoutSpec = DataLayoutSpecAttr::get(ctx, {entry});
    module->setAttr(DLTIDialect::kDataLayoutAttrName, layoutSpec);
    // target triple
    module->setAttr(LLVM::LLVMDialect::getTargetTripleAttrName(),
                    builder.getStringAttr("arc-pc-unknown-gnu"));
    // LLVM data-layout string
    module->setAttr(
        LLVM::LLVMDialect::getDataLayoutAttrName(),
        builder.getStringAttr("e-m:e-p:32:32-p1:32:32-p3:32:32-p5:32:32-i64:32-"
                              "f64:32-v64:32-v128:"
                              "32-a:0:32-v256:32-v512:32-n8:16:32"));
  }
};

//===----------------------------------------------------------------------===//
// PPUInsertVecLoad
//===----------------------------------------------------------------------===//

class PPUInsertVecLoad : public impl::PPUInsertVecLoadBase<PPUInsertVecLoad> {
public:
  using impl::PPUInsertVecLoadBase<PPUInsertVecLoad>::PPUInsertVecLoadBase;

  void runOnOperation() override {
    // questo metodo viene implementato dalla base-class OperationPass e
    // restituisce l'op a cui il passo viene ancorato (moduleOp in questo caso;
    // guarda la definizione nel file .td)
    ModuleOp module = getOperation();
    OpBuilder builder(module.getContext());

    // inserisco una funzione fittizia
    builder.setInsertionPointToStart(module.getBody());
    auto i32Type = builder.getI32Type();
    auto memrefType = MemRefType::get({16}, i32Type);
    auto vecType = VectorType::get({16}, i32Type);
    auto funcType = builder.getFunctionType({}, {vecType});
    auto func = builder.create<func::FuncOp>(module.getLoc(),
                                             "test_ppu_vec_load", funcType);

    // creo una memref.alloc come argomento per la vec_load
    Block *entry = func.addEntryBlock();
    builder.setInsertionPointToStart(entry);
    Value memref = builder.create<memref::AllocOp>(func.getLoc(), memrefType);

    // creo la ppu.vec_load
    auto vecLoad = builder.create<VecLoadOp>(func.getLoc(), vecType, memref);

    // aggiungo la return op
    builder.create<func::ReturnOp>(func.getLoc(), vecLoad.getRes());
  }
};

//===----------------------------------------------------------------------===//
// ConvertLinalgToPPUAlgorithm
//===----------------------------------------------------------------------===//

// HELPER utili per ottenere un puntatore da cui fare load/store con ppu ops a
// partire da una memref
//
// Ad esempio, trasformiamo questo:
//
// %2 =
//   vector.transfer_write %5, %arg2[%arg4] : vector<16xi32>, memref<?xi32>
//
// In questo:
//
// %intptr =
//   memref.extract_aligned_pointer_as_index %arg0 : memref<?xi32> -> index
// %1 = arith.index_cast %intptr : index to i64
// %2 = llvm.inttoptr %1 : i64 to !llvm.ptr<4>
// %3 = arith.index_cast %arg4 : index to i64
// %4 = llvm.getelementptr %2[%3] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, i32
// "ppu.vec_store"(%val, %4) : (vector<16xi32>, !llvm.ptr<4>) -> ()
Value materializeAlignedPtr(PatternRewriter &rewriter, Location loc,
                            Value memref, LLVM::LLVMPointerType ptrTy) {
  auto extractOp =
      rewriter.create<memref::ExtractAlignedPointerAsIndexOp>(loc, memref);
  auto indexCastOp = rewriter.create<arith::IndexCastOp>(
      loc, rewriter.getI32Type(), extractOp);
  auto alignedPtr = rewriter.create<LLVM::IntToPtrOp>(loc, ptrTy, indexCastOp);

  return alignedPtr;
}

// materializza la gep dati gli indici di una operazione di accesso alla memoria
Value materializeGEPForAccess(OpBuilder &builder, Location loc, Value basePtr,
                              LLVM::LLVMPointerType ptrTy, Type elemTy,
                              ValueRange indices) {
  if (indices.empty())
    return basePtr;

  // crea i cast da index a i32 per gli indici passati come argomento
  SmallVector<Value> gepIndices;
  for (Value idx : indices)
    gepIndices.push_back(
        builder.create<arith::IndexCastOp>(loc, builder.getI32Type(), idx));

  auto gepOp =
      builder.create<LLVM::GEPOp>(loc, ptrTy, elemTy, basePtr, gepIndices);

  return gepOp;
}

// TODO: questo cambia tra PPU diverse e quindi andrebbe reso configurabile
const int vectorRegisterBits = 512;

// TODO: invege di generare un loop nest di uguale rank possiamo usare un unico
// loop
struct ConvertLinalgAdd : public OpRewritePattern<mlir::linalg::AddOp> {

  ConvertLinalgAdd(mlir::MLIRContext *context)
      : OpRewritePattern<mlir::linalg::AddOp>(context) {}

  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(mlir::linalg::AddOp op,
                                PatternRewriter &rewriter) const final {

    MLIRContext *ctx = rewriter.getContext();
    mlir::Location loc = op.getLoc();

    // recuperiamo i ranges dei loop (start, stop, step)
    auto linalgOp = ::llvm::cast<mlir::linalg::LinalgOp>(op.getOperation());
    // createLoopRanges() è un utility che analizza le shape degli operandi e le
    // indexing_maps della linalg-op per estrarre i range (start, stop, step)
    // (== (offset, size, stride)) dello spazio di iterazione.
    // NB: Supporta automaticamente anche dimensioni dinamiche materializzando
    // delle memref.dim ops
    mlir::SmallVector<mlir::Range> loopRanges =
        linalgOp.createLoopRanges(rewriter, loc);

    // Recuperiamo gli operandi
    mlir::Value lhs = op.getInputs()[0];
    mlir::Value rhs = op.getInputs()[1];
    mlir::Value out = op.getOutputs()[0];

    // recuperiamo vari tipi e il numero di lane considerando il tipo degli
    // operandi
    Type elemTy = mlir::cast<MemRefType>(lhs.getType()).getElementType();
    if (!elemTy.isIntOrFloat())
      return rewriter.notifyMatchFailure(
          op, "tipo elemento non supportato per vettorizzazione");
    unsigned bitWidth = elemTy.getIntOrFloatBitWidth();
    int numLanes = vectorRegisterBits / bitWidth;
    auto vecTy = mlir::VectorType::get({numLanes}, elemTy);
    // NB: qua sto hardcodando l'address space della vector memory (4)
    auto ppuPtrTy = LLVM::LLVMPointerType::get(rewriter.getContext(), 4);

    // estraiamo dalle memref degli operandi l'alignedPtr
    Value lhsBase = materializeAlignedPtr(rewriter, loc, lhs, ppuPtrTy);
    Value rhsBase = materializeAlignedPtr(rewriter, loc, rhs, ppuPtrTy);
    Value outBase = materializeAlignedPtr(rewriter, loc, out, ppuPtrTy);

    // L'ultima dimensione è quella che vettorizziamo, le altre restano
    // loop scalari affine come nel pattern originale.
    mlir::Range innerRange = loopRanges.back();
    SmallVector<mlir::Range> outerRanges(loopRanges.begin(),
                                         loopRanges.end() - 1);

    // In questo momento ho un vettore di Range, ma il builder sotto ha bisogno
    // di vettori separati per lbs, ubs e steps. Me li ricavo scorrendo i range
    llvm::SmallVector<mlir::Value, 4> outerLbs, outerUbs;
    llvm::SmallVector<int64_t, 4> outerSteps;
    for (const auto &range : loopRanges) {
      // Materializza offset e size in creando delle arith.constant se sono
      // costanti statiche (mi serve per avere dei Value per il builder sotto)
      outerLbs.push_back(
          mlir::getValueOrCreateConstantIndexOp(rewriter, loc, range.offset));
      outerUbs.push_back(
          mlir::getValueOrCreateConstantIndexOp(rewriter, loc, range.size));
      // Estrai lo step come int64_t da range.stride (OpFoldResult)
      int64_t stepVal = 1;
      if (auto optInt = mlir::getConstantIntValue(range.stride)) {
        stepVal = *optInt;
      }
      outerSteps.push_back(stepVal);
    }

    Value innerLb =
        mlir::getValueOrCreateConstantIndexOp(rewriter, loc, innerRange.offset);
    Value innerUb =
        mlir::getValueOrCreateConstantIndexOp(rewriter, loc, innerRange.size);

    // dim_rounded = (dim floordiv 16) * 16, espresso come affine.apply
    AffineExpr s0 = rewriter.getAffineSymbolExpr(0);
    AffineMap roundingMap =
        AffineMap::get(0, 1, {s0.floorDiv(numLanes) * numLanes}, ctx);
    Value dimRounded = rewriter.create<affine::AffineApplyOp>(
        loc, roundingMap, ValueRange{innerUb});

    // lambda per la costruzione dell'inner loop
    auto buildInnerLoops = [&](OpBuilder &b0, Location loc0,
                               ValueRange outerIvs) {
      // mappa identità a 1 dimensione: (d0) -> (d0) per gli ub e lb dei loop
      mlir::AffineMap identityMap = b0.getMultiDimIdentityMap(1);

      // main loop vettorizzato
      b0.create<affine::AffineForOp>(
          loc0, innerLb, identityMap, dimRounded, identityMap, numLanes,
          std::nullopt,
          [&](OpBuilder &b, Location l, Value iv, ValueRange /* iterArgs */) {
            SmallVector<Value> idxs(outerIvs.begin(), outerIvs.end());
            idxs.push_back(iv);

            Value lhsPtr =
                materializeGEPForAccess(b, l, lhsBase, ppuPtrTy, elemTy, idxs);
            Value rhsPtr =
                materializeGEPForAccess(b, l, rhsBase, ppuPtrTy, elemTy, idxs);
            Value outPtr =
                materializeGEPForAccess(b, l, outBase, ppuPtrTy, elemTy, idxs);

            Value lhsVec = b.create<ppu::VecLoadOp>(l, vecTy, lhsPtr);
            Value rhsVec = b.create<ppu::VecLoadOp>(l, vecTy, rhsPtr);
            Value resVec = b.create<ppu::VecAddOp>(l, vecTy, lhsVec, rhsVec);
            b.create<ppu::VecStoreOp>(l, resVec, outPtr);

            b.create<affine::AffineYieldOp>(l);
          });

      // remainder loop scalare
      b0.create<affine::AffineForOp>(
          loc0, dimRounded, identityMap, innerUb, identityMap, 1, std::nullopt,
          [&](OpBuilder &b, Location l, Value iv, ValueRange /* iterArgs */) {
            SmallVector<Value> idxs(outerIvs.begin(), outerIvs.end());
            idxs.push_back(iv);

            Value lhsVal = b.create<affine::AffineLoadOp>(l, lhs, idxs);
            Value rhsVal = b.create<affine::AffineLoadOp>(l, rhs, idxs);
            Value resVal = b.create<arith::AddIOp>(l, lhsVal, rhsVal);
            b.create<affine::AffineStoreOp>(l, resVal, out, idxs);

            b.create<affine::AffineYieldOp>(l);
          });
    };

    // se ci sono outer-loops usa la utility già pronto per creare il nest
    // altrimenti usa solo la lambda
    if (outerRanges.empty()) {
      buildInnerLoops(rewriter, loc, ValueRange{});
    } else {
      mlir::affine::buildAffineLoopNest(
          rewriter, loc, outerLbs, outerUbs, outerSteps,
          [&](OpBuilder &nestedBuilder, Location nestedLoc, ValueRange ivs) {
            buildInnerLoops(nestedBuilder, nestedLoc, ivs);
          });
    }

    rewriter.eraseOp(op);

    return success();
  }
};

struct ConvertLinalgDot : public OpRewritePattern<mlir::linalg::DotOp> {

  ConvertLinalgDot(mlir::MLIRContext *context)
      : OpRewritePattern<mlir::linalg::DotOp>(context) {}

  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(mlir::linalg::DotOp op,
                                PatternRewriter &rewriter) const final {

    MLIRContext *ctx = rewriter.getContext();
    mlir::Location loc = op.getLoc();

    // recuperiamo i ranges dei loop (start, stop, step)
    auto linalgOp = ::llvm::cast<mlir::linalg::LinalgOp>(op.getOperation());
    // createLoopRanges() è un utility che analizza le shape degli operandi e le
    // indexing_maps della linalg-op per estrarre i range (start, stop, step)
    // (== (offset, size, stride)) dello spazio di iterazione.
    // NB: Supporta automaticamente anche dimensioni dinamiche materializzando
    // delle memref.dim ops
    mlir::SmallVector<mlir::Range> loopRanges =
        linalgOp.createLoopRanges(rewriter, loc);
    if (loopRanges.size() != 1)
      return rewriter.notifyMatchFailure(op,
                                         "panico, dotp ha più di un loop?!");
    auto range = loopRanges[0];

    // Recuperiamo gli operandi
    mlir::Value lhs = op.getInputs()[0];
    mlir::Value rhs = op.getInputs()[1];
    mlir::Value out = op.getOutputs()[0];

    // recuperiamo vari tipi e il numero di lane considerando il tipo degli
    // operandi
    Type elemTy = mlir::cast<MemRefType>(lhs.getType()).getElementType();
    if (!elemTy.isIntOrFloat())
      return rewriter.notifyMatchFailure(
          op, "tipo elemento non supportato per vettorizzazione");
    unsigned bitWidth = elemTy.getIntOrFloatBitWidth();
    int numLanes = vectorRegisterBits / bitWidth;
    auto vecTy = mlir::VectorType::get({numLanes}, elemTy);
    // NB: qua sto hardcodando l'address space della vector memory (4)
    auto ppuPtrTy = LLVM::LLVMPointerType::get(rewriter.getContext(), 4);

    // costruiamo un registro accumulatore inizializzato a 0 (devo costruire
    // anche una costante di inizializzazione piena di zeri da usare come arg)
    Value zero = rewriter.create<arith::ConstantOp>(
        loc, vecTy, rewriter.getZeroAttr(vecTy));
    auto accumulator =
        rewriter.create<ppu::VecMpyLowAccOp>(loc, vecTy, zero, zero);

    // estraiamo dalle memref degli operandi l'alignedPtr
    Value lhsBase = materializeAlignedPtr(rewriter, loc, lhs, ppuPtrTy);
    Value rhsBase = materializeAlignedPtr(rewriter, loc, rhs, ppuPtrTy);

    // Materializza offset e size in creando delle arith.constant se sono
    // costanti statiche (mi serve per avere dei Value per il builder sotto)
    Value lb =
        mlir::getValueOrCreateConstantIndexOp(rewriter, loc, range.offset);
    Value ub = mlir::getValueOrCreateConstantIndexOp(rewriter, loc, range.size);
    // dim_rounded = (dim floordiv 16) * 16, espresso come affine.apply
    AffineExpr s0 = rewriter.getAffineSymbolExpr(0);
    AffineMap roundingMap =
        AffineMap::get(0, 1, {s0.floorDiv(numLanes) * numLanes}, ctx);
    Value dimRounded = rewriter.create<affine::AffineApplyOp>(loc, roundingMap,
                                                              ValueRange{ub});

    // mappa identità a 1 dimensione: (d0) -> (d0) per gli ub e lb dei loop
    mlir::AffineMap identityMap = rewriter.getMultiDimIdentityMap(1);

    // main loop vettorizzato
    affine::AffineForOp mainLoop = rewriter.create<affine::AffineForOp>(
        loc, lb, identityMap, dimRounded, identityMap, numLanes,
        ValueRange{accumulator},
        [&](OpBuilder &b, Location l, Value iv, ValueRange acc) {
          Value lhsPtr =
              materializeGEPForAccess(b, l, lhsBase, ppuPtrTy, elemTy, iv);
          Value rhsPtr =
              materializeGEPForAccess(b, l, rhsBase, ppuPtrTy, elemTy, iv);
          // per il dotproduct outPtr == outBase siccome scriviamo uno scalare

          Value lhsVec = b.create<ppu::VecLoadOp>(l, vecTy, lhsPtr);
          Value rhsVec = b.create<ppu::VecLoadOp>(l, vecTy, rhsPtr);
          Value mac = b.create<ppu::VecMACLowOp>(l, acc[0], lhsVec, rhsVec);

          b.create<affine::AffineYieldOp>(l, mac);
        });

    auto reductionOp =
        rewriter.create<ppu::VecReduceAddOp>(loc, mainLoop->getResults()[0]);

    // remainder loop scalare
    affine::AffineForOp remainderLoop = rewriter.create<affine::AffineForOp>(
        loc, dimRounded, identityMap, ub, identityMap, 1,
        ValueRange{reductionOp},
        [&](OpBuilder &b, Location l, Value iv, ValueRange acc) {
          Value lhsVal = b.create<affine::AffineLoadOp>(l, lhs, iv);
          Value rhsVal = b.create<affine::AffineLoadOp>(l, rhs, iv);
          Value mulVal = b.create<arith::MulIOp>(l, lhsVal, rhsVal);
          Value macVal = b.create<arith::AddIOp>(l, acc[0], mulVal);

          b.create<affine::AffineYieldOp>(l, macVal);
        });

    rewriter.create<affine::AffineStoreOp>(loc, remainderLoop->getResults()[0],
                                           out, ValueRange{});
    rewriter.eraseOp(op);

    return success();
  }
};

struct ConvertLinalgMatmul : public OpRewritePattern<mlir::linalg::MatmulOp> {

  ConvertLinalgMatmul(mlir::MLIRContext *context)
      : OpRewritePattern<mlir::linalg::MatmulOp>(context) {}

  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(mlir::linalg::MatmulOp op,
                                PatternRewriter &rewriter) const final {

    MLIRContext *ctx = rewriter.getContext();
    mlir::Location loc = op.getLoc();

    // recuperiamo i ranges dei loop (start, stop, step)
    auto linalgOp = ::llvm::cast<mlir::linalg::LinalgOp>(op.getOperation());
    mlir::SmallVector<mlir::Range> loopRanges =
        linalgOp.createLoopRanges(rewriter, loc);
    if (loopRanges.size() != 3)
      return rewriter.notifyMatchFailure(op, "panico, matmul non ha 3 loop?");
    auto rangeM = loopRanges[0];
    auto rangeN = loopRanges[1];
    auto rangeK = loopRanges[2];

    // Recuperiamo gli operandi
    mlir::Value lhs = op.getInputs()[0];
    mlir::Value rhs = op.getInputs()[1];
    mlir::Value out = op.getOutputs()[0];

    // recuperiamo vari tipi e il numero di lane considerando il tipo degli
    // operandi
    Type elemTy = mlir::cast<MemRefType>(lhs.getType()).getElementType();
    if (!elemTy.isIntOrFloat())
      return rewriter.notifyMatchFailure(
          op, "tipo elemento non supportato per vettorizzazione");
    unsigned bitWidth = elemTy.getIntOrFloatBitWidth();
    int numLanes = vectorRegisterBits / bitWidth;
    auto vecTy = mlir::VectorType::get({numLanes}, elemTy);
    // NB: qua sto hardcodando l'address space della vector memory (4)
    auto ppuPtrTy = LLVM::LLVMPointerType::get(rewriter.getContext(), 4);

    // // costruiamo un registro accumulatore inizializzato a 0 (devo costruire
    // // anche una costante di inizializzazione piena di zeri da usare come
    // arg) Value zero = rewriter.create<arith::ConstantOp>(
    //     loc, vecTy, rewriter.getZeroAttr(vecTy));
    // auto accumulator =
    //     rewriter.create<ppu::VecMpyLowAccOp>(loc, vecTy, zero, zero);

    // estraiamo l'alignedPtr dalle memref degli operandi
    Value rhsBase = materializeAlignedPtr(rewriter, loc, rhs, ppuPtrTy);
    Value outBase = materializeAlignedPtr(rewriter, loc, out, ppuPtrTy);

    Value lbM =
        mlir::getValueOrCreateConstantIndexOp(rewriter, loc, rangeM.offset);
    Value ubM =
        mlir::getValueOrCreateConstantIndexOp(rewriter, loc, rangeM.size);
    Value lbK =
        mlir::getValueOrCreateConstantIndexOp(rewriter, loc, rangeK.offset);
    Value ubK =
        mlir::getValueOrCreateConstantIndexOp(rewriter, loc, rangeK.size);
    // vettorizzo la dimensione N
    Value lbN =
        mlir::getValueOrCreateConstantIndexOp(rewriter, loc, rangeN.offset);
    Value ubN =
        mlir::getValueOrCreateConstantIndexOp(rewriter, loc, rangeN.size);
    // dim_rounded = (dim floordiv 16) * 16, espresso come affine.apply
    AffineExpr s0 = rewriter.getAffineSymbolExpr(0);
    AffineMap roundingMap =
        AffineMap::get(0, 1, {s0.floorDiv(numLanes) * numLanes}, ctx);
    Value dimRounded = rewriter.create<affine::AffineApplyOp>(loc, roundingMap,
                                                              ValueRange{ubN});

    Value NValue =
        mlir::getValueOrCreateConstantIndexOp(rewriter, loc, rangeN.size);

    // mappa identità a 1 dimensione: (d0) -> (d0) per gli ub e lb dei loop
    mlir::AffineMap identityMap = rewriter.getMultiDimIdentityMap(1);

    // main loop vettorizzato (M, N/numLanes, K)

    /**** Loop M ****/
    rewriter.create<affine::AffineForOp>(
        loc, lbM, identityMap, ubM, identityMap, 1, std::nullopt,
        [&](OpBuilder &b0, Location l0, Value ivI, ValueRange) {
          /**** Loop N/numLanes ****/
          rewriter.create<affine::AffineForOp>(
              l0, lbN, identityMap, dimRounded, identityMap, numLanes,
              std::nullopt,
              [&](OpBuilder &b1, Location l1, Value ivJ, ValueRange) {
                // costruiamo un registro accumulatore inizializzato con quello
                // che c'è a partire da: linearIndex di C = i*N + j
                // NB: devo anche linearizzare la coppia di indici dato che
                // ppu.load_vec accetta solo llvm.ptr e non memref
                Value rowOffset = b1.create<arith::MulIOp>(l1, ivI, NValue);
                Value linearIndex =
                    b1.create<arith::AddIOp>(l1, rowOffset, ivJ);
                Value outPtr = materializeGEPForAccess(
                    b1, l1, outBase, ppuPtrTy, elemTy, ValueRange{linearIndex});
                Value outInit = b1.create<ppu::VecLoadOp>(l1, vecTy, outPtr);
                // inizializziamo l'accumulatore con il vettore di C
                // moltiplicato per un vettore di 1
                Value zeros = rewriter.create<arith::ConstantOp>(
                    loc, vecTy, rewriter.getZeroAttr(vecTy));
                auto accumulator = rewriter.create<ppu::VecAddInitAccOp>(
                    loc, vecTy, outInit, zeros);

                /**** Loop K ****/
                auto kLoop = rewriter.create<affine::AffineForOp>(
                    loc, lbK, identityMap, ubK, identityMap, 1,
                    ValueRange{accumulator},
                    [&](OpBuilder &b2, Location l2, Value ivK, ValueRange acc) {
                      // load di un pezzo di riga di B: linearIndex di B=k*N + j
                      Value rowOffset =
                          b2.create<arith::MulIOp>(l2, ivK, NValue);
                      Value linearIndex =
                          b2.create<arith::AddIOp>(l2, rowOffset, ivJ);
                      Value rhsPtr = materializeGEPForAccess(
                          b2, l2, rhsBase, ppuPtrTy, elemTy,
                          ValueRange{linearIndex});
                      Value rhsVec =
                          b2.create<ppu::VecLoadOp>(l2, vecTy, rhsPtr);
                      // load e broadcast esplicito dello scalare
                      // NB: il broadcast dovrebbe venire legalizzato via dal
                      // backend della PPU che è in grado di usare un'istruzione
                      // di MAC con anche registri scalari. Inserisco il
                      // broadcast dato che ho visto che è quello che succede
                      // dentro all'llvm-ir prodotto dal compilatore metaware
                      Value lhsScalar = b2.create<affine::AffineLoadOp>(
                          l2, lhs, ValueRange{ivI, ivK});
                      Value lhsScalarBroadcasted =
                          b2.create<vector::BroadcastOp>(l2, vecTy, lhsScalar);

                      Value mac = b2.create<ppu::VecMACLowOp>(
                          l2, acc[0], rhsVec, lhsScalarBroadcasted);

                      b2.create<affine::AffineYieldOp>(l2, mac);
                    });

                // store del vettore (anche qui c'è bisogno di linearizzare)
                Value acc2vec =
                    b1.create<ppu::AccToVecOp>(l1, kLoop.getResults()[0]);
                b1.create<ppu::VecStoreOp>(l1, acc2vec, outPtr);

                b1.create<affine::AffineYieldOp>(l1);
              });

          b0.create<affine::AffineYieldOp>(l0);
        });

    // remainder loop (M, N/numLanes:N, K)

    /**** Loop M ****/
    rewriter.create<affine::AffineForOp>(
        loc, lbM, identityMap, ubM, identityMap, 1, std::nullopt,
        [&](OpBuilder &b0, Location l0, Value ivI, ValueRange) {
          /**** Loop N/numLanes:N ****/
          rewriter.create<affine::AffineForOp>(
              l0, dimRounded, identityMap, ubN, identityMap, 1, std::nullopt,
              [&](OpBuilder &b1, Location l1, Value ivJ, ValueRange) {
                // valori iniziale per l'accumulatore
                auto intTy = b1.getI32Type();
                Value zero = b1.create<arith::ConstantOp>(
                    loc, intTy, b1.getZeroAttr(intTy));
                /**** Loop K ****/
                auto kLoop = rewriter.create<affine::AffineForOp>(
                    loc, lbK, identityMap, ubK, identityMap, 1,
                    ValueRange{zero},
                    [&](OpBuilder &b2, Location l2, Value ivK, ValueRange acc) {
                      Value lhsVal = b2.create<affine::AffineLoadOp>(
                          l2, lhs, ValueRange{ivI, ivK});
                      Value rhsVal = b2.create<affine::AffineLoadOp>(
                          l2, rhs, ValueRange{ivK, ivJ});
                      Value mulVal =
                          b2.create<arith::MulIOp>(l2, lhsVal, rhsVal);
                      Value macVal =
                          b2.create<arith::AddIOp>(l2, acc[0], mulVal);

                      b2.create<affine::AffineYieldOp>(l2, macVal);
                    });

                b1.create<affine::AffineStoreOp>(l1, kLoop.getResults()[0], out,
                                                 ValueRange{ivI, ivJ});
                b1.create<affine::AffineYieldOp>(l1);
              });

          b0.create<affine::AffineYieldOp>(l0);
        });

    rewriter.eraseOp(op);

    return success();
  }
};

struct ConvertLinalgToPPUAlgorithm
    : impl::ConvertLinalgToPPUAlgorithmBase<ConvertLinalgToPPUAlgorithm> {
  using ConvertLinalgToPPUAlgorithmBase::ConvertLinalgToPPUAlgorithmBase;

  // NB: non sto usando il dialect conversion framework dato che non ho bisogno
  // di gestire conversioni dei tipi. Similmente non sto utilizzando il greedy
  // pattern rewriter framework dato che non introduco ops che necessitano a
  // loro volta di un match&rewrite in stile fixed-point. Utilizzo un semplice
  // walker che applica i miei pattern
  // NB: il walker non applica folding o DCE, è quindi una buona idea aggiungere
  // un passo di canonicalizzazione dopo questo
  void runOnOperation() override {
    MLIRContext *ctx = &getContext();
    ModuleOp module = getOperation();

    RewritePatternSet patterns(ctx);
    patterns.add<ConvertLinalgAdd, ConvertLinalgDot, ConvertLinalgMatmul>(ctx);
    // Post-order, forward walk traversal of ops (excluding input `op`).
    walkAndApplyPatterns(module, std::move(patterns));
  }
};

//===----------------------------------------------------------------------===//
// PPULowerToLLVM
//===----------------------------------------------------------------------===//

struct PPULowerToLLVM : impl::PPULowerToLLVMBase<PPULowerToLLVM> {
  using PPULowerToLLVMBase::PPULowerToLLVMBase;

  void runOnOperation() override {
    MLIRContext *context = &getContext();
    ModuleOp module = getOperation();

    // leggiamo le dlti del modulo e le passiamo come opzioni al type converter
    // usato dai pattern di conversion verso llvm
    mlir::DataLayout mlirDL(module);
    LowerToLLVMOptions options(context, mlirDL);
    // options.overrideIndexBitwidth(32); // posso forzare invece che leggere
    LLVMTypeConverter typeConverter(&getContext(), options);
    // llvm::errs() << "\tDEBUG:\t index bitwidth = "
    //              << typeConverter.getIndexTypeBitwidth() << "\n";

    ConversionTarget target(*context);
    target.addLegalDialect<LLVM::LLVMDialect>();
    target.addLegalDialect<ppu::PPUDialect>();
    // target.addLegalOp<ModuleOp>(); // not doing a full conversion
    target.addIllegalDialect<arith::ArithDialect, scf::SCFDialect,
                             cf::ControlFlowDialect, func::FuncDialect,
                             memref::MemRefDialect, vector::VectorDialect,
                             index::IndexDialect>();

    // NB: l'ordine con cui popolo i pattern non conta! Molto meglio rispetto a
    // fare un lowering manuale con una pass pipeline come facevo prima
    RewritePatternSet patterns(context);
    populateAffineToStdConversionPatterns(patterns);
    populateSCFToControlFlowConversionPatterns(patterns);
    ub::populateUBToLLVMConversionPatterns(typeConverter, patterns);
    arith::populateArithToLLVMConversionPatterns(typeConverter, patterns);
    index::populateIndexToLLVMConversionPatterns(typeConverter, patterns);
    populateFinalizeMemRefToLLVMConversionPatterns(typeConverter, patterns);
    cf::populateControlFlowToLLVMConversionPatterns(typeConverter, patterns);
    // TODO: il lowering di memrefs con dimensione dinamica non è ammesso anche
    // usando questa opzione 'funcToLLVMOpts.useBarePtrCallConv = true' 😭
    // https://mlir.llvm.org/doxygen/LLVMCommon_2TypeConverter_8cpp_source.html#l00593
    //
    // qua mi espande le memrefs nelle struct complete, io vorrei raw ptrs ...
    populateFuncToLLVMConversionPatterns(typeConverter, patterns);

    if (failed(applyPartialConversion(module, target, std::move(patterns)))) {
      signalPassFailure();
    }
  }
};

} // namespace
} // namespace mlir::ppu
