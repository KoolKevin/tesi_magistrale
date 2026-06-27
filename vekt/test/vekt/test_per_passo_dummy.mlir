// RUN: vekt-opt -ppu-switch-bar-foo %s | FileCheck %s
module {
    func.func @bar() {
        %0 = arith.constant 1 : i32
        %res = ppu.foo %0 : i32
        return
    }
}

// CHECK-LABEL:   func.func @foo() {
// CHECK:           return
// CHECK:         }
