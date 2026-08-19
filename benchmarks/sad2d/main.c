#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "sad2d.h"

#define ROWS 112
#define COLS 112

__vccm int input1[ROWS * COLS];
__vccm int input2[ROWS * COLS];

int main() {
    int res = -1;
    init_matrix(input1, ROWS, COLS, 1);
    init_matrix(input2, ROWS, COLS, 2);

    /******** versione scalare ********/

    clock_t start = clock();
    res = sad2d(ROWS, COLS, input1, input2);
    clock_t end = clock();   
    double time_scalar = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione: %.2fms\n", time_scalar);
    printf("res: %d\n", res);

    printf("\n");

	/******** versione vettorizzata ********/
    printf("Vettorizzo su %d lane\n", _VDSP_NUM_32BIT_LANES);
    res = -1;

    start = clock();
    res = vectorized_sad2d(ROWS, COLS, input1, input2);
    end = clock();   
    double time_vectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vectorized_sad2d: %.2fms\n", time_vectorized);
    printf("Speedup: %.2f\n", time_scalar/time_vectorized);

    printf("res: %d\n", res);

    printf("\n");

    /******** versione autovettorizzata ********/
    printf("Versione autovettorizzata\n");
    res = -1;

    start = clock();
    res = autovectorized_sad2d(ROWS, COLS, input1, input2);
    end = clock();   
    double time_autovectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di autovectorized_sad2d: %.2fms\n", time_autovectorized);
    printf("Speedup: %.2f\n", time_scalar/time_autovectorized);

    printf("res: %d\n", res);

    printf("\n");

	/******** versione vekt-vettorizzata ********/
    printf("Versione vekt-vettorizzata\n");
    res = -1;

    start = clock();
    res = vekt_sad2d_wrapper(ROWS, COLS, input1, input2);
    end = clock();   
    double time_vekt = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vekt_sad2d: %.2fms\n", time_vekt);
    printf("Speedup: %.2f\n", time_scalar/time_vekt);

    printf("res: %d\n", res);

    printf("\n");

    return 0;
}