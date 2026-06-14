#include "vec_sum.h"

void vec_sum(int* a, int* b, int* c, int n) {
	for(int i = 0; i < n; i++)
		c[i] = a[i] + b[i];
}

void vectorized_vec_sum(__vccm int* restrict a, 
                        __vccm int* restrict b, 
                        __vccm int* restrict c, 
                        int n) {
    
    // Cast dei puntatori scalari a puntatori vettoriali
    // - to_vNptr converte un puntatore __vccm int* in __vccm vNint_t*
    // dove vNint_t rappresenta un vettore di interi grande quanto un registro 
    // vettoriale 
    vNint_t __vccm *va = to_vNptr(a);
    vNint_t __vccm *vb = to_vNptr(b);
    vNint_t __vccm *vc = to_vNptr(c);

    // Determinazione della larghezza SIMD (numero di interi per registro vettoriale)
    int lanes = _VDSP_NUM_32BIT_LANES;
    int num_vectors = n / lanes;

    for (int i = 0; i < num_vectors; i++) {
        // Caricamento vettoriale (Intrinsic vvld)
        vNint_t v_a = vvld((__vccm int*)(va+i));
        vNint_t v_b = vvld((__vccm int*)(vb+i));

        // Somma vettoriale
        vNint_t v_res = vvadd(v_a, v_b);

        // l'operatore '+' è overloaded 
        //vNint_t v_res = v_a + v_b;

        // Memorizzazione vettoriale (Intrinsic vvst)
        vvst(v_res, (__vccm int*)(vc+i));
    }

    // TODO: Gestione del resto, aggiungi un loop scalare per gli ultimi elementi.
}