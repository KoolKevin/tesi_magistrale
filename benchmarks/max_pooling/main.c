#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "max_pooling.h"

#define W 2
#define ROWS_IN 32
#define COLS_IN 32
#define ROWS_OUT (ROWS_IN / W)
#define COLS_OUT (COLS_IN / W)

__vccm int in[ROWS_IN * COLS_IN];
__vccm int out[ROWS_OUT * COLS_OUT];

int main() {
    for (int i=0; i < ROWS_IN; i++) {
        for (int j=0; j < COLS_IN; j++) {
            in[i*COLS_IN + j] = (i+j) % 10;
        }
    }
    init_matrix(out, ROWS_OUT, COLS_OUT, 0);

    /******** versione scalare ********/


    printf("Input\n");
    print_matrix(in, ROWS_IN, COLS_IN);
    printf("\n");

    clock_t start = clock();
    max_pooling(ROWS_OUT, COLS_OUT, ROWS_IN, COLS_IN, W, out, in);
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
    vectorized_max_pooling(ROWS_OUT, COLS_OUT, ROWS_IN, COLS_IN, W, out, in);
    end = clock();   
    double time_vectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vectorized_max_pooling: %.2fms\n", time_vectorized);
    printf("Speedup: %.2f\n", time_scalar/time_vectorized);

    print_matrix(out, ROWS_OUT, COLS_OUT);
    check_result((int*)groundtruth, out, ROWS_OUT, COLS_OUT);

    printf("\n");

    /******** versione autovettorizzata ********/
    printf("Versione autovettorizzata\n");
    init_matrix(out, ROWS_OUT, COLS_OUT, 0);

    start = clock();
    autovectorized_max_pooling(ROWS_OUT, COLS_OUT, ROWS_IN, COLS_IN, W, out, in);
    end = clock();   
    double time_autovectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di autovectorized_max_pooling: %.2fms\n", time_autovectorized);
    printf("Speedup: %.2f\n", time_scalar/time_autovectorized);

    print_matrix(out, ROWS_OUT, COLS_OUT);
    printf("\n");

	/******** versione vekt-vettorizzata ********/
    printf("Versione vekt-vettorizzata\n");
    init_matrix(out, ROWS_OUT, COLS_OUT, 0);

    start = clock();
    vekt_max_pooling_wrapper(ROWS_OUT, COLS_OUT, ROWS_IN, COLS_IN, W, out, in);
    end = clock();   
    double time_vekt = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vekt_max_pooling: %.2fms\n", time_vekt);
    printf("Speedup: %.2f\n", time_scalar/time_vekt);

    print_matrix(out, ROWS_OUT, COLS_OUT);
    check_result((int*)groundtruth, out, ROWS_OUT, COLS_OUT);

    printf("\n");

    return 0;
}