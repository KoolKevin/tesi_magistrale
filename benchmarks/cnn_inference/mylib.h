#ifndef MATMUL_H
#define MATMUL_H

#include <arc_vector.h>

#define max(a, b) (((a) > (b)) ? (a) : (b))

void init_matrix(int *a, int M, int N, int value);

void check_result(int* A, int* B, int M, int N);

int* copy_matrix(int* dst, int* src, int M, int N); 

void print_matrix(int* A, int M, int N); 

void elementwise_sum(int M, int N, __vccm int* restrict A, __vccm int* restrict B);

void elementwise_sum_scalar(int M, int N, __vccm int* restrict A, int B);

int reduce_vector_max(int N, __vccm int* restrict A);

void elementwise_max_scalar(int M, int N, __vccm int* restrict A, int B);

void conv2d(int rows_out, int cols_out, int rows_in, int cols_in, int K,
           __vccm int* restrict output, __vccm int* restrict input, __vccm int* restrict kernel); 

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

void matmul(int M, int N, int K, __vccm int* restrictA, __vccm int* restrictB, __vccm int* restrictC); 

extern void vekt_matmul(
    int M, int N, int K,
    int* a_alloc, int* a_align, int a_offset,
    int a_size_1, int a_size_2, int a_stride_1, int a_stride_2,
    int* b_alloc, int* b_align, int b_offset,
    int b_size_1, int b_size_2, int b_stride_1, int b_stride_2,
    int* c_alloc, int* c_align, int c_offset,
    int c_size_1, int c_size_2, int c_stride_1, int c_stride_2
    );

void vekt_matmul_wrapper(int M, int N, int K, int* a, int* b, int* c);

void max_pooling(int rows_out, int cols_out, int rows_in, int cols_in, int W,
           __vccm int* restrict output, __vccm int* restrict input); 

extern void vekt_max_pooling(
    int rows_out, int cols_out, int rows_in, int cols_in, int W,
    int* output_alloc, int* output_align, int output_offset,
    int output_size_1, int output_size_2, int output_stride_1, int output_stride_2,
    int* input_alloc, int* input_align, int input_offset,
    int input_size_1, int input_size_2, int input_stride_1, int input_stride_2
);

void vekt_max_pooling_wrapper(int rows_out, int cols_out, int rows_in, int cols_in, int W,
           int* output, int* input);

#endif // #ifdef MATMUL_H