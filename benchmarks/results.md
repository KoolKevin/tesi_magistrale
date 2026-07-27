# Vector sum

Compilato con -O2:

- Versione sequenziale
    - Tempo di esecuzione: 32.83ms
- Versione vettorizzato a mano
    - Tempo di esecuzione: 2.12ms
    - Speedup: 15.47
- Versione autovettorizzata
    - Tempo di esecuzione: 1.61ms
    - Speedup: 20.40
- Versione vekt-vettorizzata
    - Tempo di esecuzione: 2.18ms
    - Speedup: 15.08

-> NB: loop unrolling permette di fare software pipelining

Versione senza loop unrolling (-fno-unroll-loops):

- Versione sequenziale
    -  Tempo di esecuzione di vec_sum: 32.83ms
- Versione vettorizata a mano
    - Tempo di esecuzione: 2.12ms
    - Speedup: 15.47
- Versione autovettorizzata
    - Tempo di esecuzione: 2.12ms
    - Speedup: 15.48
- Versione vekt-vettorizzata
    - Tempo di esecuzione: 2.18ms
    - Speedup: 15.07

# Dotp

Compilato con -O2

- Versione sequenziale
    - Tempo di esecuzione: 24.66ms
- Versione vettorizzata a mano
    - Tempo di esecuzione: 1.61ms
    - Speedup: 15.29
- Versione autovettorizzata
    - Tempo di esecuzione: 1.24ms
    - Speedup: 19.93
- Versione vekt-vettorizzata
    - Tempo di esecuzione: 1.66ms
    - Speedup: 14.87

Versione senza loop unrolling (-fno-unroll-loops):

- Versione sequenziale
    - Tempo di esecuzione: 24.64ms
- Versione vettorizzata a mano
    - Tempo di esecuzione: 1.61ms
    - Speedup: 15.27
- Versione autovettorizzata
    - Tempo di esecuzione: 1.62ms
    - Speedup: 15.23
- Versione vekt-vettorizzata
    - Tempo di esecuzione: 1.66ms
    - Speedup: 14.86