#ifndef MATMUL_H
#define MATMUL_H

#include <arc_vector.h>

void init_matrix(int *a, int M, int N, int value);

void matmul(int *A, int *B, int *C, int M, int K, int N); 

void vectorized_matmul(__vccm int* restrict A,
                           __vccm int* restrict B,
                           __vccm int* restrict C,
                           int M,
                           int K,
                           int N); 

void autovectorized_matmul(__vccm int* restrict A,
                           __vccm int* restrict B,
                           __vccm int* restrict C,
                           int M,
                           int K,
                           int N); 
#endif // #ifdef MATMUL_H