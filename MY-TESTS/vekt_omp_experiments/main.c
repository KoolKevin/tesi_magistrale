#include </usr/lib/llvm-21/lib/clang/21/include/omp.h>
#include <stdint.h>
#include <stdio.h>

#include <immintrin.h>
#include <x86intrin.h>

#define N 1024 * 1024 * 16
#define NUM_THREADS 8
#define NUM_LANES_INT 8
#define VECTOR_SIZE_BYTES 32 // 256bit

extern void vekt_vec_sum(int *a_alloc, int *a_align, int64_t a_offset,
                         int64_t a_size, int a_stride, int *b_alloc,
                         int *b_align, int64_t b_offset, int64_t b_size,
                         int64_t b_stride, int *c_alloc, int *c_align,
                         int64_t c_offset, int64_t c_size, int64_t c_stride,
                         int32_t n);

void vekt_vec_sum_wrapper(int *a, int *b, int *c, int n) {
  vekt_vec_sum(a, a, 0, n, 1, b, b, 0, n, 1, c, c, 0, n, 1, n);
}

int main(int argc, char **argv) {
  if (argc != 2) {
    return -1;
  }
  int scelta = atoi(argv[1]);

  omp_set_num_threads(NUM_THREADS);

  int *a = (int *)_mm_malloc(N * sizeof(int), VECTOR_SIZE_BYTES);
  int *b = (int *)_mm_malloc(N * sizeof(int), VECTOR_SIZE_BYTES);
  int *c = (int *)_mm_malloc(N * sizeof(int), VECTOR_SIZE_BYTES);

  // Inizializzazione degli array con valori casuali
  for (int i = 0; i < N; i++) {
    a[i] = i + 1;
    b[i] = i + 1;
    c[i] = -1;
  }

  uint64_t start;
  uint64_t end;

  //   /***** versione sequenziale *****/

  start = __rdtsc();
#pragma clang loop vectorize(disable)
  for (int i = 0; i < N; i++) {
    c[i] = a[i] + b[i];
  }
  end = __rdtsc();
  uint64_t time_scalar = end - start;
  printf("Tempo di esecuzione di vec_sum: %lu clock\n", time_scalar);
  printf("\n");

  switch (scelta) {

  case 1: {
    /***** versione AVX *****/

    for (int i = 0; i < N; i++) {
      c[i] = -1;
    }

    start = __rdtsc();
    for (int i = 0; i < N; i += NUM_LANES_INT) {
      __m256i veca = _mm256_load_si256((__m256i *)&a[i]);
      __m256i vecb = _mm256_load_si256((__m256i *)&b[i]);
      __m256i vec_sum = _mm256_add_epi32(veca, vecb);
      _mm256_store_si256((__m256i *)&c[i], vec_sum);
    }
    end = __rdtsc();
    uint64_t time_avx = end - start;
    printf("clock avx: %lu clock\n", time_avx);
    printf("speedup: %.2fx\n", (double)time_scalar / time_avx);
    printf("Primi 5 elementi della somma:\n");
    for (int i = 0; i < 5; i++) {
      printf("a[%d]=%d, b[%d]=%d, c[%d]=%d\n", i, a[i], i, b[i], i, c[i]);
    }
    printf("\n");
  } // break;

  case 2: {
    /***** versione omp *****/

    for (int i = 0; i < N; i++) {
      c[i] = -1;
    }

    start = __rdtsc();
#pragma omp parallel for
    for (int i = 0; i < N; i++) {
      c[i] = a[i] + b[i];
    }
    end = __rdtsc();
    uint64_t time_omp = end - start;
    printf("clock omp: %lu clock\n", time_omp);
    printf("speedup: %.2fx\n", (double)time_scalar / time_omp);
    printf("Primi 5 elementi della somma:\n");
    for (int i = 0; i < 5; i++) {
      printf("a[%d]=%d, b[%d]=%d, c[%d]=%d\n", i, a[i], i, b[i], i, c[i]);
    }
    printf("\n");
  } // break;

  case 3: {
    /***** versione AVX + omp *****/

    for (int i = 0; i < N; i++) {
      c[i] = -1;
    }

    start = __rdtsc();
#pragma omp parallel for
    for (int i = 0; i < N; i += NUM_LANES_INT) {
      __m256i veca = _mm256_load_si256((__m256i *)&a[i]);
      __m256i vecb = _mm256_load_si256((__m256i *)&b[i]);
      __m256i vec_sum = _mm256_add_epi32(veca, vecb);
      _mm256_store_si256((__m256i *)&c[i], vec_sum);
    }
    end = __rdtsc();
    uint64_t time_avx_omp = end - start;
    printf("clock avx-omp: %lu clock\n", time_avx_omp);
    printf("speedup: %.2fx\n", (double)time_scalar / time_avx_omp);
    printf("Primi 5 elementi della somma:\n");
    for (int i = 0; i < 5; i++) {
      printf("a[%d]=%d, b[%d]=%d, c[%d]=%d\n", i, a[i], i, b[i], i, c[i]);
    }
    printf("\n");
  } // break;

  case 4: {
    /***** versione vekt *****/

    for (int i = 0; i < N; i++) {
      c[i] = -1;
    }

    start = __rdtsc();
    vekt_vec_sum_wrapper(a, b, c, N);
    end = __rdtsc();
    uint64_t time_vekt = end - start;
    printf("clock vekt: %lu clock\n", time_vekt);
    printf("speedup: %.2fx\n", (double)time_scalar / time_vekt);
    printf("Primi 5 elementi della somma:\n");
    for (int i = 0; i < 5; i++) {
      printf("a[%d]=%d, b[%d]=%d, c[%d]=%d\n", i, a[i], i, b[i], i, c[i]);
    }
    printf("\n");
  } // break;
  }

  return 0;
}
