#ifndef DOTP_H
#define DOTP_H

#include <arc_vector.h>

int dotp(int* a, int* b, int n);

int vectorized_dotp(__vccm int* restrict a, 
                    __vccm int* restrict b, 
                    int n);

int autovectorized_dotp(__vccm int* restrict a,
                         __vccm int* restrict b,
                         int n);

extern int vekt_dotp(int* a_alloc, int* a_align, int a_offset, int a_size, int a_stride,
                    int* b_alloc, int* b_align, int b_offset, int b_size, int b_stride,
                    int32_t n);

int vekt_dotp_wrapper(int* a, int* b, int n);

#endif // #ifdef DOTP_H