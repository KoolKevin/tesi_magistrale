#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define N 1024 * 1024 * 16
#define NUM_THREADS 1

extern void vec_sum_omp(double *a, double *b, double *c, long n,
                        int num_threads);

int main() {
  double *a = (double *)malloc(N * sizeof(double));
  double *b = (double *)malloc(N * sizeof(double));
  double *c = (double *)malloc(N * sizeof(double));

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
#pragma omp parallel for num_threads(NUM_THREADS)
  for (int i = 0; i < N; i++) {
    c[i] = a[i] + b[i];
  }
  end = __rdtsc();
  uint64_t time_omp = end - start;
  printf("Tempo di esecuzione di vec_sum_omp: %lu clock\n", time_omp);
  printf("speedup: %.2fx\n", (double)time_scalar / time_omp);
  printf("Primi 5 elementi della somma:\n");
  for (int i = 0; i < 5; i++) {
    printf("a[%d]=%f, b[%d]=%f, c[%d]=%f\n", i, a[i], i, b[i], i, c[i]);
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
    printf("a[%d]=%f, b[%d]=%f, c[%d]=%f\n", i, a[i], i, b[i], i, c[i]);
  }
  printf("\n");

  return 0;
}
