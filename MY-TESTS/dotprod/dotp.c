#include "dotp.h"

int dotp(int* a, int* b, int n) {
    int res = 0;

    #pragma clang loop vectorize(disable)
    for (int i = 0; i < n; i++) {
        res += a[i] * b[i];
    }

    return res;
}

int vectorized_dotp(__vccm int* restrict a, 
                    __vccm int* restrict b, 
                    int n) {

    return 0;
}

int autovectorized_dotp(__vccm int* restrict a,
                         __vccm int* restrict b,
                         int n) {

    int res = 0;
    for (int i = 0; i < n; i++) {
        res += a[i] * b[i];
    }

    return res;
}