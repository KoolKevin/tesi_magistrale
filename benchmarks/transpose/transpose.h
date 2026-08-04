#ifndef MATMUL_H
#define MATMUL_H

#include <arc_vector.h>

void init_matrix(int *a, int M, int N, int value);

void check_result(int* A, int* B, int M, int N);

int* copy_matrix(int* dst, int* src, int M, int N); 

void print_matrix(int* A, int M, int N); 

void transpose(int *a, int *t, int M, int N); 

void vectorized_transpose(__vccm int* restrict a,
                           __vccm int* restrict t,
                           int M,
                           int N); 

void autovectorized_transpose(__vccm int* restrict a,
                           __vccm int* restrict t,
                           int M,
                           int N); 

extern void vekt_transpose(
    int M, int N, 
    int* a_alloc, int* a_align, int a_offset,
    int a_size_1, int a_size_2, int a_stride_1, int a_stride_2,
    int* t_alloc, int* t_align, int t_offset,
    int t_size_1, int t_size_2, int t_stride_1, int t_stride_2
);

void vekt_transpose_wrapper(int* a, int* t, int M, int N);

#endif // #ifdef MATMUL_H