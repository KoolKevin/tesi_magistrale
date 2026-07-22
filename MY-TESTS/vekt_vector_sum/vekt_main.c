#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdint.h>

#include <arc_vector.h>

#define N 1024*8

void init_vector(int *a, int dim, int value) {
  for (int i = 0; i < dim; i++) {
    a[i] = value;
  }
}

// NON CI POSSO CREDERE. Prima stavo usando long al posto di int64_t in questa dichiarazione. A quanto pare
// un long della PPU è grande 32 bit. Questo è il motivo per cui non funzionava niente! Stavo rompendo l'ABI.
// Ho dovuto aggiungere a mano chiamate a printf dentro all'ir per accorgermi che gli argomenti non stavano venendo
// passati correttamente.
// Questo commento è la testimonianza della mia sofferenza
extern void vekt_vec_sum(int* a_alloc, int* a_align, int64_t a_offset, int64_t a_size, int64_t a_stride,
                    int* b_alloc, int* b_align, int64_t b_offset, int64_t b_size, int64_t b_stride,
                    int* c_alloc, int* c_align, int64_t c_offset, int64_t c_size, int64_t c_stride,
                    int32_t n);

void vekt_vec_sum_wrapper(int* a, int* b, int* c, int n) {
    vekt_vec_sum(
        a, a, 0, n, 1,
        b, b, 0, n, 1,
        c, c, 0, n, 1,
        n
    );
}

// extern void vekt_vec_sum(int* a, int* b, int* c, int n);

void vec_sum(int* a, int* b, int* c, int n) {
    #pragma clang loop vectorize(disable)
	for(int i = 0; i < n; i++)
		c[i] = a[i] + b[i];
}

extern void vectorized_vec_sum(__vccm int* restrict a, 
                        __vccm int* restrict b, 
                        __vccm int* restrict c, 
                        int n);
// void vectorized_vec_sum(__vccm int* restrict a, 
//                         __vccm int* restrict b, 
//                         __vccm int* restrict c, 
//                         int n) {
    
//     vNint_t va = 0;
//     vNint_t vb = 0;
//     vNint_t vc = 0;

//     int lanes = _VDSP_NUM_32BIT_LANES;
//     int num_vectors = n / lanes;

//     for (int i = 0; i < num_vectors; i++) {
//         va = vvld(&a[i*lanes]);
//         vb = vvld(&b[i*lanes]);
//         vc = vvadd(va, vb);
//         vvst(vc, &c[i*lanes]);
//     }

//     // commentiamo via per semplificare l'output
//     // // loop scalare per la gestione degli ultimi elementi
//     // int start = num_vectors*lanes;
//     // int end = start + n%lanes;
//     // for (int i = start; i < end; i++) {
// 	// 	c[i] = a[i] + b[i];
//     // }
// }

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

    /******** versione vekt-vettorizzata ********/
    printf("Versione vekt-vettorizzata\n");

    // printf("\tpuntatori array: %p, %p, %p\n", a, b, c);

    init_vector(c, N, -1);

    start = clock();
    vekt_vec_sum_wrapper(a, b, c, N);
    // vekt_vec_sum(a, b, c, N);
    end = clock();   
    double time_vekt = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di autovectorized_vec_sum: %.2fms\n", time_vekt);
    printf("Speedup: %.2f\n", time_scalar/time_vekt);
    printf("Primi 5 elementi della somma:\n");
    for (int i = 0; i < 5; i++) {
        printf("a[%d]=%d, b[%d]=%d, c[%d]=%d\n", i, a[i], i, b[i], i, c[i]);
    }

    return 0;
}