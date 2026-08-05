// RUN: vekt-opt -ppu-specialize-affine-nests %s | FileCheck %s

// NB: qua non riesco a fare raising a linalg.generic dato che i miei accessi
// usano la dimensione della finestra di pooling come simbolo. I simboli non
// sono permessi nelle indexing_map degli operandi di una linalg.generic

// IR prodotta con:
// build/bin/vekt-opt -ppu-normalize-iterargs-reductions test/vekt/specialization/max_pooling.affine.mlir

module {
  func.func @max_pooling(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: memref<?x?xi32>, %arg6: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %c-1_i32 = arith.constant -1 : i32
    %0 = arith.index_cast %arg4 : i32 to index
    %1 = arith.index_cast %arg0 : i32 to index
    %2 = arith.index_cast %arg1 : i32 to index
    affine.for %arg7 = 0 to %1 {
      affine.for %arg8 = 0 to %2 {
        affine.store %c-1_i32, %arg5[%arg7, %arg8] : memref<?x?xi32>
      }
    }
    affine.for %arg7 = 0 to %1 {
      affine.for %arg8 = 0 to %2 {
        affine.for %arg9 = 0 to %0 {
          affine.for %arg10 = 0 to %0 {
            %3 = affine.load %arg5[%arg7, %arg8] : memref<?x?xi32>
            %4 = affine.load %arg6[%arg9 + %arg7 * symbol(%0), %arg10 + %arg8 * symbol(%0)] : memref<?x?xi32>
            %5 = arith.cmpi sgt, %4, %3 : i32
            %6 = arith.select %5, %4, %3 : i32
            affine.store %6, %arg5[%arg7, %arg8] : memref<?x?xi32>
          }
        }
      }
    }
    return
  }
}

// CHECK-LABEL:   func.func @max_pooling(
// CHECK-SAME:      %[[ARG0:.*]]: i32, %[[ARG1:.*]]: i32, %[[ARG2:.*]]: i32, %[[ARG3:.*]]: i32, %[[ARG4:.*]]: i32, %[[ARG5:.*]]: memref<?x?xi32>, %[[ARG6:.*]]: memref<?x?xi32>) attributes {llvm.linkage = #llvm.linkage<external>} {
// CHECK:           %[[CONSTANT_0:.*]] = arith.constant -1 : i32
// CHECK:           %[[INDEX_CAST_0:.*]] = arith.index_cast %[[ARG4]] : i32 to index
// CHECK:           %[[INDEX_CAST_1:.*]] = arith.index_cast %[[ARG0]] : i32 to index
// CHECK:           %[[INDEX_CAST_2:.*]] = arith.index_cast %[[ARG1]] : i32 to index
// CHECK:           affine.for %[[VAL_0:.*]] = 0 to %[[INDEX_CAST_1]] {
// CHECK:             affine.for %[[VAL_1:.*]] = 0 to %[[INDEX_CAST_2]] {
// CHECK:               affine.store %[[CONSTANT_0]], %[[ARG5]]{{\[}}%[[VAL_0]], %[[VAL_1]]] : memref<?x?xi32>
// CHECK:             }
// CHECK:           }
// CHECK:           "ppu.max_pool_2d"(%[[ARG6]], %[[INDEX_CAST_0]], %[[ARG5]]) : (memref<?x?xi32>, index, memref<?x?xi32>) -> ()
// CHECK:           return
// CHECK:         }
