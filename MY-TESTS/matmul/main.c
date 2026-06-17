#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "matmul.h"

#define N 64


int main() {
    __vccm int* a = __vccm_alloca(N * N * sizeof(int));
    __vccm int* b = __vccm_alloca(N * N * sizeof(int));
    __vccm int* c = __vccm_alloca(N * N * sizeof(int));
    if (!a || !b || !c) {
        printf("Errore nell'allocazione della memoria.\n");
        return 1;
    }

    // Inizializzazione degli array con valori casuali
    init_matrix(a, N, N, 1);
    init_matrix(b, N, N, 1);
    init_matrix(c, N, N, 0);

    /******** versione scalare ********/

    clock_t start = clock();
    matmul(a, b, c, N, N, N);
    clock_t end = clock();   
    double time_scalar = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione: %.2fms\n", time_scalar);
    printf("Primi 5 elementi della matrice risultato:\n");
    for (int i = 0; i < 5; i++) {
        printf("c[%d, %d]=%d\n", i/N, i%N, c[i]);
    }

    printf("\n");

	/******** versione vettorizzata ********/
    printf("Vettorizzo su %d lane\n", _VDSP_NUM_32BIT_LANES);
    init_matrix(c, N, N, 0);

    start = clock();
    vectorized_matmul(a, b, c, N, N, N);
    end = clock();   
    double time_vectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vectorized_vec_sum: %.2fms\n", time_vectorized);
    printf("Speedup: %.2f\n", time_scalar/time_vectorized);

    printf("Primi 5 elementi della matrice risultato:\n");
    for (int i = 0; i < 5; i++) {
        printf("c[%d, %d]=%d\n", i/N, i%N, c[i]);
    }

    printf("\n");

    /******** versione autovettorizzata ********/
    printf("Versione autovettorizzata\n");
    init_matrix(c, N, N, 0);

    start = clock();
    autovectorized_matmul(a, b, c, N, N, N);
    end = clock();   
    double time_autovectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di autovectorized_vec_sum: %.2fms\n", time_autovectorized);
    printf("Speedup: %.2f\n", time_scalar/time_autovectorized);

    printf("Primi 5 elementi della matrice risultato:\n");
    for (int i = 0; i < 5; i++) {
        printf("c[%d, %d]=%d\n", i/N, i%N, c[i]);
    }

    return 0;
}