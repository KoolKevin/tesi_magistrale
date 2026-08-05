#ifndef MATMUL_H
#define MATMUL_H

#include <arc_vector.h>

void init_matrix(int *a, int M, int N, int value);

void init_vector(int *a, int dim, int value); 

void check_result(int* A, int* B, int M);

int* copy_matrix(int* dst, int* src, int M, int N); 

void print_matrix(int* A, int M, int N); 

void print_vector(int* A, int M); 

void mat_reduce_rows(int *A, int *res, int M, int N); 

void vectorized_mat_reduce_rows(__vccm int* restrict A,
                       __vccm int* restrict res,
                       int M,
                       int N); 

void autovectorized_mat_reduce_rows(__vccm int* restrict A,
                       __vccm int* restrict res,
                       int M,
                       int N); 

extern void vekt_mat_reduce_rows(
    int M, int N,
    int* a_alloc, int* a_align, int a_offset,
    int a_size_1, int a_size_2, int a_stride_1, int a_stride_2,
    int* res_alloc, int* res_align, int res_offset,
    int res_size, int res_stride
    );

void vekt_mat_reduce_rows_wrapper(int *A, int *res, int M, int N);

#endif // #ifdef MATMUL_H