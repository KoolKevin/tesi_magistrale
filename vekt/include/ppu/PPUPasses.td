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



#endif // PPU_PASS
