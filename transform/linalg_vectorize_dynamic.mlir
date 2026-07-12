func.func @matmul(
    %A: memref<?x?xf32>,
    %B: memref<?x?xf32>,
    %C: memref<?x?xf32>
) -> memref<?x?xf32> {

  linalg.matmul ins(%A, %B: memref<?x?xf32>, memref<?x?xf32>)
            outs(%C: memref<?x?xf32>)
  return %C: memref<?x?xf32>
}

// transform

// no peeling
// module attributes {transform.with_named_sequence} {
//   transform.named_sequence @__transform_main(%root: !transform.any_op {transform.readonly}) {
//     // matcho la matmul
//     %matmul = transform.structured.match ops{["linalg.matmul"]} in %root : (!transform.any_op) -> !transform.any_op

//     // 1. Static tiling
//     %tiled_matmul, %loop_1, %loop_2, %loop_3 =
//       transform.structured.tile_using_for %matmul tile_sizes [16, 16, 1] : (!transform.any_op)
//       -> (!transform.any_op, !transform.op<"scf.for">, !transform.op<"scf.for">, !transform.op<"scf.for">)

//     // 2. Vectorize the tiled matmul
//     // NB: le vector sizes devono combaciare con l'iteration space dell'op che
//     // si sta vettorizzando (anche tile)
//     transform.structured.vectorize %tiled_matmul vector_sizes [16, 16, 1] : !transform.any_op

//     transform.yield
//   }
// }

module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main(%root: !transform.any_op {transform.readonly}) {

    %matmul = transform.structured.match ops{["linalg.matmul"]} in %root : (!transform.any_op) -> !transform.any_op

    // 1. tiling alla dimensione del registro vettoriale
    %tiled, %li, %lj, %lk =
      transform.structured.tile_using_for %matmul tile_sizes [16, 1, 1]
      : (!transform.any_op) -> (!transform.any_op, !transform.op<"scf.for">, !transform.op<"scf.for">, !transform.op<"scf.for">)

    // 2. peel il loop esterno (M)
    // NB: transform.loop.peel -> updates the given loop so that its step evenly
    // divides its range and puts the remaining iteration into a separate loop
    // or a conditional. In the absence of sufficient static information, this
    // op may peel a loop, even if the step always divides the range evenly at
    // runtime.
    %main_i, %rem_i = transform.loop.peel %li : (!transform.op<"scf.for">) -> (!transform.op<"scf.for">, !transform.op<"scf.for">)


    // 3. vettorizza il loop peeled
    %matmul_main = transform.structured.match ops{["linalg.matmul"]} in %main_i : (!transform.op<"scf.for">) -> !transform.any_op
    transform.structured.vectorize %matmul_main vector_sizes [16, 1, 1] : !transform.any_op   // M pieno, N pieno   -> NIENTE masking

    // // 4. vettorizza il remainder loop
    // %matmul_rem = transform.structured.match ops{["linalg.matmul"]} in %rem_i : (!transform.op<"scf.for">) -> !transform.any_op
    // transform.structured.vectorize %matmul_rem vector_sizes [16, 1, 1] : !transform.any_op   // M pieno, N pieno   -> NIENTE masking


    transform.yield
  }
}


// // with peeling
// module attributes {transform.with_named_sequence} {
//   transform.named_sequence @__transform_main(%root: !transform.any_op {transform.readonly}) {
//     // matcho la matmul
//     %matmul = transform.structured.match ops{["linalg.matmul"]} in %root : (!transform.any_op) -> !transform.any_op

//     // 1. Static tiling
//     %_, %loop_1, %loop_2, %loop_3 =
//       transform.structured.tile_using_for %matmul tile_sizes [8, 16, 1] : (!transform.any_op)
//       -> (!transform.any_op, !transform.op<"scf.for">, !transform.op<"scf.for">, !transform.op<"scf.for">)

//     // 2. Loop peeling (still on the middle dimension, if needed)
//     %main_loop, %remainder_loop = transform.loop.peel %loop_2 : (!transform.op<"scf.for">) -> (!transform.op<"scf.for">, !transform.op<"scf.for">)

//     // 3. Vectorize the main loop
//     %matmul_main = transform.structured.match ops{["linalg.matmul"]} in %main_loop : (!transform.op<"scf.for">) -> !transform.any_op
//     transform.structured.vectorize %matmul_main vector_sizes [8, 16, 1] : !transform.any_op

//     // 4. Vectorize the remainder loop
//     %matmul_remainder = transform.structured.match ops{["linalg.matmul"]} in %remainder_loop : (!transform.op<"scf.for">) -> !transform.any_op
//     transform.structured.vectorize %matmul_remainder vector_sizes [8, 16, 1] : !transform.any_op

//     transform.yield
//   }
// }
