#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "vec_sum.h"

#define N 1024

__vccm int a[N];
__vccm int b[N];
__vccm int c[N];

int main() {
    // Inizializzazione degli array con valori casuali
    for (int i = 0; i < N; i++) {
        a[i] = i+1;
        b[i] = i+1;
    }
    init_vector(c, N, -1);

    /******** versione scalare ********/

    clock_t start = clock();
    vec_sum(a, b, c, N);
    clock_t end = clock();   
    double time_scalar = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vec_sum: %.2fms\n", time_scalar);
    printf("Primi 5 elementi della somma:\n");
    for (int i = 0; i < 5; i++) {
        printf("a[%d]=%d, b[%d]=%d, c[%d]=%d\n", i, a[i], i, b[i], i, c[i]);
    }

    printf("\n");

	/******** versione vettorizzata ********/
    printf("Vettorizzo su %d lane\n", _VDSP_NUM_32BIT_LANES);

    init_vector(c, N, -1);

    start = clock();
    vectorized_vec_sum(a, b, c, N);
    end = clock();   
    double time_vectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vectorized_vec_sum: %.2fms\n", time_vectorized);
    printf("Speedup: %.2f\n", time_scalar/time_vectorized);
    printf("Primi 5 elementi della somma:\n");
    for (int i = 0; i < 5; i++) {
        printf("a[%d]=%d, b[%d]=%d, c[%d]=%d\n", i, a[i], i, b[i], i, c[i]);
    }

    printf("\n");

    /******** versione autovettorizzata ********/
    printf("Versione autovettorizzata\n");

    init_vector(c, N, -1);

    start = clock();
    autovectorized_vec_sum(a, b, c, N);
    end = clock();   
    double time_autovectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di autovectorized_vec_sum: %.2fms\n", time_autovectorized);
    printf("Speedup: %.2f\n", time_scalar/time_autovectorized);
    printf("Primi 5 elementi della somma:\n");
    for (int i = 0; i < 5; i++) {
        printf("a[%d]=%d, b[%d]=%d, c[%d]=%d\n", i, a[i], i, b[i], i, c[i]);
    }

    return 0;
}