#include <cstdio>

#include "ppu/PPUDialect.h"
#include "ppu/PPUOps.h"

using namespace mlir;
using namespace mlir::ppu;

#include "ppu/PPUOpsDialect.cpp.inc"

//===----------------------------------------------------------------------===//
// ppu dialect.
//===----------------------------------------------------------------------===//

void PPUDialect::initialize() {
  addOperations<
#define GET_OP_LIST
#include "ppu/PPUOps.cpp.inc"
      >();

  // rimuoviamo questo dato che impedisce il piping
  //   printf("-------------------------\n");
  //   printf("ppu dialect inizializzato\n");
  //   printf("-------------------------\n");
}
