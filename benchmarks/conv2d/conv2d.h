#ifndef MATMUL_H
#define MATMUL_H

#include <arc_vector.h>

void init_matrix(int *a, int M, int N, int value);

void check_result(int* A, int* B, int M, int N);

int* copy_matrix(int* dst, int* src, int M, int N); 

void print_matrix(int* A, int M, int N); 

void conv2d(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           int* output, int* input, int* kernel); 

void vectorized_conv2d(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           __vccm int* restrict output, 
           __vccm int* restrict input,
           __vccm int* restrict kernel);

void autovectorized_conv2d(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           __vccm int* restrict output, 
           __vccm int* restrict input,
           __vccm int* restrict kernel); 

// extern void vekt_conv2d(
//     int M, int N, int K,
//     int* a_alloc, int* a_align, int a_offset,
//     int a_size_1, int a_size_2, int a_stride_1, int a_stride_2,
//     int* b_alloc, int* b_align, int b_offset,
//     int b_size_1, int b_size_2, int b_stride_1, int b_stride_2,
//     int* c_alloc, int* c_align, int c_offset,
//     int c_size_1, int c_size_2, int c_stride_1, int c_stride_2
//     );

void vekt_conv2d_wrapper(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           int* output, int* input, int* kernel);

#endif // #ifdef MATMUL_H