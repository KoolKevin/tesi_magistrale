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


// matmu: C = A * B
// - A: [M x K], B: [K x N], C: [M x N]
// - Approccio a riduzione di outer prouduct
// - Assumo che N corrisponde alla larghezza del vettore (es. 16 elementi a 32-bit per 512-bit)
void vectorized_matmul(__vccm int* restrict A,
                       __vccm int* restrict B,
                       __vccm int* restrict C,
                       int M,
                       int N,
                       int K) {

    // NB: non basta fare loop interchange per attivare 
    // l'autovettorizzatore
    // for (int k = 0; k < K; k++) {
    //     for (int j = 0; j < N; j++) {
    //         for (int i = 0; i < M; i++) {
    //             C[i * N + j] += A[i * K + k] * B[k * N + j];
    //         }
    //     }
    // }

    // Ciclo sulle righe di C
    for (int i = 0; i < M; i++) {
        // Inizializzazione dell'accumulatore a zero tramite intrinseco
        // Questo esegue il broadcast dello 0 su tutte le lane del registro.
        vNaccint_t acc = vvcmpy_lo ((vNint_t)0, (vNint_t)0);

        // Loop sulla dimensione interna K (somma dei outer product)
        for (int k = 0; k < K; k++) {
            // Caricamento dell'intera riga 'k' di B in un registro vettoriale
            vNint_t vecB_row = vvld(&B[k * N]);
            // Recupero del singolo elemento A[i][k]
            int scalarA = A[i * K + k];
            // vvcmac_lo esegue il BROADCAST IMPLICITO dello scalare scalarA.
            // Moltiplica scalarA per ogni elemento di vecB_row e accumula in acc.
            acc = vvcmac_lo(acc, vecB_row, scalarA);
        }

        // Store finale della riga i-esima di C
        // L'intrinseco to_vNint_t converte l'accumulatore
        // (con guard bits) in un vettore standard a 32 bit.
        // vstoreN(to_vNint_t(acc), &C[i * N]);
        vvst(to_vNint_t(acc), &C[i * N]);
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