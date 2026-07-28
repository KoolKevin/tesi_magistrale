# Vector sum

**Compilato con -O2**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         | 32.83 ms |   1.00× |             32.83 ms |                  1.00× |
| Vettorizzata a mano |  2.12 ms |  15.47× |              2.12 ms |                 15.47× |
| Autovettorizzata    |  1.61 ms |  20.40× |              2.12 ms |                 15.48× |
| Vekt-vettorizzata   |  2.18 ms |  15.08× |              2.18 ms |                 15.07× |

-> **NB: loop unrolling permette di fare software pipelining**


# Dotp

**Compilato con -O2**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         | 24.66 ms |   1.00× |             24.64 ms |                  1.00× |
| Vettorizzata a mano |  1.61 ms |  15.29× |              1.61 ms |                 15.27× |
| Autovettorizzata    |  1.24 ms |  19.93× |              1.62 ms |                 15.23× |
| Vekt-vettorizzata   |  1.66 ms |  14.87× |              1.66 ms |                 14.86× |
