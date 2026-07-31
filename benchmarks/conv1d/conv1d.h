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

extern void vekt_conv1d(int N_out, int N_in, int W,
                    int* out_alloc, int* out_align, int out_offset, int out_size, int out_stride,
                    int* in_alloc, int* in_align, int in_offset, int in_size, int in_stride,
                    int* window_alloc, int* window_align, int window_offset, int window_size, int window_stride);

void vekt_conv1d_wrapper(int N_out, int N_in, int W, int output[N_out], int input[N_in], int window[W]);

#endif // #ifdef VEC_SUM_H