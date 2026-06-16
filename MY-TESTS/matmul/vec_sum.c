#include "vec_sum.h"

void vec_sum(int* a, int* b, int* c, int n) {
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
    int num_vectors = n / lanes;

    for (int i = 0; i < num_vectors; i++) {
        va = vvld(&a[i*lanes]);
        vb = vvld(&b[i*lanes]);
        vc = vvadd(va, vb);
        vvst(vc, &c[i*lanes]);
    }

    // TODO: Gestione del resto, aggiungi un loop scalare per gli ultimi elementi.
}

void autovectorized_vec_sum(__vccm int* restrict a,
                            __vccm int* restrict b,
                            __vccm int* restrict c,
                            int n) {
    for(int i = 0; i < n; i++)
        c[i] = a[i] + b[i];
}

