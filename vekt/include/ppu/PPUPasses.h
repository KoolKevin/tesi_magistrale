#ifndef PPU_PASSES_H
#define PPU_PASSES_H

#include "mlir/Pass/Pass.h"
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
