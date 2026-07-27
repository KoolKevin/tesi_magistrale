# Vector sum

**Compilato con -O2**

| Versione | Tempo di esecuzione | Speedup |
|---|---:|---:|
| Sequenziale | 32.83 ms | 1.00× |
| Vettorizzata a mano | 2.12 ms | 15.47× |
| Autovettorizzata | 1.61 ms | 20.40× |
| Vekt-vettorizzata | 2.18 ms | 15.08× |

-> NB: loop unrolling permette di fare software pipelining

**Versione senza loop unrolling (-fno-unroll-loops)**

| Versione | Tempo di esecuzione | Speedup |
|---|---:|---:|
| Sequenziale | 32.83 ms | 1.00× |
| Vettorizzata a mano | 2.12 ms | 15.47× |
| Autovettorizzata | 2.12 ms | 15.48× |
| Vekt-vettorizzata | 2.18 ms | 15.07× |

# Dotp

**Compilato con -O2**

| Versione | Tempo di esecuzione | Speedup |
|---|---:|---:|
| Sequenziale | 24.66 ms | 1.00× |
| Vettorizzata a mano | 1.61 ms | 15.29× |
| Autovettorizzata | 1.24 ms | 19.93× |
| Vekt-vettorizzata | 1.66 ms | 14.87× |

**Versione senza loop unrolling (-fno-unroll-loops)**

| Versione | Tempo di esecuzione | Speedup |
|---|---:|---:|
| Sequenziale | 24.64 ms | 1.00× |
| Vettorizzata a mano | 1.61 ms | 15.27× |
| Autovettorizzata | 1.62 ms | 15.23× |
| Vekt-vettorizzata | 1.66 ms | 14.86× |