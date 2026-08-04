#include "transpose.h"
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

void transpose(int *a, int *t, int M, int N) {
    #pragma clang loop vectorize(disable)
    for (int i = 0; i < M; i++) {
        #pragma clang loop vectorize(disable)
        for (int j = 0; j < N; j++) {
            t[j*M + i] = a[i*N + j]; 
        }
    }
}

void vectorized_transpose(__vccm int* restrict a,
                       __vccm int* restrict t,
                       int M,
                       int N) {
    
    int lanes = _VDSP_NUM_32BIT_LANES;
    int N_rounded = (N/lanes) * lanes;

    // contiene [0, 1, 2, ..., 15]
    vNint_t idx = vvci_w();
    // scrivere una colonna significa scrivere a salti
    // grandi quanto la dimensione della (M nel caso
    // della trasposta).
    //
    // contiene [0, M, 2M, ..., 15M]
    vNint_t offsets = idx * (vNint_t)M;

    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N_rounded; j+=lanes) {
            vNint_t row_segment = vvld(&a[i*N + j]);
            vscatter(row_segment, &t[j*M + i], offsets);
        }
    }

    for (int i = 0; i < M; i++) {
        for (int j = N_rounded; j < N; j++) {
            t[j*M + i] = a[i*N + j]; 
        }
    }
}

void autovectorized_transpose(__vccm int* restrict a,
                           __vccm int* restrict t,
                           int M,
                           int N) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            t[j*M + i] = a[i*N + j]; 
        }
    }
}

void vekt_transpose_wrapper(int* a, int* t, int M, int N) {
    vekt_transpose(
        M, N, 
        a, a, 0, M, N, N, 1,
        t, t, 0, N, M, M, 1
    );

    return;
}