// NB: IR ottenuta tramite il seguente comando contorto:
//
// ```
//   build/bin/vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic test/vekt/raising/vec_sum.affine.mlir |
//     ~/llvm-project/build/bin/mlir-opt -linalg-morph-ops="generic-to-named named-to-category"
// ```
//
// Devo fare questo giro strano dato che sto usando mlir 20 che non supporta il passo "linalg-morph-ops"
// (solo un passo deprecato chiamto -linalg-specialize-specialize-generic-ops che non gestisce molti casi).
// Anche questa mia soluzione non è il massimo dato che ad esempio non specializza vec_sum se uso i32 al
// al posto di f32, dovrei passare a mlir 24 (qua ho cambiato il tipo a mano). Chiaramente, la soluzione
// migliore sarebbe scrivere il mio passo di specializzazione.

// func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
//   linalg.elementwise kind=#linalg.elementwise_kind<add> ins(%arg0, %arg1 : memref<?xi32>, memref<?xi32>) outs(%arg2 : memref<?xi32>)
//   return
// }

// NB: alla fine ho deciso di rimanere in mlir20 e utilizzare il passo di specializzazione antiquato
//  dato che mlir20 non ha linalg.elementwise ma piuttosto separa in elemwise_binary ed elemwise_unary.

// RUN: vekt-opt -ppu-normalize-iterargs-reductions -ppu-raise-affine-to-linalg-generic %s | FileCheck %s

func.func @vec_sum(%arg0: memref<?xi32>, %arg1: memref<?xi32>, %arg2: memref<?xi32>, %arg3: i32) attributes {llvm.linkage = #llvm.linkage<external>} {
    linalg.add ins(%arg0, %arg1 : memref<?xi32>, memref<?xi32>) outs(%arg2 : memref<?xi32>)

    return
}
