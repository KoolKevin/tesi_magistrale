mlir-opt -convert-openmp-to-llvm vec_sum.omp.mlir -canonicalize | mlir-translate -mlir-to-llvmir
