# Vector sum

**Compilato con -O3**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         | 32.83 ms |   1.00× |             32.83 ms |                  1.00× |
| Vettorizzata a mano |  2.12 ms |  15.47× |              2.12 ms |                 15.47× |
| Autovettorizzata    |  1.61 ms |  20.40× |              2.12 ms |                 15.48× |
| Vekt-vettorizzata   |  2.18 ms |  15.08× |              2.18 ms |                 15.07× |

-> **NB: loop unrolling permette di fare software pipelining**


# Dotp

**Compilato con -O3**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         | 24.66 ms |   1.00× |             24.64 ms |                  1.00× |
| Vettorizzata a mano |  1.61 ms |  15.29× |              1.61 ms |                 15.27× |
| Autovettorizzata    |  1.24 ms |  19.93× |              1.62 ms |                 15.23× |
| Vekt-vettorizzata   |  1.66 ms |  14.87× |              1.66 ms |                 14.86× |

# Matmul

**Compilato con -O3**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         | 154.91ms |   1.00× |            154.91 ms |                  1.00× |
| Vettorizzata a mano |  11.32ms |  13.69× |             11.29 ms |                 13.72× |
| Autovettorizzata    | 120.07ms |   1.29× |            120.08 ms |                  1.29× |
| Vekt-vettorizzata   |  11.36ms |  13.63× |             11.43 ms |                 13.55× |

NB: questi risultati sono stati ottenuti con matrici quadrate 33x33. Con dimensioni multiple di VL, ottengo speedup di circa 20 per le versioni "vettorizzata a mano" e "vekt-vettorizata", con e senza unrolling (non c'è più un remainder loop sequenziale)

NB: autovettorizzatore vettorizza solo se N==1, altrimenti esegue in maniera scalare

# Conv1d

**Compilato con -O3**

| Versione            |    Tempo | Speedup | Tempo (no unrolling) | Speedup (no unrolling) |
|---------------------|---------:|--------:|---------------------:|-----------------------:|
| Sequenziale         |  43.07ms |   1.00× |             43.07 ms |                  1.00× |
| Vettorizzata a mano |   1.88ms |  22.97× |              2.00 ms |                 21.53× |
| Autovettorizzata    |  38.98ms |   1.10× |             38.98 ms |                  1.10× |
| Vekt-vettorizzata   |   1.93ms |  22.34× |              1.93 ms |                 22.34× |

NB: autovettorizzatore vettorizza il loop interno (dotproduct vettorizzata per ogni elemento di output). Scalare se il kernel è piccolo (< 8) 

# Conv2d

**Compilato con -O3**

| Versione            |    Tempo | Speedup |
|---------------------|---------:|--------:|
| Sequenziale         | 138.60ms |   1.00× |
| Vettorizzata a mano |   6.29ms |  22.05× |
| Autovettorizzata    | 120.19ms |   1.15× |
| Vekt-vettorizzata   |   7.21ms |  19.22× |

**NB**: sembra che nella versione vekt-vettorizzata avvenga dello stack spilling che causano un calo di performance. Dovrei esplorare meglio dove (nel loop interno con la mac non c'è) e come mai avviene (mi sembra strano che sia dovuto al numero elevato di parametri dato che la maggior parte non viene usata e quindi non dovrebbe consumare un registro)

**NB**: disabilitare l'unrolling non ha alcun effetto dato che non viene applicato (immagino che sia per la già elevata register pressure)