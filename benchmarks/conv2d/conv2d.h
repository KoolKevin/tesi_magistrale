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

extern void vekt_conv2d(
    int rows_out, int cols_out, int rows_in, int cols_in, int K,
    int* output_alloc, int* output_align, int output_offset,
    int output_size_1, int output_size_2, int output_stride_1, int output_stride_2,
    int* input_alloc, int* input_align, int input_offset,
    int input_size_1, int input_size_2, int input_stride_1, int input_stride_2,
    int* kernel_alloc, int* kernel_align, int kernel_offset,
    int kernel_size_1, int kernel_size_2, int kernel_stride_1, int kernel_stride_2
    );

void vekt_conv2d_wrapper(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           int* output, int* input, int* kernel);

#endif // #ifdef MATMUL_H