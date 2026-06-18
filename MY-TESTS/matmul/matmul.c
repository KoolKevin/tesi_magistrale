#include "matmul.h"
#include <stdio.h>

void init_matrix(int *a, int M, int N, int value) {
  for (int i = 0; i < M * N; i++) {
    a[i] = value;
  }
}

// Matmul tra matrici con dimensioni:
// - A -> MxK
// - B -> KxN
// - C -> MxN
// 
// K è la dimensione comune
void matmul(int *A, int *B, int *C, int M, int N, int K) {
    #pragma clang loop vectorize(disable)
    for (int i = 0; i < M; i++) {
        #pragma clang loop vectorize(disable)
        for (int j = 0; j < N; j++) {
            #pragma clang loop vectorize(disable)
            for (int k = 0; k < K; k++) {
                C[i * N + j] += A[i * K + k] * B[k * N + j];
            }
        }
    }
}

void vectorized_matmul( __vccm int* restrict A,
                        __vccm int* restrict B,
                        __vccm int* restrict C,
                        int M,
                        int N,
                        int K) {
    return;
}

void autovectorized_matmul(__vccm int* restrict A,
                           __vccm int* restrict B,
                           __vccm int* restrict C,
                           int M,
                           int N,
                           int K) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < K; k++) {
                C[i * N + j] += A[i * K + k] * B[k * N + j];
            }
        }
    }
}