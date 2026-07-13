// Assumo:
// - K dispari
// - no padding -> output è più piccolo
void conv2d(int *output, int *input, int rows, int cols, int *kernel, int K) {
  int dim_bordo = (K - 1) / 2;
  int rows_output = rows - 2 * dim_bordo;
  int cols_output = cols - 2 * dim_bordo;

  for (int i = 0; i < rows_output; i++) {
    for (int j = 0; j < cols_output; j++) {
      for (int k_i = 0; k_i < K; k_i++) {
        for (int k_j = 0; k_j < K; k_j++) {
          int i_input = i + k_i;
          int j_input = j + k_j;
          output[i * cols_output + j] +=
              input[i_input * cols + j_input] * kernel[k_i * K + k_j];
        }
      }
    }
  }
}
