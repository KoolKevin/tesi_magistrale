#include "matmul.h"
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

    printf("SUCCESSO! Le matrici sono uguali");
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


// matmul: C = A * B
// - A: [M x K], B: [K x N], C: [M x N]
// - Approccio a riduzione di outer prouduct
void vectorized_matmul(__vccm int* restrict A,
                       __vccm int* restrict B,
                       __vccm int* restrict C,
                       int M,
                       int N,
                       int K) {

    // Ciclo sulle colonne di B da un vettore all'altro
    int lanes = _VDSP_NUM_32BIT_LANES;
    int N_rounded = (N/lanes) * lanes;
    for (int j_vec = 0; j_vec < N_rounded; j_vec += lanes) {
        // Ciclo sulle righe di C
        for (int i = 0; i < M; i++) {
            // Inizializzazione dell'accumulatore a zero tramite intrinseco
            // di moltiplicazione (purtroppo non ho vdsp=5 e quindi non ho 
            // vvcmov(0))
            vNaccint_t acc = vvcmpy_lo ((vNint_t)0, (vNint_t)0);
            // Ciclo sulla dimensione interna K (somma degli outer product)
            for (int k = 0; k < K; k++) {
                // caricamento di un vettore dalla riga k ad offset j
                vNint_t vecB_row = vvld(&B[k*N + j_vec]);
                // Recupero lo scalare A[i][k] con cui moltiplicare l'intera
                // riga B[k], un vettore B[k][j] alla volta
                int scalarA = A[i*K + k];
                // vvcmac_lo() esegue un broadcast implicito di scalarA.
                // Moltiplica scalarA per ogni elemento di vecB_row 
                // e accumula in acc.
                acc = vvcmac_lo(acc, vecB_row, scalarA);
            }
            // Store finale del vettore in C[i][j].
            // L'intrinseco to_vNint_t() converte l'accumulatore
            // (con guard bits) in un vettore standard a 32 bit.
            vvst(to_vNint_t(acc), &C[i*N + j_vec]);
        }
    }

    // remainder loop scalare
    for (int j = N_rounded; j < N; j++) {
        // Ciclo sulle righe di C
        for (int i = 0; i < M; i++) {
            int acc = 0;
            // Ciclo sulla dimensione interna K (somma degli outer product)
            for (int k = 0; k < K; k++) {
                acc += B[k*N + j] * A[i*K + k];
            }
            C[i*N + j] = acc;
        }
    }
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