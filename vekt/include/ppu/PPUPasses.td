#ifndef PPU_PASS
#define PPU_PASS

include "mlir/Pass/PassBase.td"

def PPUInsertVecLoad : Pass<"ppu-insert-vec-load", "::mlir::ModuleOp"> {
  let summary = "Insert a fake ppu.vec_load op for debugging";
  let description = [{
    This pass inserts a dummy a ppu.vec_load op and a memref as its argument
    into the module to validate the op definition.
  }];

  let dependentDialects = [
    "mlir::memref::MemRefDialect",
    "mlir::func::FuncDialect"
  ];
}

def PPURaiseAffineToLinalgGeneric: Pass<"ppu-raise-affine-to-linalg-generic", "::mlir::ModuleOp"> {
  let summary = "raises perfect affine loop nests into an equivalent linalg.generic form";
  let description = [{
    ...
  }];

  let dependentDialects = [
    "mlir::linalg::LinalgDialect"
  ];
}

def PPULowerToLLVM : Pass<"ppu-lower-to-llvm", "::mlir::ModuleOp"> {
  let summary = "lower from vectorized affine form to llvm + ppu dialect";
  let description = [{
    ...
  }];

  let dependentDialects = [
    "mlir::memref::MemRefDialect",
    "mlir::arith::ArithDialect",
    "mlir::vector::VectorDialect",
    "mlir::func::FuncDialect",
    "mlir::affine::AffineDialect",
    "mlir::vector::VectorDialect",
    "mlir::LLVM::LLVMDialect",
    "mlir::ub::UBDialect",
    "mlir::ppu::PPUDialect",
    "mlir::scf::SCFDialect"
  ];
}

def ConvertVectorToPPU: Pass<"convert-vector-to-ppu", "::mlir::ModuleOp"> {
  let summary = "lowers vector ops into equivalent ppu ops";
  let description = [{
    il lowering introduce
  }];

  let dependentDialects = [
    "mlir::memref::MemRefDialect",
    "mlir::LLVM::LLVMDialect",
    "mlir::ppu::PPUDialect",
    "mlir::arith::ArithDialect",
  ];
}


#endif // PPU_PASS
