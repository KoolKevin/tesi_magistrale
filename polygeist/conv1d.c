// Assumo:
// - K dispari
// - no padding -> output è più piccolo
void conv1d(int N_out, int N_in, int W, int *output, int *input, int *window) {
  for (int i = 0; i < N_out; i++) {
    for (int w_i = 0; w_i < W; w_i++) {
      output[i] += input[i + w_i] * window[w_i];
    }
  }
}
