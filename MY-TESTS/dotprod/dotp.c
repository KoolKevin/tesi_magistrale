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


    vNint_t vec_a; 
    vNint_t vec_b; 
    // inizializziamo l'accumulatore a zero
    vNaccint_t acc = vvcmpy_lo ((vNint_t)0, (vNint_t)0);

    int lanes = _VDSP_NUM_32BIT_LANES;
    int n_rounded = (n/lanes) * lanes;
    for (int i = 0; i < n_rounded; i+=lanes) {
        vec_a = vvld(&a[i]);
        vec_b = vvld(&b[i]);
        acc = vvcmac_lo(acc, vec_a, vec_b);
    }

    // nell'llvm-ir della versione autovettorizzata
    // la riduzione viene fatta attraverso un intrinseco
    // llvm NON della PPU. Questo mi fa pensare che non
    // esista un intrinseco pronto per il mio caso e
    // quindi faccio la riduzione finale a mano.
    // (nell'assembly, non so come mai ma fa una riduzione
    // a coppie e non a quadruple).
    acc = vvc4add(acc);
    acc = vvc4pack(acc);
    acc = vvc4add(acc);
    acc = vvc4pack(acc);
    int res = (to_vNint_t(acc))[0];

    // remainder loop scalare
    for (int i = n_rounded; i < n; i++) {
        res += a[i] * b[i];
    }

    return res;
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