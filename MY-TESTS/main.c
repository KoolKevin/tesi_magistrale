#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "vec_sum.h"

#define N 1024


int main() {
    printf("%s\n", "hello");

/*
	// malloc allocates into "scalar memory"
	// depending on the linker script specification, this can
	// be the CSM or the LMU
    int* a = (int*)malloc(N * sizeof(int));
    int* b = (int*)malloc(N * sizeof(int));
    int* c = (int*)malloc(N * sizeof(int));
    if (!a || !b || !c) {
        printf("Errore nell'allocazione della memoria.\n");
        return 1;
    }
*/
    __vccm int* a = __vccm_alloca(N * sizeof(int));
    __vccm int* b = __vccm_alloca(N * sizeof(int));
    __vccm int* c = __vccm_alloca(N * sizeof(int));
    if (!a || !b || !c) {
        printf("Errore nell'allocazione della memoria.\n");
        return 1;
    }
    // Inizializzazione degli array con valori casuali
    for (int i = 0; i < N; i++) {
        a[i] = i+1;
        b[i] = i+1;
    }


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

/*
    // Liberazione della memoria allocata
    free(a);
    free(b);
    free(c);
*/

    return 0;
}