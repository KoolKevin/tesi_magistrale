#ifndef MATMUL_H
#define MATMUL_H

#include <arc_vector.h>

void init_matrix(int *a, int M, int N, int value);

void check_result(int* A, int* B, int M, int N);

int* copy_matrix(int* dst, int* src, int M, int N); 

void print_matrix(int* A, int M, int N); 

void matmul(int *A, int *B, int *C, int M, int N, int K); 

void vectorized_matmul(__vccm int* restrict A,
                           __vccm int* restrict B,
                           __vccm int* restrict C,
                           int M,
                           int N,
                           int K); 

void autovectorized_matmul(__vccm int* restrict A,
                           __vccm int* restrict B,
                           __vccm int* restrict C,
                           int M,
                           int N,
                           int K); 
#endif // #ifdef MATMUL_H