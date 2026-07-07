## Prologo

In questa fase, il codice recupera i parametri necessari e verifica se deve effettivamente eseguire il calcolo.

- ld_s %r0,[%sp,64]: Carica il parametro n (la dimensione del loop) dallo stack nel registro %r0
    - Il suffisso _s indica il formato compatto a 16 bit
- cmp_s %r0,0: Compara il valore di n con lo zero per impostare i flag di stato (Z, N, ecc.)
- jle [%blink]: Se n <= 0, esegue un salto al registro di ritorno %blink, uscendo immediatamente dalla funzione

### Preparazione del Loop

Questa sezione calcola quante iterazioni del blocco vettoriale (da 16 elementi ciascuna) devono essere eseguite.

- add.f %r2,%r0,0xffffffff@u32: Sottrae 1 da n e salva il risultato in %r2.
    - Il suffisso .f aggiorna i flag di stato.
- asr_s %r0,%r0,31 e adc.f %r0,%r0,-1:
    - Queste istruzioni, insieme alla successiva lsr_s, vengono utilizzate dal compilatore per calcolare il numero di iterazioni totali, gestendo l'arrotondamento per difetto verso il multiplo di 16 più vicino
- **ld %r11,\[%sp,36] e ld %r8,\[%sp,4]**:
    - Caricano dallo stack **i puntatori base ai vettori di input/output che non erano già presenti nei registri**
- asl_s %r0,%r0,28, lsr_s %r2,%r2,4, or_s %r0,%r0,%r2:
    - Operazioni di shift e OR logico per finalizzare il calcolo del contatore del loop, che verrà messo in %r3
- add_s %r3,%r0,1: Salva il **numero finale di iterazioni in %r3**
- mov_s %r12,0: Inizializza **l'offset di memoria %r12** a zero
- mov_s %r0,0: Inizializza %r0 a zero


## Corpo del Loop (VLIW Bundles)

Il loop (.LBB0_2) è il cuore del calcolo. Vengono utilizzati dei bundle VLIW (.vvsbundle) per eseguire istruzioni scalari e vettoriali in parallelo.

### Calcolo Indirizzi Sorgente

- add2 %r2,%r1,%r12: Calcola l'indirizzo dell'elemento corrente per **il primo vettore: %r1** + (%r12 << 2).
    - Lo shift di 2 bit moltiplica l'offset per 4 byte (dimensione di un i32)
- add2 %r9,%r8,%r12: Calcola l'indirizzo per il secondo vettore sorgente: %r8 + (%r12 << 2)


### Bundle 1: Caricamento A e Indirizzo C

In questo ciclo, mentre l'unità vettoriale carica i dati, l'ALU scalare prepara l'indirizzo di scrittura

.vvsbundle "v1sc" {
  vvld.w %vr0,%r2       ; Vector Load Word: carica 16 elementi i32 da [%r2] in %vr0
  add2 %r6,%r11,%r12    ; Calcola l'indirizzo del vettore di destinazione C -> %r11 + (%r12 << 2)
}

### Bundle 2: Caricamento B e Aggiornamento Offset

Qui si carica il secondo operando e si aggiorna l'indice per il prossimo ciclo

.vvsbundle "v1sc" {
  vvld.w %vr1,%r9       ; Vector Load Word: carica 16 elementi i32 da [%r9] in %vr1
  add.f %r12,%r12,16    ; Incrementa l'offset di 16 (prossimo blocco vettoriale)
}

### Bundle 3: Somma e Gestione Carry

L'istruzione vvadd.w esegue il calcolo SIMD effettivo su 512 bit

.vvsbundle "v1sc" {
  vvadd.w %vr0, %vr1, %vr0  ; Vector Add Word: vr0 = vr0 + vr1 (16 somme i32 parallele)
  adc.f %r0,%r0,0           ; Add with Carry scalare (logica di supporto)
}

### Scrittura e Controllo

vvst.w %vr0,%r6: Vector Store Word: scrive i 16 risultati contenuti in %vr0 all'indirizzo calcolato in %r6

dbnz %r3,.LBB0_2: Decrement and Branch if Non-Zero. Decrementa il contatore delle iterazioni %r3 e torna all'inizio del loop se non è zero


##  Epilogo
j_s [%blink]: Salto in formato corto al registro %blink per tornare alla funzione chiamante

---

# Considerazioni

nel loop abbiamo come minimo le seguenti istruzioni che causano overhead rispetto all'assembly prodotto dal compilatore metaware

- due add2 instruction per l'incremento degli indici
- un'istruzione di decrement&branch (dbnz)

inoltre, mi sembra che l'overhead nascosto utilizzando bundle vliw non sia veramente nascosto durante l'esecuzione da simulatore

NB: il compilatore metaware risparmia

- le istruzioni di incremento dei puntatori (add2)
- l'aggiornamento dell'indice (add.f 16)
- e l'istruzione di branch

utilizzando hardware loop e legalizzando gli intrinseci in una versione che usa post-increment

NB: anche la versione scalare usa hardware loop e load/store con post-increment

**NMB**: compilando con O1 e utilizzando un indice a 32 bit le performance della versione vettorizzata a mano e della versione vettorizzata del mio tool sono analoghe.

- è però un 25x, il che non ha molto senso se si pensa che il numero di lane è 16. Il motivo è dovuto ad un codice non eccezzionale nella funzione scalare (tante load e controllo inutile)

- con O1 hw-loop e istruzioni di post-incremento non vengono utilizzate

- con O2 e indice a 32 bit, il mio tool produce codice che utilizza hw loop ma non le istruzioni di post-incremento (??)
    - è possibile che alcune ottimizzazioni non vengano applicate se passo come input un file .ll e non un file c? Ho copiato e incollato l'output llvm-ir della versione vettorizzata a mano sostituendo il corpo della funzione prodotta dal mio tool. Anche con la stessa IR le istruzioni con post-incremento non sono state prodotte
        - potrei non aver copiato degli attributi e quindi l'ir forse non era proprio uguale identica