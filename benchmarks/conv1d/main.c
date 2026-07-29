#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "conv1d.h"

#define K 3
#define N_in 1024
#define N_out (N_in - (K-1))

__vccm int in[N_in];
__vccm int out[N_out];
__vccm int kernel[K];

int main() {
    for (int i=0; i < N_in; i++) {
        in[i] = i % 10;
    }
    init_vector(out, N_out, 0);
    init_vector(kernel, K, 1);

    /******** versione scalare ********/

    clock_t start = clock();
    conv1d(N_out, N_in, K, out, in, kernel);
    clock_t end = clock();   
    double time_scalar = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di conv1d: %.2fms\n", time_scalar);
    print_vector(out, N_out);

    printf("\n");

	/******** versione vettorizzata ********/
    printf("Vettorizzo su %d lane\n", _VDSP_NUM_32BIT_LANES);

    init_vector(out, N_out, 0);

    start = clock();
    vectorized_conv1d(N_out, N_in, K, out, in, kernel);
    end = clock();   
    double time_vectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vectorized_conv1d: %.2fms\n", time_vectorized);
    printf("Speedup: %.2f\n", time_scalar/time_vectorized);
    print_vector(out, N_out);


    printf("\n");

    /******** versione autovettorizzata ********/
    printf("Versione autovettorizzata\n");

    init_vector(out, N_out, 0);

    start = clock();
    autovectorized_conv1d(N_out, N_in, K, out, in, kernel);
    end = clock();   
    double time_autovectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di autovectorized_conv1d: %.2fms\n", time_autovectorized);
    printf("Speedup: %.2f\n", time_scalar/time_autovectorized);
    print_vector(out, N_out);

    printf("\n");

    /******** versione vekt-vettorizzata ********/
    printf("Versione vekt-vettorizzata\n");

    init_vector(out, N_out, 0);

    start = clock();
    vekt_conv1d_wrapper(N_out, N_in, K, out, in, kernel);
    end = clock();   
    double time_vekt = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vekt_conv1d: %.2fms\n", time_vekt);
    printf("Speedup: %.2f\n", time_scalar/time_vekt);
    print_vector(out, N_out);


    return 0;
}