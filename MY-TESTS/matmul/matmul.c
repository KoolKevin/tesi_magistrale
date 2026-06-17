#include "matmul.h"

void init_matrix(int *a, int M, int N, int value) {
  for (int i = 0; i < M * N; i++) {
    a[i] = value;
  }
}

void matmul(int *A, int *B, int *C, int M, int K, int N) {
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
                        int K,
                        int N) {
    return;
}

void autovectorized_matmul(__vccm int* restrict A,
                           __vccm int* restrict B,
                           __vccm int* restrict C,
                           int M,
                           int K,
                           int N) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < K; k++) {
                C[i * N + j] += A[i * K + k] * B[k * N + j];
            }
        }
    }
}