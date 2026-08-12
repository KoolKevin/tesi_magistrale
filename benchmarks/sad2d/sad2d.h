#ifndef MATMUL_H
#define MATMUL_H

#include <arc_vector.h>

void init_matrix(int *a, int M, int N, int value);

void check_result(int* A, int* B, int M, int N);

int* copy_matrix(int* dst, int* src, int M, int N); 

void print_matrix(int* A, int M, int N); 

int sad2d(int rows, int cols, int* input1, int* input2); 

int vectorized_sad2d(int rows, int cols, __vccm int* restrict input1, __vccm int* restrict input2);

int autovectorized_sad2d(int rows, int cols, __vccm int* restrict input1, __vccm int* restrict input2); 

// extern void vekt_sad2d(
//     int rows_out, int cols_out, int rows_in, int cols_in, int W,
//     int* output_alloc, int* output_align, int output_offset,
//     int output_size_1, int output_size_2, int output_stride_1, int output_stride_2,
//     int* input_alloc, int* input_align, int input_offset,
//     int input_size_1, int input_size_2, int input_stride_1, int input_stride_2
// );

int vekt_sad2d_wrapper(int rows, int cols, int* input1, int* input2);

#endif // #ifdef MATMUL_H