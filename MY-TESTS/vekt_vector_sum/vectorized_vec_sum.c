#include <arc_vector.h>

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

    // commentiamo via per semplificare l'output
    // // loop scalare per la gestione degli ultimi elementi
    // int start = num_vectors*lanes;
    // int end = start + n%lanes;
    // for (int i = start; i < end; i++) {
	// 	c[i] = a[i] + b[i];
    // }
}