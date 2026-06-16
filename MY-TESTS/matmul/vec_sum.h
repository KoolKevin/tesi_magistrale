#ifndef VEC_SUM_H
#define VEC_SUM_H

#include <arc_vector.h>

void vec_sum(int* a, int* b, int* c, int n);

void vectorized_vec_sum(__vccm int* restrict a, 
                        __vccm int* restrict b, 
                        __vccm int* restrict c, 
                        int n);

void autovectorized_vec_sum(__vccm int* restrict a,
                            __vccm int* restrict b,
                            __vccm int* restrict c,
                            int n);

#endif // #ifdef VEC_SUM_H