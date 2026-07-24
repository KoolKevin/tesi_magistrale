#ifndef VEC_SUM_H
#define VEC_SUM_H

#include <arc_vector.h>

void init_vector(int *a, int dim, int value);

void vec_sum(int* a, int* b, int* c, int n);

void vectorized_vec_sum(__vccm int* restrict a, 
                        __vccm int* restrict b, 
                        __vccm int* restrict c, 
                        int n);

void autovectorized_vec_sum(__vccm int* restrict a,
                            __vccm int* restrict b,
                            __vccm int* restrict c,
                            int n);

extern void vekt_vec_sum(int* a_alloc, int* a_align, int a_offset, int a_size, int a_stride,
                    int* b_alloc, int* b_align, int b_offset, int b_size, int b_stride,
                    int* c_alloc, int* c_align, int c_offset, int c_size, int c_stride,
                    int32_t n);

void vekt_vec_sum_wrapper(int* a, int* b, int* c, int n);

#endif // #ifdef VEC_SUM_H