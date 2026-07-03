#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlow.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Rewrite/FrozenRewritePatternSet.h"
#include "mlir/Transforms/DialectConversion.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

// conversion patterns
#include "mlir/Conversion/AffineToStandard/AffineToStandard.h"
#include "mlir/Conversion/ArithToLLVM/ArithToLLVM.h"
#include "mlir/Conversion/ControlFlowToLLVM/ControlFlowToLLVM.h"
#include "mlir/Conversion/FuncToLLVM/ConvertFuncToLLVM.h"
#include "mlir/Conversion/LLVMCommon/TypeConverter.h"
#include "mlir/Conversion/MemRefToLLVM/MemRefToLLVM.h"
#include "mlir/Conversion/SCFToControlFlow/SCFToControlFlow.h"
#include "mlir/Conversion/UBToLLVM/UBToLLVM.h"
#include "mlir/Conversion/VectorToLLVM/ConvertVectorToLLVM.h"
#include "mlir/Conversion/VectorToSCF/VectorToSCF.h"
#include "mlir/Dialect/Vector/Transforms/LoweringPatterns.h"

#include "mlir/Transforms/WalkPatternRewriteDriver.h"
#include "ppu/PPUDialect.h"
#include "ppu/PPUOps.h"
#include "ppu/PPUPasses.h"

#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/Pass/Pass.h"

namespace mlir::ppu {
#define GEN_PASS_DEF_PPUINSERTVECLOAD
#define GEN_PASS_DEF_PPULOWERTOLLVM
#define GEN_PASS_DEF_CONVERTVECTORTOPPU
#include "ppu/PPUPasses.h.inc"

namespace {

// NB: questo me lo tengo come esempio di passo che fa uso di RewritePattern
// //===----------------------------------------------------------------------===//
// // PPUSwitchBarFooRewriter
// //===----------------------------------------------------------------------===//

// class PPUSwitchBarFooRewriter : public OpRewritePattern<func::FuncOp> {
// public:
//   using OpRewritePattern<func::FuncOp>::OpRewritePattern;
//   LogicalResult matchAndRewrite(func::FuncOp op,
//                                 PatternRewriter &rewriter) const final {
//     if (op.getSymName() == "bar") {
//       rewriter.modifyOpInPlace(op, [&op]() { op.setSymName("foo"); });
//       return success();
//     }
//     return failure();
//   }
// };

// class PPUSwitchBarFoo : public impl::PPUSwitchBarFooBase<PPUSwitchBarFoo> {
// public:
//   using impl::PPUSwitchBarFooBase<PPUSwitchBarFoo>::PPUSwitchBarFooBase;

//   void runOnOperation() final {
//     RewritePatternSet patterns(&getContext());
//     patterns.add<PPUSwitchBarFooRewriter>(&getContext());
//     FrozenRewritePatternSet patternSet(std::move(patterns));
//     if (failed(applyPatternsGreedily(getOperation(), patternSet)))
//       signalPassFailure();
//   }
// };

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
// ConvertVectorToPPU
//===----------------------------------------------------------------------===//

struct ConvertVectorTransferRead
    : public OpRewritePattern<mlir::vector::TransferReadOp> {

  ConvertVectorTransferRead(mlir::MLIRContext *context)
      : OpRewritePattern<mlir::vector::TransferReadOp>(context) {}

  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(mlir::vector::TransferReadOp op,
                                PatternRewriter &rewriter) const final {

    // Trasformiamo questo:
    //
    // %2 =
    //   vector.transfer_read %arg0[%arg4], %1 : memref<?xi32>, vector<16xi32>
    //
    // In questo:
    //
    // %intptr =
    //   memref.extract_aligned_pointer_as_index %arg0 : memref<?xi32> -> index
    // %1 = arith.index_cast %intptr : index to i64
    // %2 = llvm.inttoptr %1 : i64 to !llvm.ptr<4>
    // %3 = arith.index_cast %arg4 : index to i64
    // %4 = llvm.getelementptr %2[%3] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, i32
    // %5 = "ppu.vec_load"(%4) : (!llvm.ptr<4>) -> vector<16xi32>

    auto extractOp = rewriter.create<memref::ExtractAlignedPointerAsIndexOp>(
        op.getLoc(), op.getSource());
    auto indexCastOp = rewriter.create<arith::IndexCastOp>(
        op.getLoc(), rewriter.getI64Type(), extractOp);
    // NB: qua stiamo hardcodando l'addrespace(4) della PPU
    auto PPUPtrTy = LLVM::LLVMPointerType::get(rewriter.getContext(), 4);
    auto basePtr =
        rewriter.create<LLVM::IntToPtrOp>(op.getLoc(), PPUPtrTy, indexCastOp);

    // costruire una GEP è un po' più complicato dato che bisogna gestire indici
    // potenzialmente multidimensionali
    auto indices = op.getIndices();
    // la GEP vuole vuole interi e non index types
    SmallVector<Value> gepIndices;
    for (Value idx : indices) {
      auto castedIdx = rewriter.create<arith::IndexCastOp>(
          op.getLoc(), rewriter.getI64Type(), idx);
      gepIndices.push_back(castedIdx);
    }
    // recuperiamo il tipo di dato puntato dalla memref
    Type elemTy = op.getSource().getType().getElementType();
    Value finalPtr = basePtr;
    if (!gepIndices.empty()) {
      auto gepOp = rewriter.create<LLVM::GEPOp>(op.getLoc(), PPUPtrTy, elemTy,
                                                basePtr, gepIndices);
      finalPtr = gepOp.getResult();
    }

    auto vecTy = VectorType::get({16}, elemTy);
    auto ppuVecLoadOp =
        rewriter.create<ppu::VecLoadOp>(op.getLoc(), vecTy, finalPtr);

    rewriter.replaceOp(op.getOperation(), ppuVecLoadOp.getRes());

    return success();
  }
};

struct ConvertVectorToPPU : impl::ConvertVectorToPPUBase<ConvertVectorToPPU> {
  using ConvertVectorToPPUBase::ConvertVectorToPPUBase;

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
    patterns.add<ConvertVectorTransferRead>(ctx);
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

    ConversionTarget target(*context);
    target.addLegalDialect<LLVM::LLVMDialect>();
    target.addLegalDialect<ppu::PPUDialect>();
    // target.addLegalOp<ModuleOp>(); // not doing a full conversion
    target.addIllegalDialect<arith::ArithDialect, scf::SCFDialect,
                             cf::ControlFlowDialect, func::FuncDialect,
                             memref::MemRefDialect, vector::VectorDialect>();

    // During this lowering, we will also be lowering the MemRef types.
    // TODO: per adesso usiamo il converter di default per llvm, forse possiamo
    // modificarlo (ereditarietà?) per convertire memref in llvm.ptr<4>
    LLVMTypeConverter typeConverter(&getContext());

    // NB: l'ordine con cui popolo i pattern non conta! Molto meglio rispetto a
    // fare un lowering manuale con una pass pipeline come facevo prima
    RewritePatternSet patterns(context);
    populateAffineToStdConversionPatterns(patterns);
    populateSCFToControlFlowConversionPatterns(patterns);
    ub::populateUBToLLVMConversionPatterns(typeConverter, patterns);
    arith::populateArithToLLVMConversionPatterns(typeConverter, patterns);
    populateFinalizeMemRefToLLVMConversionPatterns(typeConverter, patterns);
    cf::populateControlFlowToLLVMConversionPatterns(typeConverter, patterns);
    // TODO: il lowering di memrefs con dimensione dinamica non è ammesso anche
    // usando questa opzione 'funcToLLVMOpts.useBarePtrCallConv = true' 😭
    // https://mlir.llvm.org/doxygen/LLVMCommon_2TypeConverter_8cpp_source.html#l00593
    //
    // qua mi espande le memrefs nelle struct complete, io però voglio raw ptrs
    populateFuncToLLVMConversionPatterns(typeConverter, patterns);

    if (failed(applyPartialConversion(module, target, std::move(patterns)))) {
      signalPassFailure();
    }
  }
};

} // namespace
} // namespace mlir::ppu
