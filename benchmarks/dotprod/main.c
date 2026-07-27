#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "dotp.h"

#define N 1024 * 8

__vccm int a[N];
__vccm int b[N];

int main() {
    // Inizializzazione degli array
    for (int i = 0; i < N; i++) {
        a[i] = 1;
        b[i] = 1;
    }

    /******** versione scalare ********/

    clock_t start = clock();
    int c = dotp(a, b, N);
    clock_t end = clock();   
    double time_scalar = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione: %.2fms\n", time_scalar);
    printf("Risultato: %d\n", c);

    printf("\n");

	/******** versione vettorizzata ********/

    printf("Vettorizzo su %d lane\n", _VDSP_NUM_32BIT_LANES);
    c = -1;

    start = clock();
    c = vectorized_dotp(a, b, N);
    end = clock();   
    double time_vectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione vectorized: %.2fms\n", time_vectorized);
    printf("Speedup: %.2f\n", time_scalar/time_vectorized);
    printf("Risultato: %d\n", c);

    printf("\n");

    /******** versione autovettorizzata ********/

    printf("Versione autovettorizzata\n");
    c = -1;

    start = clock();
    c = autovectorized_dotp(a, b, N);
    end = clock();   
    double time_autovectorized = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di autovectorized: %.2fms\n", time_autovectorized);
    printf("Speedup: %.2f\n", time_scalar/time_autovectorized);
    printf("Risultato: %d\n", c);

    printf("\n");

    /******** versione vekt-vettorizzata ********/

    printf("Versione vekt-vettorizzata\n");
    c = -1;

    start = clock();
    c = vekt_dotp_wrapper(a, b, N);
    end = clock();   
    double time_vekt = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vekt-vectorized: %.2fms\n", time_vekt);
    printf("Speedup: %.2f\n", time_scalar/time_vekt);
    printf("Risultato: %d\n", c);

    printf("\n");

    return 0;
}