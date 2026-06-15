void matmul(int *A, int *B, int *C, int M, int K, int N) {
  for (int i = 0; i < M * N; i++) {
    C[i] = 0;
  }

  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      for (int k = 0; k < K; k++) {
        C[i * N + j] += A[i * K + k] * B[k * N + j];
      }
    }
  }
}
