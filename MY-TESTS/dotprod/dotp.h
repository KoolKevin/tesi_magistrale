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

#endif // #ifdef DOTP_H