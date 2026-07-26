# Vector sum

Compilato con -O2:

- Versione sequenziale
    - Tempo di esecuzione di vec_sum: 32.83ms
- Versione vettorizzato a mano
    - Tempo di esecuzione di vectorized_vec_sum: 2.12ms
    - Speedup: 15.47
- Versione autovettorizzata
    - Tempo di esecuzione di autovectorized_vec_sum: 1.61ms
    - Speedup: 20.40
- Versione vekt-vettorizzata
    - Tempo di esecuzione di autovectorized_vec_sum: 2.18ms
    - Speedup: 15.08

-> NB: loop unrolling permette di fare software pipelining

Versione senza loop unrolling (-fno-loop-unrolling):

- Versione sequenziale
    -  Tempo di esecuzione di vec_sum: 32.83ms
- Versione vettorizata a mano
    - Tempo di esecuzione di vectorized_vec_sum: 2.12ms
    - Speedup: 15.47
- Versione autovettorizzata
    - Tempo di esecuzione di autovectorized_vec_sum: 2.12ms
    - Speedup: 15.48
- Versione vekt-vettorizzata
    - Tempo di esecuzione di autovectorized_vec_sum: 2.18ms
    - Speedup: 15.07