#ifndef PPU_PASSES_H
#define PPU_PASSES_H

#include "mlir/Pass/Pass.h"

// Extra includes needed for dependent dialects
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/Dialect/DLTI/DLTI.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/Linalg/IR/Linalg.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/UB/IR/UBOps.h"
#include "mlir/Dialect/Vector/IR/VectorOps.h"

#include "ppu/PPUDialect.h"
#include "ppu/PPUOps.h"

#include <memory>

namespace mlir {
namespace ppu {
#define GEN_PASS_DECL
#include "ppu/PPUPasses.h.inc"

#define GEN_PASS_REGISTRATION
#include "ppu/PPUPasses.h.inc"
} // namespace ppu
} // namespace mlir

#endif // PPU_PASSES_H
