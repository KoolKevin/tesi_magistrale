#include <stdio.h>

#include <arc_vector.h>

#define N 1024

extern vNint_t test_ppu_vec_ops(__vccm int *);

__vccm int a[N];

int main() {
    for (int i = 0; i < N; i++) {
        a[i] = i+1;
    }

    vNint_t va = test_ppu_vec_ops(a);

    printf("va: { ");
    for (int i = 0; i < _VDSP_NUM_32BIT_LANES; i++)
        printf("%d ", ((int*)&va)[i]);
    printf("}\n");


    printf("Primi 5 elementi in memoria:\n");
    for (int i = 0; i < 5; i++) {
        printf("a[%d]=%d\n", i, a[i]);
    }
}