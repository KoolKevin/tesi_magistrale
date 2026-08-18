// int dotp(int *a, int *b, int n) {
//   int res = 0;
//   for (int i = 0; i < n; i++) {
//     res += a[i] * b[i];
//   }

//   return res;
// }
int res = 0;

void dotp(int *a, int *b, int n) {
  for (int i = 0; i < n; i++) {
    res += a[i] * b[i];
  }
}
