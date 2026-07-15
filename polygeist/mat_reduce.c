int reduce_into_scalar(int M, int N, int A[M][N]) {
  int res = 0;
  for (int i = 0; i < M; i++) {
    for (int j = 0; j < N; j++) {
      res += A[i][j];
    }
  }

  return res;
}

void reduce_rows(int M, int N, int A[M][N], int res[M]) {
  for (int i = 0; i < M; i++) {
    int acc = 0;
    for (int j = 0; j < N; j++) {
      acc += A[i][j];
    }
    res[i] = acc;
  }
}

void reduce_cols(int M, int N, int A[M][N], int res[N]) {
  for (int j = 0; j < N; j++) {
    int acc = 0;
    for (int i = 0; i < M; i++) {
      acc += A[i][j];
    }
    res[j] = acc;
  }
}
