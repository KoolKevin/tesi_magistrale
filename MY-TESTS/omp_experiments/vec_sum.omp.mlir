llvm.func @vec_sum_omp(%a : !llvm.ptr, %b : !llvm.ptr, %c : !llvm.ptr, %n : i64, %num_threads : i32) {
    %c0 = llvm.mlir.constant(0) : i64
    %c1 = llvm.mlir.constant(1) : i64

    // Region parallela con clausola num_threads
    omp.parallel num_threads(%num_threads : i32) {
        omp.wsloop {
            omp.simd {
                omp.loop_nest (%i) : i64 = (%c0) to (%n) step (%c1) {
                    %a_ptr = llvm.getelementptr %a[%i] : (!llvm.ptr, i64) -> !llvm.ptr, i8
                    %b_ptr = llvm.getelementptr %b[%i] : (!llvm.ptr, i64) -> !llvm.ptr, i8
                    %c_ptr = llvm.getelementptr %c[%i] : (!llvm.ptr, i64) -> !llvm.ptr, i8

                    %val_a = llvm.load %a_ptr : !llvm.ptr -> i8
                    %val_b = llvm.load %b_ptr : !llvm.ptr -> i8
                    %val_c = llvm.add %val_a, %val_b : i8

                    llvm.store %val_c, %c_ptr : i8, !llvm.ptr
                    omp.yield
                }
            } {omp.composite} // attributo per marcare la composizione delle clauses
        } {omp.composite}
        omp.terminator
    }

    llvm.return
}
