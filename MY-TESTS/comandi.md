- compilazione normale
    - ccac -tcf=ev71_vfpu -O2 matmul.c main.c

- compilazione per LLVM-IR
    - ccac -tcf=ev71_vfpu -O2 -BS matmul.c main.c

- esecuzione simulatore
    - runac -tcf=ev71_vfpu a.out

- per utilizzare vector intrinsics contenuti dentro a "arc_vector.h"
    - Hvdsp_vector_c
