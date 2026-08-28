#ifndef VECTOR_OMP_PASS
#define VECTOR_OMP_PASS

include "mlir/Pass/PassBase.td"

def ConvertLinalgToVectorOMPAlgorithm: Pass<"convert-linalg-to-vector-omp", "::mlir::ModuleOp"> {
  let summary = "Effettua il lowering di alcune linalg named-op ad algoritmi parallelizzati con OpenMP e vettorizzati a mano";
  let description = [{
    Il lowering consiste nel sostituire la linalg op con:

    - Affine ops per il control flow
    - OMP ops per parallelizzare su più thread
    - Vector ops per vettorizzare (omp.simd non funziona)

    In caso di memref con dimensione dimanica si effettua anche uno splitting del
    loop in un main loop vettorizzato e un remainder loop scalare.
  }];

  let dependentDialects = [
    "mlir::memref::MemRefDialect",
    "mlir::affine::AffineDialect",
    "mlir::LLVM::LLVMDialect",
    "mlir::arith::ArithDialect",
    "mlir::vector::VectorDialect",
    "mlir::omp::OpenMPDialect"
  ];
}

#endif // VECTOR_OMP_PASS
