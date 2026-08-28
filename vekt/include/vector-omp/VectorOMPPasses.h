#ifndef VECTOR_OMP_H
#define VECTOR_OMP_H

#include "mlir/Pass/Pass.h"

// Extra includes needed for dependent dialects
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/OpenMP/OpenMPDialect.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/UB/IR/UBOps.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"

#include <memory>

namespace mlir {
namespace vector_omp {
#define GEN_PASS_DECL
#include "vector-omp/VectorOMPPasses.h.inc"

#define GEN_PASS_REGISTRATION
#include "vector-omp/VectorOMPPasses.h.inc"
} // namespace vector_omp
} // namespace mlir

#endif // VECTOR_OMP_H
