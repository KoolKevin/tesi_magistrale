#ifndef VEC_SUM_H
#define VEC_SUM_H

#include <arc_vector.h>

void init_vector(int *a, int dim, int value);

void print_vector(int* a, int N);

void copy_vector(int* src, int* dst, int N);

void check_result(int* result, int* groundtruth, int N);

void conv1d(int N_out, int N_in, int W, int output[N_out], int input[N_in], int window[W]);

void vectorized_conv1d(int N_out, int N_in, int W,
    __vccm int* restrict output,
    __vccm int* restrict input, 
    __vccm int* restrict window);

void autovectorized_conv1d(int N_out, int N_in, int W,
    __vccm int* restrict output,
    __vccm int* restrict input, 
    __vccm int* restrict window);

// extern void vekt_conv1d(int* a_alloc, int* a_align, int a_offset, int a_size, int a_stride,
//                     int* b_alloc, int* b_align, int b_offset, int b_size, int b_stride,
//                     int* c_alloc, int* c_align, int c_offset, int c_size, int c_stride,
//                     int32_t n);

void vekt_conv1d_wrapper(int N_out, int N_in, int W, int output[N_out], int input[N_in], int window[W]);

#endif // #ifdef VEC_SUM_H