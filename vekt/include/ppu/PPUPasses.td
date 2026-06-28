#ifndef PPU_PASS
#define PPU_PASS

include "mlir/Pass/PassBase.td"

def PPUSwitchBarFoo: Pass<"ppu-switch-bar-foo", "::mlir::ModuleOp"> {
  let summary = "Switches the name of a FuncOp named `bar` to `foo` and folds.";
  let description = [{
    Switches the name of a FuncOp named `bar` to `foo` and folds.
    ```
    func.func @bar() {
      return
    }
    // Gets transformed to:
    func.func @foo() {
      return
    }
    ```
  }];
}

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

#endif // PPU_PASS
