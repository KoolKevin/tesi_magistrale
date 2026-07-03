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

// TODO: vedi se puoi convertire le memrefs in raw llvm.ptr mediante un
// TypeConverter
// class PolyToStandardTypeConverter : public TypeConverter {
//  public:
//   PolyToStandardTypeConverter(MLIRContext *ctx) {
//     addConversion([](Type type) { return type; });
//     addConversion([ctx](PolynomialType type) -> Type {
//       int degreeBound = type.getDegreeBound();
//       IntegerType elementTy =
//           IntegerType::get(ctx, 32,
//           IntegerType::SignednessSemantics::Signless);
//       return RankedTensorType::get({degreeBound}, elementTy);
//     });
//   }
// };

/* conversion pattern custom */

struct ConvertVectorTransferRead
    : public OpConversionPattern<mlir::vector::TransferReadOp> {
  ConvertVectorTransferRead(mlir::MLIRContext *context)
      : OpConversionPattern<mlir::vector::TransferReadOp>(context) {}

  using OpConversionPattern::OpConversionPattern;

  LogicalResult
  matchAndRewrite(mlir::vector::TransferReadOp op, OpAdaptor adaptor,
                  ConversionPatternRewriter &rewriter) const override {

    // TODO: add address computation with GEP instruction
    // Recuperiamo il pointer dalla memref e usiamo come argomento per
    // ppu.vec_load:
    // %0 = memref.extract_aligned_pointer_as_index %arg : memref<4xf32>->index
    // %1 = arith.index_cast %0 : index to i64
    // %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    // %3 = ppu.vec_load %2 !llvm.ptr -> vector<16xi32>
    auto extractOp = rewriter.create<memref::ExtractAlignedPointerAsIndexOp>(
        op.getLoc(), adaptor.getSource());
    auto indexCastOp = rewriter.create<arith::IndexCastOp>(
        op.getLoc(), rewriter.getI64Type(), extractOp);
    // NB: qua stiamo hardcodando l'addrespace(4) della PPU
    auto PPUPtrTy = LLVM::LLVMPointerType::get(rewriter.getContext(), 4);
    auto intToPtrOp =
        rewriter.create<LLVM::IntToPtrOp>(op.getLoc(), PPUPtrTy, indexCastOp);
    auto vecTy = VectorType::get({16}, rewriter.getI32Type());
    auto ppuVecLoadOp =
        rewriter.create<ppu::VecLoadOp>(op.getLoc(), vecTy, intToPtrOp);

    rewriter.replaceOp(op.getOperation(), ppuVecLoadOp.getRes());

    return success();
  }
};

struct ConvertVectorToPPU : impl::ConvertVectorToPPUBase<ConvertVectorToPPU> {
  using ConvertVectorToPPUBase::ConvertVectorToPPUBase;

  void runOnOperation() override {
    MLIRContext *context = &getContext();
    ModuleOp module = getOperation();

    ConversionTarget target(*context);

    target.addLegalDialect<ppu::PPUDialect, LLVM::LLVMDialect,
                           arith::ArithDialect, memref::MemRefDialect>();
    target.addIllegalOp<vector::TransferReadOp>();

    RewritePatternSet patterns(context);
    // my pattern takes a context so i need to pass it here aswell. If my
    // pattern also had a TypeConverter, i would need to specify that as well
    patterns.add<ConvertVectorTransferRead>(context);
    // populateAffineToStdConversionPatterns(patterns);

    if (failed(applyPartialConversion(module, target, std::move(patterns)))) {
      signalPassFailure();
    }
  }
};

//===----------------------------------------------------------------------===//
// PPULowerToLLVM
//===----------------------------------------------------------------------===//

// TODO: vedi se puoi convertire le memrefs in raw llvm.ptr mediante un
// TypeConverter
// class PolyToStandardTypeConverter : public TypeConverter {
//  public:
//   PolyToStandardTypeConverter(MLIRContext *ctx) {
//     addConversion([](Type type) { return type; });
//     addConversion([ctx](PolynomialType type) -> Type {
//       int degreeBound = type.getDegreeBound();
//       IntegerType elementTy =
//           IntegerType::get(ctx, 32,
//           IntegerType::SignednessSemantics::Signless);
//       return RankedTensorType::get({degreeBound}, elementTy);
//     });
//   }
// };

/* conversion pattern custom */

// struct ConvertAdd : public OpConversionPattern<AddOp> {
//   ConvertAdd(mlir::MLIRContext *context)
//       : OpConversionPattern<AddOp>(context) {}

//   using OpConversionPattern::OpConversionPattern;

//   LogicalResult matchAndRewrite(
//       AddOp op, OpAdaptor adaptor,
//       ConversionPatternRewriter &rewriter) const override {
//     // TODO: implement
//     return success();
//   }
// };

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
