- per produrre scf-level mlir
    - cgeist matmul.c -function=* -S

- per passare ad affine
    - cgeist matmul.c -function=* -S -raise-scf-to-affine
