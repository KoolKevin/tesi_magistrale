#include "conv2d.h"
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


// Assumo:
// - kernel quadrato con K dispari
// - no padding -> output è più piccolo
// - dimensioni corrette di output e input 
//   - (rows_out == rows_in - (K-1) && cols_out == ...)
void conv2d(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           int* output, int* input, int* kernel) {

    #pragma clang loop vectorize(disable)
    for (int i = 0; i < rows_out; i++) {
        #pragma clang loop vectorize(disable)
        for (int j = 0; j < cols_out; j++) {
            #pragma clang loop vectorize(disable)
            for (int k_i = 0; k_i < K; k_i++) {
                #pragma clang loop vectorize(disable)
                for (int k_j = 0; k_j < K; k_j++) {
                    output[i*cols_out + j] +=
                        input[(i+k_i)*cols_in + (j+k_j)] * kernel[k_i*K + k_j];
                }
            }
        }
    }
}

void vectorized_conv2d(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           __vccm int* restrict output, 
           __vccm int* restrict input,
           __vccm int* restrict kernel) {

    int lanes = _VDSP_NUM_32BIT_LANES;
    int cols_out_rounded = (cols_out/lanes) * lanes;

    // ogni riga dell'output è calcolata come la somma delle K  conv1d
    // tra K righe dell'input per K righe del kernel
    // 
    // conv2d_row(i) = sum_K(conv1d(input_row[i+k_i], kernel_row[k_i]))
    for (int i = 0; i < rows_out; i++) {
        // calcolo 'lanes' elementi della riga i-esima di out per volta
        for (int j_vec = 0; j_vec < cols_out_rounded; j_vec+=lanes) {
            // Calcolo la conv2d di 'lanes' elementi -> out[i][j_vec]!
            // La riga i-esima di out è calcolata sommando K conv1d.
            // Variando ki sto considerando una riga diversa del kernel
            // e dell'input con cui calcolare il vettore di conv1d
            vNaccint_t conv2d_acc = vvcadd_init(vvld(&output[i*cols_out + j_vec]), 0);
            for (int k_i = 0; k_i < K; k_i++) {
                // Calcolo conv1d di 'lanes' elementi accumulando 
                // vettori da input[i+ki][j_vec+kj] moltiplicati per
                // uno dei pesi di kernel[ki, kj]. Una conv1d viene
                // calcolata faccendo K mac (considero tutti i pesi
                // di una riga del kernel). Variando kj sto shiftando 
                // di una posizione il peso considerato e il vettore 
                // di input
                for (int k_j = 0; k_j < K; k_j++) {
                    int kernel_scalar = kernel[k_i*K + k_j];
                    vNint_t input_vec = vvld(&input[(i+k_i)*cols_in + (j_vec+k_j)]);
                    conv2d_acc = vvcmac_lo(conv2d_acc, input_vec, kernel_scalar);
                }

                // Qua ho finito di calcolare la conv1d di una riga.
                // Itero per K righe e accumulo il tutto sempre nello
                // accumulatore
            }

            // ho finito di accumulare conv1d e qundi ho il vettore
            // risultato da salvare in out[i, j_vec]
            vvst(to_vNint_t(conv2d_acc), &output[i*cols_out + j_vec]);
        }
    }

    // remainder loop
    for (int i = 0; i < rows_out; i++) {
        for (int j = cols_out_rounded; j < cols_out; j++) {
            for (int k_i = 0; k_i < K; k_i++) {
                for (int k_j = 0; k_j < K; k_j++) {
                    output[i*cols_out + j] +=
                        input[(i+k_i)*cols_in + (j+k_j)] * kernel[k_i*K + k_j];
                }
            }
        }
    }

    return;
}

void autovectorized_conv2d(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           __vccm int* restrict output, 
           __vccm int* restrict input,
           __vccm int* restrict kernel) {

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
    // vekt_conv2d(
    //     M, N, K,
    //     a, a, 0, M, K, K, 1,
    //     b, b, 0, K, N, N, 1,
    //     c, c, 0, M, N, N, 1
    // );

    return;
}