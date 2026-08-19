#include "mylib.h"
#include <stdio.h>

void init_matrix(int *a, int M, int N, int value) {
  for (int i = 0; i < M * N; i++) {
    a[i] = value;
  }
}

void check_result(int* A, int* B, int M, int N) {
    for(int i = 0; i < M; i++) {
        for(int j = 0; j < N; j++) {
            if (A[i*N + j] != B[i*N + j]) {
                printf("ERRORE! Le matrici non corrispondono!\n");
                printf("\tElemento (%d, %d) di A = %d mentre B = %d\n", 
                    i, j, A[i*N + j], B[i*N + j]);
                return;
            }
        }
    }

    printf("SUCCESSO! Le matrici sono uguali\n");
}

int* copy_matrix(int* dst, int* src, int M, int N) {
    for(int i = 0; i < M; i++) {
        for(int j = 0; j < N; j++) {
            dst[i*N + j] = src[i*N + j];
        }
    }
    return dst;
}

void print_matrix(int* A, int M, int N) {
    printf("[\n");
    for(int i = 0; i < M; i++) {
        printf("\t[");
        for(int j = 0; j < N; j++) {
            if (j == N-1)
                printf("%d", A[i*N + j]); 
            else
                printf("%d,", A[i*N + j]); 
        }
        printf("],\n");
    }
    printf("]\n");
}


void elementwise_sum(int M, int N, __vccm int* restrict A, __vccm int* restrict B) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            A[i*N + j] = A[i*N + j] + B[i*N + j];
        }
    }
}

void elementwise_sum_scalar(int M, int N, __vccm int* restrict A, int B) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            A[i*N + j] = A[i*N + j] + B;
        }
    }
}

int reduce_vector_max(int N, __vccm int* restrict A) {
    int acc = -1;
    for (int i = 0; i < N; i++) {
        acc = max(acc, A[i]);
    }

    return acc;
}

void elementwise_max_scalar(int M, int N, __vccm int* restrict A, int B) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            A[i*N + j] = max(A[i*N + j], B);
        }
    }
}

void conv2d(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           __vccm int* restrict output, __vccm int* restrict input, __vccm int* restrict kernel) {

    for (int i = 0; i < rows_out; i++) {
        for (int j = 0; j < cols_out; j++) {
            for (int k_i = 0; k_i < K; k_i++) {
                for (int k_j = 0; k_j < K; k_j++) {
                    output[i*cols_out + j] +=
                        input[(i+k_i)*cols_in + (j+k_j)] * kernel[k_i*K + k_j];
                }
            }
        }
    }
}

void vekt_conv2d_wrapper(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           int* output, int* input, int* kernel) {
    vekt_conv2d(
        rows_out, cols_out, rows_in, cols_in, K,
        output, output, 0, rows_out, cols_out, cols_out, 1,
        input, input, 0, rows_in, cols_in, cols_in, 1,
        kernel, kernel, 0, K, K, K, 1
    );

    return;
}

void matmul(int M, int N, int K, __vccm int* restrict A, __vccm int* restrict B, __vccm int* restrict C) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < K; k++) {
                C[i * N + j] += A[i * K + k] * B[k * N + j];
            }
        }
    }
}

void vekt_matmul_wrapper(int M, int N, int K, int* a, int* b, int* c) {
    vekt_matmul(
        M, N, K,
        a, a, 0, M, K, K, 1,
        b, b, 0, K, N, N, 1,
        c, c, 0, M, N, N, 1
    );
}

void max_pooling(int rows_out, int cols_out, int rows_in, int cols_in, int W,
                 __vccm int* restrict output, __vccm int* restrict input) {

  for (int i = 0; i < rows_out; i++) {
    for (int j = 0; j < cols_out; j++) {
      int max = input[(i * W) * cols_in + (j * W)];
      for (int w_i = 0; w_i < W; w_i++) {
        for (int w_j = 0; w_j < W; w_j++) {
          if (input[(i * W + w_i) * cols_in + (j * W + w_j)] > max) {
            max = input[(i * W + w_i) * cols_in + (j * W + w_j)];
          }
        }
      }
      output[i * cols_out + j] = max;
    }
  }
}

void vekt_max_pooling_wrapper(int rows_out, int cols_out, int rows_in,
                              int cols_in, int W, int *output, int *input) {
  
  vekt_max_pooling(
      rows_out, cols_out, rows_in, cols_in, W,
      output, output, 0, rows_out, cols_out, cols_out, 1,
      input, input, 0, rows_in, cols_in, cols_in, 1
  );
}

