#map = affine_map<()[s0] -> ((s0 floordiv 16) * 16)>
#map1 = affine_map<(d0, d1) -> (d0, 0, d1)>
#map2 = affine_map<(d0, d1) -> (0, d1, d0)>
#map3 = affine_map<(d0)[s0] -> (-d0 + s0)>
module {
  func.func @matmul(%arg0: memref<?x?xf32>, %arg1: memref<?x?xf32>, %arg2: memref<?x?xf32>) -> memref<?x?xf32> {
    %0 = ub.poison : f32
    %c16 = arith.constant 16 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %dim = memref.dim %arg0, %c0 : memref<?x?xf32>
    %dim_0 = memref.dim %arg0, %c1 : memref<?x?xf32>
    %dim_1 = memref.dim %arg1, %c1 : memref<?x?xf32>
    %1 = affine.apply #map()[%dim]
    scf.for %arg3 = %c0 to %1 step %c16 {
      scf.for %arg4 = %c0 to %dim_1 step %c1 {
        scf.for %arg5 = %c0 to %dim_0 step %c1 {
          %subview = memref.subview %arg0[%arg3, %arg5] [16, 1] [1, 1] : memref<?x?xf32> to memref<16x1xf32, strided<[?, 1], offset: ?>>
          %subview_2 = memref.subview %arg1[%arg5, %arg4] [1, 1] [1, 1] : memref<?x?xf32> to memref<1x1xf32, strided<[?, 1], offset: ?>>
          %subview_3 = memref.subview %arg2[%arg3, %arg4] [16, 1] [1, 1] : memref<?x?xf32> to memref<16x1xf32, strided<[?, 1], offset: ?>>
          %2 = vector.transfer_read %subview[%c0, %c0], %0 {in_bounds = [true, true, true], permutation_map = #map1} : memref<16x1xf32, strided<[?, 1], offset: ?>>, vector<16x1x1xf32>
          %3 = vector.transfer_read %subview_2[%c0, %c0], %0 {in_bounds = [true, true, true], permutation_map = #map2} : memref<1x1xf32, strided<[?, 1], offset: ?>>, vector<16x1x1xf32>
          %4 = vector.transfer_read %subview_3[%c0, %c0], %0 {in_bounds = [true, true]} : memref<16x1xf32, strided<[?, 1], offset: ?>>, vector<16x1xf32>
          %5 = arith.mulf %2, %3 : vector<16x1x1xf32>
          %6 = vector.shape_cast %5 : vector<16x1x1xf32> to vector<16x1xf32>
          %7 = arith.addf %4, %6 : vector<16x1xf32>
          vector.transfer_write %7, %subview_3[%c0, %c0] {in_bounds = [true, true]} : vector<16x1xf32>, memref<16x1xf32, strided<[?, 1], offset: ?>>
        }
      }
    }
    scf.for %arg3 = %1 to %dim step %c16 {
      scf.for %arg4 = %c0 to %dim_1 step %c1 {
        scf.for %arg5 = %c0 to %dim_0 step %c1 {
          %2 = affine.apply #map3(%arg3)[%dim]
          %subview = memref.subview %arg0[%arg3, %arg5] [%2, 1] [1, 1] : memref<?x?xf32> to memref<?x1xf32, strided<[?, 1], offset: ?>>
          %subview_2 = memref.subview %arg1[%arg5, %arg4] [1, 1] [1, 1] : memref<?x?xf32> to memref<1x1xf32, strided<[?, 1], offset: ?>>
          %subview_3 = memref.subview %arg2[%arg3, %arg4] [%2, 1] [1, 1] : memref<?x?xf32> to memref<?x1xf32, strided<[?, 1], offset: ?>>
          linalg.matmul ins(%subview, %subview_2 : memref<?x1xf32, strided<[?, 1], offset: ?>>, memref<1x1xf32, strided<[?, 1], offset: ?>>) outs(%subview_3 : memref<?x1xf32, strided<[?, 1], offset: ?>>)
        }
      }
    }
    return %arg2 : memref<?x?xf32>
  }
  module attributes {transform.with_named_sequence} {
    transform.named_sequence @__transform_main(%arg0: !transform.any_op {transform.readonly}) {
      %0 = transform.structured.match ops{["linalg.matmul"]} in %arg0 : (!transform.any_op) -> !transform.any_op
      %tiled_linalg_op, %loops:3 = transform.structured.tile_using_for %0 tile_sizes [16, 1, 1] : (!transform.any_op) -> (!transform.any_op, !transform.op<"scf.for">, !transform.op<"scf.for">, !transform.op<"scf.for">)
      %peeled_loop, %remainder_loop = transform.loop.peel %loops#0 : (!transform.op<"scf.for">) -> (!transform.op<"scf.for">, !transform.op<"scf.for">)
      %1 = transform.structured.match ops{["linalg.matmul"]} in %peeled_loop : (!transform.op<"scf.for">) -> !transform.any_op
      transform.structured.vectorize %1 vector_sizes [16, 1, 1] : !transform.any_op
      transform.yield 
    }
  }
}

