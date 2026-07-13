// func.func @matmul(
//     %A: memref<?x?xf32>,
//     %B: memref<?x?xf32>,
//     %C: memref<?x?xf32>
// ) -> memref<?x?xf32> {

//   linalg.matmul ins(%A, %B: memref<?x?xf32>, memref<?x?xf32>)
//             outs(%C: memref<?x?xf32>)
//   return %C: memref<?x?xf32>
// }

// func.func @dotp(
//     %A: memref<?xf32>,
//     %B: memref<?xf32>,
//     %C: memref<f32>
// ) -> memref<f32> {

//   linalg.dot ins(%A, %B: memref<?xf32>, memref<?xf32>)
//             outs(%C: memref<f32>)
//   return %C: memref<f32>
// }

func.func @conv2d(
    %Input: memref<?x?xf32>,
    %Filter: memref<?x?xf32>,
    %Output: memref<?x?xf32>
) -> memref<?x?xf32> {

  linalg.conv_2d
    ins(%Input, %Filter : memref<?x?xf32>, memref<?x?xf32>)
    outs(%Output : memref<?x?xf32>)

  return %Output : memref<?x?xf32>
}



// per matmul
// module attributes {transform.with_named_sequence} {
//   transform.named_sequence @__transform_main(%root: !transform.any_op {transform.readonly}) {
//     // matcho la matmul
//     %matmul = transform.structured.match ops{["linalg.matmul"]} in %root : (!transform.any_op) -> !transform.any_op

//     %generalized = transform.structured.generalize %matmul : (!transform.any_op) -> !transform.any_op

//     // sembra che venga vettorizzata allo stesso modo
//     transform.structured.vectorize %generalized vector_sizes [16, 1, 1] : !transform.any_op

//     transform.yield
//   }
// }

// per dotp
// module attributes {transform.with_named_sequence} {
//   transform.named_sequence @__transform_main(%root: !transform.any_op {transform.readonly}) {
//     %dotp = transform.structured.match ops{["linalg.dot"]} in %root : (!transform.any_op) -> !transform.any_op

//     // %generalized = transform.structured.generalize %matmul : (!transform.any_op) -> !transform.any_op


//     // il tiling che mi fa coprire tutto l'iteration space. Se uso solo la
//     // vettorizzazione, utilizzo solamente un vettore grande 'vector_sizes'
//     %tiled_dotp, %loop =
//       transform.structured.tile_using_for %dotp tile_sizes [16] : (!transform.any_op)
//         -> (!transform.any_op, !transform.op<"scf.for">)

//     // peeling per evitare maschere
//     %main_loop, %rem_loop = transform.loop.peel %loop : (!transform.op<"scf.for">)
//         -> (!transform.op<"scf.for">, !transform.op<"scf.for">)

//     // vettorizziamo main loop e lasciamo remainder loop scalare
//     %main_dotp = transform.structured.match ops{["linalg.dot"]} in %main_loop : (!transform.op<"scf.for">)
//         -> !transform.any_op
//     transform.structured.vectorize %main_dotp vector_sizes [16] : !transform.any_op

//     transform.yield
//   }
// }

// per conv2d
module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main(%root: !transform.any_op {transform.readonly}) {
    %conv = transform.structured.match ops{["linalg.conv_2d"]} in %root : (!transform.any_op) -> !transform.any_op

    %generalized = transform.structured.generalize %conv : (!transform.any_op) -> !transform.any_op

    transform.yield
  }
}
