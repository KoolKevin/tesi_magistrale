#include "sad2d.h"
#include <stdio.h>

#define abs(x) (((x) >=  0) ? (x) : -(x))

void init_matrix(int *a, int M, int N, int value) {
  for (int i = 0; i < M * N; i++) {
    a[i] = value;
  }
}

void check_result(int *A, int *B, int M, int N) {
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      if (A[i * N + j] != B[i * N + j]) {
        printf("ERRORE! Le matrici non corrispondono!\n");
        printf("\tElemento (%d, %d) di A = %d mentre B = %d\n", i, j,
               A[i * N + j], B[i * N + j]);
        return;
      }
    }
  }

  printf("SUCCESSO! Le matrici sono uguali\n");
}

int *copy_matrix(int *dst, int *src, int M, int N) {
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      dst[i * N + j] = src[i * N + j];
    }
  }
  return dst;
}

void print_matrix(int *A, int M, int N) {
  printf("[\n");
  for (int i = 0; i < M; i++) {
    printf("\t[");
    for (int j = 0; j < N; j++) {
      if (j == N - 1)
        printf("%d", A[i * N + j]);
      else
        printf("%d,", A[i * N + j]);
    }
    printf("],\n");
  }
  printf("]\n");
}

int sad2d(int rows, int cols, int* input1, int* input2) {
  int res = 0;

  #pragma clang loop vectorize(disable)
  for (int i = 0; i < rows; i++) {
    #pragma clang loop vectorize(disable)
    for (int j = 0; j < cols; j++) {
      int t1 = input1[i*cols + j] - input2[i*cols + j];
      res += abs(t1);
    }
  }

  return res;
}

int vectorized_sad2d(int rows, int cols, __vccm int* restrict input1, __vccm int* restrict input2) {

  int lanes = _VDSP_NUM_32BIT_LANES;
  int cols_rounded = (cols / lanes) * lanes;

  vNaccint_t acc = vvcadd_init((vNint_t)0, 0);
  for (int i = 0; i < rows; i++) {
    for (int j_vec = 0; j_vec < cols_rounded; j_vec += lanes) {
        vNint_t vec1 = vvld(&input1[i*cols + j_vec]);
        vNint_t vec2 = vvld(&input2[i*cols + j_vec]);
        vNint_t tmp = vvsub(vec1, vec2);
        tmp = vvabs(tmp);
        acc = vvcadd(acc, tmp, 0);
    }
  }

  acc = vvc4add(acc);
  acc = vvc4pack(acc);
  acc = vvc4add(acc);
  acc = vvc4pack(acc);
  int res = (to_vNint_t(acc))[0];

  // TODO: aggiungi remainder loop

  return res;
}

int autovectorized_sad2d(int rows, int cols, __vccm int* restrict input1, __vccm int* restrict input2) {
  int res = 0;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      int t1 = input1[i*cols + j] - input2[i*cols + j];
      res += abs(t1);
    }
  }

  return res;
}

int vekt_sad2d_wrapper(int rows, int cols, int* input1, int* input2) {
  
//   vekt_sad2d(
//       rows_out, cols_out, rows_in, cols_in, W,
//       output, output, 0, rows_out, cols_out, cols_out, 1,
//       input, input, 0, rows_in, cols_in, cols_in, 1
//   );
  return -1;
}
