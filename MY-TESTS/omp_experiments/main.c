#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include <immintrin.h>
#include <x86intrin.h>

#define N 1024 * 1024 * 16
#define NUM_THREADS 8

extern void vec_sum_omp(int8_t *a, int8_t *b, int8_t *c, long n,
                        int num_threads);

int main() {
  int8_t *a = (int8_t *)malloc(N * sizeof(int8_t));
  int8_t *b = (int8_t *)malloc(N * sizeof(int8_t));
  int8_t *c = (int8_t *)malloc(N * sizeof(int8_t));

  // Inizializzazione degli array con valori casuali
  for (int i = 0; i < N; i++) {
    a[i] = i + 1;
    b[i] = i + 1;
    c[i] = -1;
  }

  uint64_t start = __rdtsc();
  for (int i = 0; i < N; i++) {
    c[i] = a[i] + b[i];
  }
  uint64_t end = __rdtsc();
  uint64_t time_scalar = end - start;
  printf("Tempo di esecuzione di vec_sum: %lu clock\n", time_scalar);
  printf("\n");

  // versione omp
  for (int i = 0; i < N; i++) {
    c[i] = -1;
  }

  start = __rdtsc();
#pragma omp parallel for simd num_threads(NUM_THREADS)
  for (int i = 0; i < N; i += 16) {
    __m128i veca = _mm_load_si128((__m128i *)&a[i]);
    __m128i vecb = _mm_load_si128((__m128i *)&b[i]);
    __m128i vec_sum = _mm_add_epi8(veca, vecb);
    _mm_store_si128((__m128i *)&c[i], vec_sum);
  }
  end = __rdtsc();
  uint64_t time_omp = end - start;
  printf("Tempo di esecuzione di vec_sum_omp: %lu clock\n", time_omp);
  printf("speedup: %.2fx\n", (double)time_scalar / time_omp);
  printf("Primi 5 elementi della somma:\n");
  for (int i = 0; i < 5; i++) {
    printf("a[%d]=%d, b[%d]=%d, c[%d]=%d\n", i, a[i], i, b[i], i, c[i]);
  }
  printf("\n");

  // versione omp-mlir
  for (int i = 0; i < N; i++) {
    c[i] = -1;
  }

  start = __rdtsc();
  vec_sum_omp(a, b, c, N, NUM_THREADS);
  end = __rdtsc();
  uint64_t time_omp_mlir = end - start;
  printf("Tempo di esecuzione di vec_sum_omp_mlir: %lu clock\n", time_omp_mlir);
  printf("speedup: %.2fx\n", (double)time_scalar / time_omp_mlir);
  printf("Primi 5 elementi della somma:\n");
  for (int i = 0; i < 5; i++) {
    printf("a[%d]=%d, b[%d]=%d, c[%d]=%d\n", i, a[i], i, b[i], i, c[i]);
  }
  printf("\n");

  return 0;
}
