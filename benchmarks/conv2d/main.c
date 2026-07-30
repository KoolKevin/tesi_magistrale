#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "conv2d.h"



// K è la dimensione comune
#define K 3
#define ROWS_IN 35
#define COLS_IN 35
#define ROWS_OUT (ROWS_IN - (K-1))
#define COLS_OUT (COLS_IN - (K-1))

__vccm int kernel[K * K];
__vccm int in[ROWS_IN * COLS_IN];
__vccm int out[ROWS_OUT * COLS_OUT];

int main() {
    for (int i=0; i < ROWS_IN; i++) {
        for (int j=0; j < COLS_IN; j++) {
            in[i*COLS_IN + j] = (i+j) % 10;
        }
    }
    init_matrix(kernel, K, K, 1);
    init_matrix(out, ROWS_OUT, COLS_OUT, 0);

    /******** versione scalare ********/

    clock_t start = clock();
    conv2d(ROWS_OUT, COLS_OUT, ROWS_IN, COLS_IN, K, out, in, kernel);
    clock_t end = clock();   
    double time_scalar = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione: %.2fms\n", time_scalar);
    print_matrix(out, ROWS_OUT, COLS_OUT);

    // copio il risultato scalare per confrontarlo con i 
    // risultati delle altre versioni
    int groundtruth[ROWS_OUT][COLS_OUT];
    copy_matrix((int*)groundtruth, out, ROWS_OUT, COLS_OUT); 
    
    printf("\n");

	/******** versione vettorizzata ********/
    printf("Vettorizzo su %d lane\n", _VDSP_NUM_32BIT_LANES);
    init_matrix(out, ROWS_OUT, COLS_OUT, 0);

    start = clock();
    vectorized_conv2d(ROWS_OUT, COLS_OUT, ROWS_IN, COLS_IN, K, out, in, kernel);
    end = clock();   
    double time_vectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vectorized_conv2d: %.2fms\n", time_vectorized);
    printf("Speedup: %.2f\n", time_scalar/time_vectorized);

    print_matrix(out, ROWS_OUT, COLS_OUT);
    check_result((int*)groundtruth, out, ROWS_OUT, COLS_OUT);

    printf("\n");

    /******** versione autovettorizzata ********/
    printf("Versione autovettorizzata\n");
    init_matrix(out, ROWS_OUT, COLS_OUT, 0);

    start = clock();
    autovectorized_conv2d(ROWS_OUT, COLS_OUT, ROWS_IN, COLS_IN, K, out, in, kernel);
    end = clock();   
    double time_autovectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di autovectorized_conv2d: %.2fms\n", time_autovectorized);
    printf("Speedup: %.2f\n", time_scalar/time_autovectorized);

    print_matrix(out, ROWS_OUT, COLS_OUT);
    printf("\n");

	/******** versione vekt-vettorizzata ********/
    printf("Versione vekt-vettorizzata\n");
    init_matrix(out, ROWS_OUT, COLS_OUT, 0);

    start = clock();
    vekt_conv2d_wrapper(ROWS_OUT, COLS_OUT, ROWS_IN, COLS_IN, K, out, in, kernel);
    end = clock();   
    double time_vekt = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vekt_conv2d: %.2fms\n", time_vekt);
    printf("Speedup: %.2f\n", time_scalar/time_vekt);

    print_matrix(out, ROWS_OUT, COLS_OUT);
    check_result((int*)groundtruth, out, ROWS_OUT, COLS_OUT);

    printf("\n");

    return 0;
}