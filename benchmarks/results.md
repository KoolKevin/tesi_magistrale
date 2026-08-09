# Vector sum

**Compilato con -O3; N = 8192**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         | 32.83 ms |   1.00× |             32.83 ms |                  1.00× |
| Vettorizzata a mano |  2.12 ms |  15.47× |              2.12 ms |                 15.47× |
| Autovettorizzata    |  1.61 ms |  20.40× |              2.12 ms |                 15.48× |
| Vekt-vettorizzata   |  2.18 ms |  15.08× |              2.18 ms |                 15.07× |

-> **NB: loop unrolling permette di fare software pipelining**


# Dotp

**Compilato con -O3; N = 8192**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         | 24.66 ms |   1.00× |             24.64 ms |                  1.00× |
| Vettorizzata a mano |  1.61 ms |  15.29× |              1.61 ms |                 15.27× |
| Autovettorizzata    |  1.24 ms |  19.93× |              1.62 ms |                 15.23× |
| Vekt-vettorizzata   |  1.66 ms |  14.87× |              1.66 ms |                 14.86× |

-> **NB: loop unrolling permette di fare software pipelining**

# Mat reduce rows 

**Compilato con -O3; M = 8, N = 1024**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         | 12.45 ms |   1.00× |             16.50 ms |                  1.00× |
| Vettorizzata a mano |  1.21 ms |  10.32× |              1.21 ms |                 13.68× |
| Autovettorizzata    |  0.92 ms |  13.59× |              1.27 ms |                 13.01× |
| Vekt-vettorizzata   |  1.27 ms |   9.80× |              1.27 ms |                 12.99× |

-> **NB: loop unrolling permette di fare software pipelining**

# Mat reduce cols

**Compilato con -O3; M = 1024, N = 16** 

| Versione            |    Tempo | Speedup |
|---------------------|---------:|--------:|
| Sequenziale         |  33.01ms |   1.00× |
| Vettorizzata a mano |   2.13ms |  15.48× |
| Autovettorizzata    |  32.98ms |   1.00× |
| Vekt-vettorizzata   |   2.18ms |  15.14× |

# Matmul

**Compilato con -O3; matrici 48x48**

| Versione            |    Tempo | Speedup |
|---------------------|---------:|--------:|
| Sequenziale         | 465.77ms |   1.00× |
| Vettorizzata a mano |  22.41ms |  20.78× |
| Autovettorizzata    | 357.49ms |   1.30× |
| Vekt-vettorizzata   |  22.48ms |  20.72× |

**NB**: autovettorizzatore vettorizza solo se N==1, altrimenti esegue in maniera scalare

**NB**: la versione autovettorizzata è leggermente più veloce rispetto alla versione sequenziale a causa del qualificatore restrict
    - in particolare grazie a quel restrict riesce a spostare la store di C dentro al loop K fuori da quest'ultimo
    - senza restrict la versione autovettorizzata ha uno speedup di 0.96x
    - più lenta dato che deve fare i runtime check che governano i percorsi vettorizzati
- con -O1 la store non viene spostata e la versione autovettorizzata ha uno speedup di 0.99
- se aggiungo restrict alla versione sequenziale, le performance paradossalmente peggiorano. Viene applicato dell'unrolling che complica l'ir e conseguenze varie ...
- di conseguenza lascio la versione sequenziale senza restrict

**Versione con poco lavoro parallelo (M, N, K) = (1, 1, 16)**

| Versione            |    Tempo | Speedup |
|---------------------|---------:|--------:|
| Sequenziale         |   0.30ms |   1.00× |
| Vettorizzata a mano |   0.11ms |   2.82× |
| Autovettorizzata    |   0.31ms |   0.98× |
| Vekt-vettorizzata   |   0.18ms |   1.73× |

**Versione con molte remainder iterations (M, N, K) = (40, 40, 40)**

- 40^3 = 64k MAC da fare
- 40*32*40 = 51200 sono vettorizzate -> 3200 MAC
- 40*8*40 = 12800 rimangono sequenziali
- tot = 12800 + 3200 = 16k MAC -> **speedup max vettorizzazione = 4x**

| Versione            |    Tempo | Speedup |
|---------------------|---------:|--------:|
| Sequenziale         | 272.31ms |   1.00× |
| Vettorizzata a mano |  52.90ms |   5.15× |
| Autovettorizzata    | 209.31ms |   1.30× |
| Vekt-vettorizzata   |  52.93ms |   5.14× |


# Conv1d

**Compilato con -O3; K = 3; N_in = 2050**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         |  43.07ms |   1.00× |             43.07 ms |                  1.00× |
| Vettorizzata a mano |   1.88ms |  22.97× |              2.00 ms |                 21.53× |
| Autovettorizzata    |  38.98ms |   1.10× |             38.98 ms |                  1.10× |
| Vekt-vettorizzata   |   1.93ms |  22.34× |              1.93 ms |                 22.34× |

NB: anche qui la versione autovectorized è leggermente più veloce a causa dello spostamento della store di output abilitata da restrict

Unrolling qua ha un effetto minimo, immagino che ci fosse già abbastanza ILP

NB: autovettorizzatore vettorizza il loop interno (dotproduct vettorizzata per ogni elemento di output). Scalare se il kernel è piccolo (< 8) 

- guarda righe 635 e 645 in conv1d.ll

**Compilato con -O3; K = 16; N_in = 2064**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         | 149.57ms |   1.00× |            149.57 ms |                  1.00× |
| Vettorizzata a mano |   5.20ms |  28.75× |              5.20 ms |                 28.75× |
| Autovettorizzata    |  55.38ms |   2.70× |             41.04 ms |                  3.64× |
| Vekt-vettorizzata   |   5.26ms |  28.46× |              5.26 ms |                 28.46× |

# Conv2d

**Compilato con -O3; K=3x3, In = 50x50**

| Versione            |    Tempo | Speedup |
|---------------------|---------:|--------:|
| Sequenziale         | 138.60ms |   1.00× |
| Vettorizzata a mano |   6.29ms |  22.05× |
| Autovettorizzata    | 120.19ms |   1.15× |
| Vekt-vettorizzata   |   7.21ms |  19.22× |

**NB**: la versione vekt è leggermente più lenta a causa dei memref espansi

**NB**: disabilitare l'unrolling non ha alcun effetto dato che non viene applicato (immagino che sia per la già elevata register pressure)

# Trasposta

**Compilato con -O3; matrici 112x112**

| Versione            |    Tempo | Speedup |
|---------------------|---------:|--------:|
| Sequenziale         |  38.26ms |   1.00× |
| Vettorizzata a mano |   2.43ms |  15.77× |
| Autovettorizzata    |  38.26ms |   1.00× |
| Vekt-vettorizzata   |   2.48ms |  15.40× |

# Max-pooling 2d 

**Compilato con -O3; M = 128, N = 128, finestra = 2x2**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         | 168.67ms |   1.00× |            119.37 ms |                  1.00× |
| Vettorizzata a mano |   8.16ms |  20.68× |              8.16 ms |                 14.63× |
| Autovettorizzata    | 119.49ms |   1.41× |            119.38 ms |                  1.00× |
| Vekt-vettorizzata   |   8.20ms |  20.57× |              8.20 ms |                 14.56× |