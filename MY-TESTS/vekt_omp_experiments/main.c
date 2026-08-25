#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include <immintrin.h>
#include <x86intrin.h>

#define N 1024 * 1024 * 16
// #define NUM_THREADS 8

extern void vekt_vec_sum(int *a_alloc, int *a_align, int64_t a_offset,
                         int64_t a_size, int a_stride, int *b_alloc,
                         int *b_align, int64_t b_offset, int64_t b_size,
                         int64_t b_stride, int *c_alloc, int *c_align,
                         int64_t c_offset, int64_t c_size, int64_t c_stride,
                         int32_t n);

void vekt_vec_sum_wrapper(int *a, int *b, int *c, int n) {
  vekt_vec_sum(a, a, 0, n, 1, b, b, 0, n, 1, c, c, 0, n, 1, n);
}

int main() {
  int *a = (int *)_mm_malloc(N * sizeof(int), 16);
  int *b = (int *)_mm_malloc(N * sizeof(int), 16);
  int *c = (int *)_mm_malloc(N * sizeof(int), 16);

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
#pragma omp parallel for simd // num_threads(NUM_THREADS)
  for (int i = 0; i < N; i += 4) {
    __m128i veca = _mm_load_si128((__m128i *)&a[i]);
    __m128i vecb = _mm_load_si128((__m128i *)&b[i]);
    __m128i vec_sum = _mm_add_epi32(veca, vecb);
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
  vekt_vec_sum_wrapper(a, b, c, N);
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
