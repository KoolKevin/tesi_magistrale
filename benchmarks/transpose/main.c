#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "transpose.h"



#define M 100
#define N 100

__vccm int a[M * N];
__vccm int t[N * M];

int main() {
    // Inizializzazione degli array con valori casuali
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            a[i*N + j] = i*100 + j;
        }
    }
    init_matrix(t, M, N, 0);

    printf("Input:\n");
    // print_matrix(a, M, N);
    printf("\n");

    /******** versione scalare ********/

    clock_t start = clock();
    transpose(a, t, M, N);
    clock_t end = clock();   
    double time_scalar = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione: %.2fms\n", time_scalar);
    // print_matrix(t, N, M);

    // copio il risultato scalare per confrontarlo con i 
    // risultati delle altre versioni
    int groundtruth[N][M];
    copy_matrix((int*)groundtruth, t, N, M); 
    
    printf("\n");

	/******** versione vettorizzata ********/
    printf("Vettorizzo su %d lane\n", _VDSP_NUM_32BIT_LANES);
    init_matrix(t, M, N, 0);

    start = clock();
    vectorized_transpose(a, t, M, N);
    end = clock();   
    double time_vectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vectorized_transpose: %.2fms\n", time_vectorized);
    printf("Speedup: %.2f\n", time_scalar/time_vectorized);

    // print_matrix(t, N, M);
    check_result((int*)groundtruth, t, M, N);

    printf("\n");

    /******** versione autovettorizzata ********/
    printf("Versione autovettorizzata\n");
    init_matrix(t, M, N, 0);

    start = clock();
    autovectorized_transpose(a, t, M, N);
    end = clock();   
    double time_autovectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di autovectorized_transpose: %.2fms\n", time_autovectorized);
    printf("Speedup: %.2f\n", time_scalar/time_autovectorized);

    // print_matrix(t, N, M);
    printf("\n");

	/******** versione vekt-vettorizzata ********/
    printf("Versione vekt-vettorizzata\n");
    init_matrix(t, M, N, 0);

    start = clock();
    vekt_transpose_wrapper(a, t, M, N);
    end = clock();   
    double time_vekt = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vekt_transpose: %.2fms\n", time_vekt);
    printf("Speedup: %.2f\n", time_scalar/time_vekt);

    // print_matrix(t, N, M);
    check_result((int*)groundtruth, t, M, N);

    printf("\n");

    return 0;
}