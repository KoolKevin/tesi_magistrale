#include "conv1d.h"
#include <stdio.h>

void init_vector(int *a, int dim, int value) {
  for (int i = 0; i < dim; i++) {
    a[i] = value;
  }
}

void print_vector(int* A, int N) {
    printf("[");
    for(int i = 0; i < N; i++) {
        if (i == N-1)
            printf("%d", A[i]); 
        else
            printf("%d,", A[i]); 
    }
    printf("]\n");
}

// Assumo:
// - K dispari
// - no padding -> output è più piccolo
// - dimensioni corrette di output e input (N_out = N_in - (K-1))
void conv1d(int N_out, int N_in, int W, int output[N_out], int input[N_in], int window[W]) {
    #pragma clang loop vectorize(disable)
    for (int i = 0; i < N_out; i++) {
        #pragma clang loop vectorize(disable)
        for (int w_i = 0; w_i < W; w_i++) {
            output[i] += input[i + w_i] * window[w_i];
        }
    }
}

void vectorized_conv1d(int N_out, int N_in, int W,
    __vccm int* restrict output,
    __vccm int* restrict input, 
    __vccm int* restrict window) {

    int lanes = _VDSP_NUM_32BIT_LANES;
    int N_out_rounded = (N_out/lanes) * lanes;
    for (int i = 0; i < N_out_rounded; i+=lanes) {
        vNaccint_t acc = vvcmpy_lo(vvld(&output[i]), (vNint_t)1);
        for (int w_i = 0; w_i < W; w_i++) {
            int window_scalar = window[w_i];
            vNint_t input_vec = vvld(&input[i + w_i]);
            // accumulo un vettore di input moltiplicato
            // per uno dei pesi del kernel. Shiftando di 
            // una posizione il peso considerato e il 
            // vettore di input, arrivo ad accumulare
            // tutti i contributi per un vettore di output
            acc = vvcmac_lo(acc, input_vec, window_scalar);
        }
        vvst(to_vNint_t(acc), &output[i]);
    }

    // remainder loop
    for (int i = N_out_rounded; i < N_out; i++) {
        for (int w_i = 0; w_i < W; w_i++) {
            output[i] += input[i + w_i] * window[w_i];
        }
    }
}

void autovectorized_conv1d(int N_out, int N_in, int W,
    __vccm int* restrict output,
    __vccm int* restrict input, 
    __vccm int* restrict window) {

    for (int i = 0; i < N_out; i++) {
        for (int w_i = 0; w_i < W; w_i++) {
            output[i] += input[i + w_i] * window[w_i];
        }
    }
}

void vekt_conv1d_wrapper(int N_out, int N_in, int W, int output[N_out], int input[N_in], int window[W]) {
    // vekt_conv1d(
    //     a, a, 0, n, 1,
    //     b, b, 0, n, 1,
    //     c, c, 0, n, 1,
    //     n
    // );

    return;
}