#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "mat_reduce_cols.h"

#define M 128
#define N 16

__vccm int a[M * N];
__vccm int res[N];

int main() {
    // Inizializzazione degli array con valori casuali
    init_matrix(a, M, N, 1);
    init_vector(res, N, 0);

    // /******** versione scalare ********/

    clock_t start = clock();
    mat_reduce_cols(a, res, M, N);
    clock_t end = clock();   
    double time_scalar = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione: %.2fms\n", time_scalar);
    print_vector(res, N);

    // copio il risultato scalare per confrontarlo con i 
    // risultati delle altre versioni
    int groundtruth[N];
    for(int j=0; j < N; j++) {
        groundtruth[j] = res[j];
    }
    
    printf("\n");

	/******** versione vettorizzata ********/
    printf("Vettorizzo su %d lane\n", _VDSP_NUM_32BIT_LANES);
    init_vector(res, N, 0);

    start = clock();
    vectorized_mat_reduce_cols(a, res, M, N);
    end = clock();   
    double time_vectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vectorized_mat_reduce_cols: %.2fms\n", time_vectorized);
    printf("Speedup: %.2f\n", time_scalar/time_vectorized);

    print_vector(res, N);
    check_result(groundtruth, res, N);

    printf("\n");

    /******** versione autovettorizzata ********/
    printf("Versione autovettorizzata\n");
    init_vector(res, N, 0);

    start = clock();
    autovectorized_mat_reduce_cols(a, res, M, N);
    end = clock();   
    double time_autovectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di autovectorized_mat_reduce_cols: %.2fms\n", time_autovectorized);
    printf("Speedup: %.2f\n", time_scalar/time_autovectorized);

    print_vector(res, N);
    check_result(groundtruth, res, N);
    printf("\n");

	/******** versione vekt-vettorizzata ********/
    printf("Versione vekt-vettorizzata\n");
    init_vector(res, N, 0);

    start = clock();
    vekt_mat_reduce_cols_wrapper(a, res, M, N);
    end = clock();   
    double time_vekt = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vekt_mat_reduce_cols: %.2fms\n", time_vekt);
    printf("Speedup: %.2f\n", time_scalar/time_vekt);

    print_vector(res, N);
    check_result(groundtruth, res, N);

    printf("\n");

    return 0;
}