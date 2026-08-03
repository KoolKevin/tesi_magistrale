#include "mat_reduce_cols.h"
#include <stdio.h>

void init_matrix(int *a, int M, int N, int value) {
  for (int i = 0; i < M * N; i++) {
    a[i] = value;
  }
}

void init_vector(int *a, int dim, int value) {
    for (int i = 0; i < dim; i++) {
        a[i] = value;
    }
}

void check_result(int* A, int* B, int M) {
    for(int i = 0; i < M; i++) {
        if (A[i] != B[i]) {
            printf("ERRORE! I vettori non corrispondono!\n");
            printf("\tElemento (%d) di A = %d mentre B = %d\n", 
                i, A[i], B[i]);
            return;
        }
    }

    printf("SUCCESSO! I vettori sono uguali\n");
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

void print_vector(int* A, int M) {
    printf("[");
    for(int i = 0; i < M; i++) {
        if (i == M-1)
            printf("%d", A[i]); 
        else
            printf("%d,", A[i]); 
    }
    printf("]\n");
}

void mat_reduce_cols(int *A, int *res, int M, int N) {
    #pragma clang loop vectorize(disable)
    for (int j = 0; j < N; j++) {
        int acc = 0;
        #pragma clang loop vectorize(disable)
        for (int i = 0; i < M; i++) {
            acc += A[i*N + j];
        }
        res[j] = acc;
    }
}


void vectorized_mat_reduce_cols(__vccm int* restrict A,
                       __vccm int* restrict res,
                       int M,
                       int N) {

    int lanes = _VDSP_NUM_32BIT_LANES;
    int N_rounded = (N/lanes) * lanes;


    for (int j_vec = 0; j_vec < N_rounded; j_vec += lanes) {
        vNint_t acc = (vNint_t)0;
        for (int i = 0; i < M; i++) {
            vNint_t vec_row = vvld(&A[i*N + j_vec]);
            acc = vvadd(acc, vec_row);
        }
        vvst(acc, &res[j_vec]);
    }

    // remainder loop scalare
    for (int j = N_rounded; j < N; j++) {
        int acc = 0;
        for (int i = 0; i < M; i++) {
            acc += A[i*N + j];
        }
        res[j] = acc;
    }
}

void autovectorized_mat_reduce_cols(__vccm int* restrict A,
                       __vccm int* restrict res,
                       int M,
                       int N) {
    for (int j = 0; j < N; j++) {
        int acc = 0;
        for (int i = 0; i < M; i++) {
            acc += A[i*N + j];
        }
        res[j] = acc;
    }
}



void vekt_mat_reduce_cols_wrapper(int *A, int *res, int M, int N) {
    // vekt_mat_reduce_cols(
    //     M, N, 
    //     a, a, 0, M, K, K, 1,
    //     b, b, 0, K, N, N, 1,
    //     c, c, 0, M, N, N, 1
    // );

    return;
}