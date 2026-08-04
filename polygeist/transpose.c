void transpose(int M, int N, int a[M][N], int t[N][M]) {
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      t[j][i] = a[i][j];
    }
  }
}
