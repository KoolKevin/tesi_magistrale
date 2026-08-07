#include "max_pooling.h"
#include <stdio.h>

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

// Assumo:
// - finestra di pooling quadrata di dimensione W
// - dimensione di input divisibile per la dimensione della
//   finestra
//      - input già padded
// - dimensioni corrette di output e input (rows_in == rows_out*W, ...)
void max_pooling(int rows_out, int cols_out, int rows_in, int cols_in, int W,
                 int *output, int *input) {

#pragma clang loop vectorize(disable)
  for (int i = 0; i < rows_out; i++) {
#pragma clang loop vectorize(disable)
    for (int j = 0; j < cols_out; j++) {
      int max = input[(i * W) * cols_in + (j * W)];
#pragma clang loop vectorize(disable)
      for (int w_i = 0; w_i < W; w_i++) {
#pragma clang loop vectorize(disable)
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

void vectorized_max_pooling(int rows_out, int cols_out, int rows_in,
                            int cols_in, int W, __vccm int *restrict output,
                            __vccm int *restrict input) {

  int lanes = _VDSP_NUM_32BIT_LANES;
  // NB: cols_out == cols_in / W
  // se W comincia ad essere grande, è facile che
  // cols_out < 16 è quindi che la vettorizzazione
  // non agisca a causa di un numero di colonne
  // insufficiente
  int cols_out_rounded = (cols_out / lanes) * lanes;

  // contiene [0, 1, 2, ..., 15]
  vNint_t idx = vvci_w();
  // faccio confronti strided
  //
  // contiene [0, W, 2W, ..., 15W]
  vNint_t offsets = idx * (vNint_t)W;

  for (int i = 0; i < rows_out; i++) {
    // calcolo 'lanes' elementi della riga i-esima di out per volta
    for (int j_vec = 0; j_vec < cols_out_rounded; j_vec += lanes) {

      vNaccint_t max_acc = vvcadd_init(vvld(&output[i * cols_out + j_vec]), 0);
      for (int w_i = 0; w_i < W; w_i++) {
        for (int w_j = 0; w_j < W; w_j++) {
          vNint_t input_vec = vgather(
              &input[(i * W + w_i) * cols_in + (j_vec * W + w_j)], offsets);
          max_acc = vvcmax(max_acc, input_vec);
        }
      }

      vvst(to_vNint_t(max_acc), &output[i * cols_out + j_vec]);
    }
  }

  // remainder loop
  for (int i = 0; i < rows_out; i++) {
    for (int j = cols_out_rounded; j < cols_out; j++) {
      int max = input[i * cols_out + j];
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

  return;
}

void autovectorized_max_pooling(int rows_out, int cols_out, int rows_in,
                                int cols_in, int W, __vccm int *restrict output,
                                __vccm int *restrict input) {

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

  printf("eccomi\n");
  return;
}
