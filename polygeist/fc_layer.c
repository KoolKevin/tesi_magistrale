// Matmul tra matrici con dimensioni:
// - A -> MxK
// - B -> KxN
// - C -> MxN
void fc_layer(int M, int N, int K, int A[M][K], int B[K][N], int C[M][N],
              int bias[N]) {
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      for (int k = 0; k < K; k++) {
        C[i][j] += A[i][k] * B[k][j];
      }
      C[i][j] += bias[j];
    }
  }
}

// version con accumulatore
// void fc_layer(int M, int N, int K, int A[M][K], int B[K][N], int C[M][N]) {
//   for (int i = 0; i < M; i++) {
//     for (int j = 0; j < N; j++) {
//       int acc = 0;
//       for (int k = 0; k < K; k++) {
//         acc += A[i][k] * B[k][j];
//       }
//       C[i][j] = acc;
//     }
//   }
// }
