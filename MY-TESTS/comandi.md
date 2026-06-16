- compilazione normale
    - ccac -tcf=ev71_vfpu -O2 matmul.c main.c

- compilazione per LLVM-IR
    - ccac -tcf=ev71_vfpu -O2 -BS matmul.c main.c

- esecuzione simulatore
    - runac -tcf=ev71_vfpu a.out

- per utilizzare vector intrinsics contenuti dentro a "arc_vector.h"
    - Hvdsp_vector_c

- per autovettorizzare
    - fvectorize: to enable automatic loop vectorizations
    - fslp-vectorize: allow similar independent instructions to vector instructions
    - O[n] con n>0
    - ffast-math: to allow compiler to change the order of floating point operations

- per produrre llvm-ir
    - BS