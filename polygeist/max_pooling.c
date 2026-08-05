void max_pooling(int rows_out, int cols_out, int rows_in, int cols_in, int W,
                 int output[rows_out][cols_out], int input[rows_in][cols_in]) {

  for (int i = 0; i < rows_out; i++) {
    for (int j = 0; j < cols_out; j++) {
      int curMax = -1;
      for (int w_i = 0; w_i < W; w_i++) {
        for (int w_j = 0; w_j < W; w_j++) {
          // devo estrarre in una variabile separata per non far emettere l'if
          int val = input[i * W + w_i][j * W + w_j];
          curMax = (val > curMax) ? val : curMax;
        }
      }
      output[i][j] = curMax;
    }
  }
}
