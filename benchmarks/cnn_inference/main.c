#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <arc_vector.h>

#include "mylib.h"



// K è la dimensione comune

__vccm int conv_weights[3 * 3];
__vccm int conv_bias[1];
__vccm int fc_weights[256*16];
__vccm int fc_bias[16];
__vccm int in[34 * 34];
__vccm int out_conv[32 * 32];
__vccm int out_pool[16 * 16];
__vccm int out_fc[16];

int main() {
    init_matrix(in, 34, 34, 1);
    init_matrix(conv_weights, 3, 3, 1);
    init_matrix(conv_bias, 1, 1, 1);
    init_matrix(fc_weights, 256, 16, 1);
    init_matrix(fc_bias, 1, 16, 1);

    /******** versione sequenziale ********/
    printf("Versione sequenziale\n");
    clock_t start = clock();
    conv2d(32, 32, 34, 34, 3, out_conv, in, conv_weights);
    elementwise_sum_scalar(32, 32, out_conv, conv_bias[0]);
    elementwise_max_scalar(32, 32, out_conv, 0); // ReLU

    max_pooling(16, 16, 32, 32, 2, out_pool, out_conv);

    matmul(1, 16, 256, out_pool, fc_weights, out_fc);
    elementwise_sum(1, 16, out_fc, fc_bias);
    elementwise_max_scalar(1, 16, out_fc, 0); // ReLU

    int classifier_result = reduce_vector_max(16, out_fc); // argmax
    clock_t end = clock();   
    double time_scalar = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vekt: %.2fms\n", time_scalar);

	/******** versione vekt-vettorizzata ********/
    printf("Versione vekt-vettorizzata\n");
    start = clock();
    // conv layer
    vekt_conv2d_wrapper(32, 32, 34, 34, 3, out_conv, in, conv_weights);
    elementwise_sum_scalar(32, 32, out_conv, conv_bias[0]);
    elementwise_max_scalar(32, 32, out_conv, 0); // ReLU

    vekt_max_pooling_wrapper(16, 16, 32, 32, 2, out_pool, out_conv);

    // fc layer
    vekt_matmul_wrapper(1, 16, 256, out_pool, fc_weights, out_fc);
    elementwise_sum(1, 16, out_fc, fc_bias);
    elementwise_max_scalar(1, 16, out_fc, 0); // ReLU

    classifier_result = reduce_vector_max(16, out_fc); // argmax
    end = clock();   
    double time_vekt = ((double)(end-start) / CLOCKS_PER_SEC)*1000; // in ms
    printf("Tempo di esecuzione di vekt: %.2fms\n", time_vekt);
    printf("Speedup: %.2f\n", time_scalar/time_vekt);

    printf("\n");

    return 0;
}