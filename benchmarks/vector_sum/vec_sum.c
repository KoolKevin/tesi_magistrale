#include "vec_sum.h"

void init_vector(int *a, int dim, int value) {
  for (int i = 0; i < dim; i++) {
    a[i] = value;
  }
}

void vec_sum(int* a, int* b, int* c, int n) {
    #pragma clang loop vectorize(disable)
	for(int i = 0; i < n; i++)
		c[i] = a[i] + b[i];
}

void vectorized_vec_sum(__vccm int* restrict a, 
                        __vccm int* restrict b, 
                        __vccm int* restrict c, 
                        int n) {
    
    vNint_t va = 0;
    vNint_t vb = 0;
    vNint_t vc = 0;

    int lanes = _VDSP_NUM_32BIT_LANES;
    int n_rounded = (n/lanes) * lanes;

    for (int i = 0; i < n_rounded; i += lanes) {
        va = vvld(&a[i]);
        vb = vvld(&b[i]);
        vc = vvadd(va, vb);
        vvst(vc, &c[i]);
    }

    // loop scalare per la gestione degli ultimi elementi
    for (int i = n_rounded; i < n; i++) {
		c[i] = a[i] + b[i];
    }
}

void autovectorized_vec_sum(__vccm int* restrict a,
                            __vccm int* restrict b,
                            __vccm int* restrict c,
                            int n) {
    for(int i = 0; i < n; i++)
        c[i] = a[i] + b[i];
}

void vekt_vec_sum_wrapper(int* a, int* b, int* c, int n) {
    vekt_vec_sum(
        a, a, 0, n, 1,
        b, b, 0, n, 1,
        c, c, 0, n, 1,
        n
    );
}