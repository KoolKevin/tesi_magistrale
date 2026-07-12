func.func @matmul(
    %A: memref<?x?xf32>,
    %B: memref<?x?xf32>,
    %C: memref<?x?xf32>
) -> memref<?x?xf32> {

  linalg.matmul ins(%A, %B: memref<?x?xf32>, memref<?x?xf32>)
            outs(%C: memref<?x?xf32>)
  return %C: memref<?x?xf32>
}


module attributes {transform.with_named_sequence} {
  transform.named_sequence @__transform_main(%root: !transform.any_op {transform.readonly}) {
    // matcho la matmul
    %matmul = transform.structured.match ops{["linalg.matmul"]} in %root : (!transform.any_op) -> !transform.any_op

    %generalized = transform.structured.generalize %matmul : (!transform.any_op) -> !transform.any_op

    // sembra che venga vettorizzata allo stesso modo
    // transform.structured.vectorize %generalized vector_sizes [16, 1, 1] : !transform.any_op

    transform.yield
  }
}

