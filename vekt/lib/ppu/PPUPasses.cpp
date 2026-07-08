#include "mlir/Conversion/LLVMCommon/LoweringOptions.h"
#include "mlir/Conversion/LLVMCommon/Pattern.h" // ConvertOpToLLVMPattern
#include "mlir/Conversion/LLVMCommon/TypeConverter.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlow.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Rewrite/FrozenRewritePatternSet.h"
#include "mlir/Transforms/DialectConversion.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "mlir/Transforms/WalkPatternRewriteDriver.h"
#include "llvm/ADT/STLExtras.h"

// conversion patterns
#include "mlir/Conversion/AffineToStandard/AffineToStandard.h"
#include "mlir/Conversion/ArithToLLVM/ArithToLLVM.h"
#include "mlir/Conversion/ControlFlowToLLVM/ControlFlowToLLVM.h"
#include "mlir/Conversion/FuncToLLVM/ConvertFuncToLLVM.h"
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
#include "ppu/PPUPasses.h.inc"

namespace {

//===----------------------------------------------------------------------===//
// PPUInsertVecLoad (passo di prova)
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

struct ConvertVectorTransferWrite
    : public OpRewritePattern<mlir::vector::TransferWriteOp> {

  ConvertVectorTransferWrite(mlir::MLIRContext *context)
      : OpRewritePattern<mlir::vector::TransferWriteOp>(context) {}

  using OpRewritePattern::OpRewritePattern;

  LogicalResult matchAndRewrite(mlir::vector::TransferWriteOp op,
                                PatternRewriter &rewriter) const final {

    // Trasformiamo questo:
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
    // recuperiamo il tipo di dato puntato dalla memref (si continua a chiamare
    // source e non dest)
    Type elemTy = op.getSource().getType().getElementType();
    Value finalPtr = basePtr;
    if (!gepIndices.empty()) {
      auto gepOp = rewriter.create<LLVM::GEPOp>(op.getLoc(), PPUPtrTy, elemTy,
                                                basePtr, gepIndices);
      finalPtr = gepOp.getResult();
    }

    auto ppuVecStoreOp =
        rewriter.create<ppu::VecStoreOp>(op.getLoc(), op.getVector(), finalPtr);

    rewriter.replaceOp(op.getOperation(), ppuVecStoreOp);

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
    patterns.add<ConvertVectorTransferRead, ConvertVectorTransferWrite>(ctx);
    // Post-order, forward walk traversal of ops (excluding input `op`).
    walkAndApplyPatterns(module, std::move(patterns));
  }
};

//===----------------------------------------------------------------------===//
// PPULowerToLLVM
//===----------------------------------------------------------------------===//

// Convertiamo le memref direttamente in raw.ptr, buttando via
// rank/shape/stride. Questo è corretto perché Polygeist produce sempre
// memref<?xT> e quindi questa informazione non c'è in primo luogo
class PPUTypeConverter : public LLVMTypeConverter {
public:
  // ereditiamo da LLVMTypeConverter, appendiamo semplicemente la nostra
  // gestione custome per le memref
  PPUTypeConverter(MLIRContext *ctx, const LowerToLLVMOptions &options)
      : LLVMTypeConverter(ctx, options) {
    addConversion([](MemRefType type) -> Type {
      // NB: hardcodiamo l'address space(4) della PPU
      return LLVM::LLVMPointerType::get(type.getContext(), 4);
    });
  }
};

// func.func -> llvm.func: versione minimale, senza passare per
// LLVMTypeConverter::convertFunctionSignature (che è quella che hardcoda
// il trattamento speciale delle memref).
//
// NB: a differenza della maggior parte dei pattern, qui l'adaptor NON viene
// mai usato.
// - func::FuncOp non ha operandi SSA (non riceve valori) quindi l'adaptor
// generato per lei è vuoto.
// - i tipi della firma e i corrispondenti parametri formali vivono
// rispettivamente: in un attributo (function_type) e nei block argument
// dell'entry block della regione associata all'op
//      -> NESSUNO DEI DUE PASSA PER LA SOSTITUZIONE AUTOMATICA DEGLI
//      OPERANDI CHE IL FRAMEWORK DI DIALECT CONVERSION FA AUTOMATICAMENTE
//      TRAMITE L'ADAPTOR.
// - Per questo dobbiamo convertire i tipi a mano con `converter->convertType()`
// (per la firma) e con `applySignatureConversion` (per i block argument del
// corpo) invece di leggerli già pronti da `adaptor`.
struct PPUFuncOpLowering : public OpConversionPattern<func::FuncOp> {
  using OpConversionPattern::OpConversionPattern;

  LogicalResult
  matchAndRewrite(func::FuncOp funcOp, OpAdaptor adaptor,
                  ConversionPatternRewriter &rewriter) const override {
    // recupero il tipo della funzione dall'attributo
    auto originalType = funcOp.getFunctionType();
    // recupero il converter e un helper per fare le conversioni necessarie a
    // mano
    const auto *converter = getTypeConverter();
    TypeConverter::SignatureConversion sigConversion(
        originalType.getNumInputs());

    // otteniamo gli argomenti della funzione convertiti
    SmallVector<Type> argTypes;
    for (auto [idx, t] : llvm::enumerate(originalType.getInputs())) {
      Type converted = converter->convertType(t);
      if (!converted)
        return rewriter.notifyMatchFailure(
            funcOp, "impossibile convertire il tipo di un argomento");
      argTypes.push_back(converted);
      sigConversion.addInputs(idx, converted);
    }

    // otteniamo i return types convertiti
    Type resultType;
    if (originalType.getNumResults() == 0) {
      resultType = LLVM::LLVMVoidType::get(rewriter.getContext());
    } else if (originalType.getNumResults() == 1) {
      resultType = converter->convertType(originalType.getResult(0));
      if (!resultType)
        return rewriter.notifyMatchFailure(
            funcOp, "impossibile convertire il tipo di ritorno");
    } else {
      return rewriter.notifyMatchFailure(
          funcOp, "funzioni con più di un risultato non sono supportate");
    }

    // creo una nuova funzione con i tipi convertiti
    auto llvmFuncType =
        LLVM::LLVMFunctionType::get(resultType, argTypes, false);
    auto newFuncOp = rewriter.create<LLVM::LLVMFuncOp>(
        funcOp.getLoc(), funcOp.getName(), llvmFuncType);
    newFuncOp.setVisibility(funcOp.getVisibility());
    // copio il corpo della vecchia funzione
    rewriter.inlineRegionBefore(funcOp.getBody(), newFuncOp.getBody(),
                                newFuncOp.end());

    if (!newFuncOp.getBody().empty())
      rewriter.applySignatureConversion(&newFuncOp.getBody().front(),
                                        sigConversion, converter);
    rewriter.eraseOp(funcOp);

    return success();
  }
};

// func.return -> llvm.return: gli operandi sono già nella forma giusta
// (nessun descriptor da spacchettare), quindi è un forward diretto.
struct PPUReturnOpLowering : public OpConversionPattern<func::ReturnOp> {
  using OpConversionPattern::OpConversionPattern;

  LogicalResult
  matchAndRewrite(func::ReturnOp op, OpAdaptor adaptor,
                  ConversionPatternRewriter &rewriter) const override {
    rewriter.replaceOpWithNewOp<LLVM::ReturnOp>(op, adaptor.getOperands());
    return success();
  }
};

// memref.load %mem[%idx0, ...] -> llvm.getelementptr + llvm.load
// %mem è ormai un !llvm.ptr grezzo (grazie a PPUTypeConverter), quindi
// costruiamo l'indirizzo con una GEP lineare sugli indici, esattamente come
// già facevi in ConvertVectorTransferRead per la vec_load.
struct MemRefLoadOpLowering : public OpConversionPattern<memref::LoadOp> {
  using OpConversionPattern::OpConversionPattern;

  LogicalResult
  matchAndRewrite(memref::LoadOp op, OpAdaptor adaptor,
                  ConversionPatternRewriter &rewriter) const override {
    Type elemTy = op.getMemRefType().getElementType();
    Type llvmElemTy = getTypeConverter()->convertType(elemTy);
    if (!llvmElemTy)
      return rewriter.notifyMatchFailure(op, "tipo elemento non convertibile");

    Value basePtr = adaptor.getMemref(); // già un !llvm.ptr
    SmallVector<Value> gepIndices;
    for (Value idx : adaptor.getIndices()) {
      auto castedIdx = rewriter.create<arith::IndexCastOp>(
          op.getLoc(), rewriter.getI64Type(), idx);
      gepIndices.push_back(castedIdx);
    }

    Value finalPtr = basePtr;
    if (!gepIndices.empty()) {
      auto PPUPtrTy = LLVM::LLVMPointerType::get(rewriter.getContext(), 4);
      finalPtr = rewriter.create<LLVM::GEPOp>(op.getLoc(), PPUPtrTy, llvmElemTy,
                                              basePtr, gepIndices);
    }

    rewriter.replaceOpWithNewOp<LLVM::LoadOp>(op, llvmElemTy, finalPtr);
    return success();
  }
};

// memref.store %val, %mem[%idx0, ...] -> llvm.getelementptr + llvm.store
struct MemRefStoreOpLowering : public OpConversionPattern<memref::StoreOp> {
  using OpConversionPattern::OpConversionPattern;

  LogicalResult
  matchAndRewrite(memref::StoreOp op, OpAdaptor adaptor,
                  ConversionPatternRewriter &rewriter) const override {
    Type elemTy = op.getMemRefType().getElementType();
    Type llvmElemTy = getTypeConverter()->convertType(elemTy);
    if (!llvmElemTy)
      return rewriter.notifyMatchFailure(op, "tipo elemento non convertibile");

    Value basePtr = adaptor.getMemref();
    SmallVector<Value> gepIndices;
    for (Value idx : adaptor.getIndices()) {
      auto castedIdx = rewriter.create<arith::IndexCastOp>(
          op.getLoc(), rewriter.getI64Type(), idx);
      gepIndices.push_back(castedIdx);
    }

    Value finalPtr = basePtr;
    if (!gepIndices.empty()) {
      auto PPUPtrTy = LLVM::LLVMPointerType::get(rewriter.getContext(), 4);
      finalPtr = rewriter.create<LLVM::GEPOp>(op.getLoc(), PPUPtrTy, llvmElemTy,
                                              basePtr, gepIndices);
    }

    rewriter.replaceOpWithNewOp<LLVM::StoreOp>(op, adaptor.getValue(),
                                               finalPtr);
    return success();
  }
};

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
    LowerToLLVMOptions options(context);
    PPUTypeConverter typeConverter(context, options);
    // TODO: queste potrebbe essere necessario, controlla
    // LLVMTypeConverter typeConverter(&getContext());

    // NB: l'ordine con cui popolo i pattern non conta! Molto meglio rispetto a
    // fare un lowering manuale con una pass pipeline come facevo prima
    RewritePatternSet patterns(context);
    populateAffineToStdConversionPatterns(patterns);
    populateSCFToControlFlowConversionPatterns(patterns);
    ub::populateUBToLLVMConversionPatterns(typeConverter, patterns);
    arith::populateArithToLLVMConversionPatterns(typeConverter, patterns);
    cf::populateControlFlowToLLVMConversionPatterns(typeConverter, patterns);

    // TODO: il lowering di memrefs con dimensione dinamica non è ammesso anche
    // usando questa opzione 'funcToLLVMOpts.useBarePtrCallConv = true' 😭
    // https://mlir.llvm.org/doxygen/LLVMCommon_2TypeConverter_8cpp_source.html#l00593
    //
    // qua mi espande le memrefs nelle struct complete, io però voglio raw ptrs
    //
    // inoltre
    //  - structFuncArgTypeConverter
    //  - convertFunctionSignatureImpl
    //  - convertFunctionSignature
    // https://mlir.llvm.org/doxygen/FuncToLLVM_8cpp_source.html#l00297
    //  - convertFuncSignature
    // populateFuncToLLVMConversionPatterns(typeConverter, patterns);
    // populateFinalizeMemRefToLLVMConversionPatterns(typeConverter, patterns);

    // NB: non usiamo più populateFinalizeMemRefToLLVMConversionPatterns né
    // populateFuncToLLVMConversionPatterns: entrambe assumono che le memref
    // vengano abbassate a descriptor
    patterns.add<PPUFuncOpLowering, PPUReturnOpLowering, MemRefLoadOpLowering,
                 MemRefStoreOpLowering>(typeConverter, context);

    if (failed(applyPartialConversion(module, target, std::move(patterns)))) {
      signalPassFailure();
    }
  }
};

} // namespace
} // namespace mlir::ppu
