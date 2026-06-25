# PPU

acceleratore per AI e linear algebra stuff (DSP) integrato nel SoC con i tricore

vector processor basically

- sembra simile a quello presentato da benini
- computazione SIMD

aggiungendo la PPU il sistema diventa eterogeneo

- best energy efficiency per mathematical operation
- extends application range of classical MCU (TriCore without PPU) into AI inference, ..., generally stuff that MCU can't handle because too computationally expensive

Vedremo che la PPU è un full-MCU che introduce 3 livelli di parallelismo

- Task-level parallelism
  - i tricore possono andare concorrentemente rispetto alla PPU
- ILP con l'approccio VLIW
- DLP con simd processing

## Architettura

la PPU è un **cluster** formato da:

- un core, diviso in:
  - un scalar core
  - un vector core che fa simd
  - una vector memory (VMEM/VCCM) da 32KiB-128KiB
    - L1 scratchpad memory
    - questa è la memoria veloce su cui il vector core opera
      - e.g. vogliamo che i pesi di un layer di una rete neurale risiedano in questa memoria

- una STU (i.e. DMA)
- una Cluster Shared Memory (CSM) (64KiB-512KiB)
  - L2 scratchpad memory accessible by both cores
  - permette di fare **double buffering**

---

Il ruolo dello scalar core è **orchestrare il vector core** e gestire il control flow dell'esecuzione vettoriale (?)

- è un core che serve ad eseguire operazioni di controllo
- serve per far si che i tricore possano fare offloading alla PPU senza dover stare a interrompere continuamente la loro esecuzione per la gestione di quest'ultima
  - ruolo simile a quello di un DMA
  - questo rende la PPU un acceleratore di tipo coprocessore dato l'alto grado di autonomia -> simile ad una GPU

NB: lo scalar core è un core gp ma è debole in quanto pensato per il controllo della PPU; non viene usato, ad esempio, per eseguire codice C generico

- viene configurato dai tricore e poi parte rimanendo autonomo (simile a DMA)
- fa IF e ID delle istruzioni
- esegue state-machine/control-loop programs
  - ha quindi anche un suo scalar rf per la sua esecuzione
- può configurare tutte le periferiche mmapped del SoC
- può far partire i trasferimenti di memoria utilizzando la STU

``` Questo è il "tipico" (secondo claude) lavoro dello scalar core PPU
while (true) {
    configura_DMA(input_buffer, output_buffer);   // prepara i dati
    lancia_operazione_vettoriale();               // avvia il vector core
    aspetta_completamento();                      // sincronizza
    notifica_tricore();                           // risultato pronto
}
```

... SEMBRA anche che esegue operazioni scalari come branch e loop iv increments ...

---

Il ruolo del vector core è crunchare numeri

classica macchina SIMD:

- abbiamo wide vector RF (128-512bit)
  - notevolmente, il vector RF ha anche dei registri accumulator dedicati (immagino con un alto numero di bit per evitare overflow)
- e simd instructions per tipi di dato da (4-32bit)

```Aurix TC4D7
ha una PPU Mid con 256b simd width @400MHz
```

---

la PPU usa poi un'architettura **VLIW**

- la PPU processa instruction bundles grandi fino a 128bit da 4 slot
  - 1 slot per istruzione scalare
  - 3 slot per istruzioni vettoriali
- similmente, le functional units dentro ai scalar/vector core sono ripartiti in
  - 1 scalar execution slot
  - 3 vector execution slot (con unità funzionali leggermente diverse e.g. solamente uno ha supporto per special functions come cos/sin)

```esempio di codice da eseguire
for (int i = 0; i < N; i += VL) {
    va = vload(&a[i]);
    vb = vload(&b[i]);
    acc = vmac(acc, va, vb);
}
```

```instruction bundle per una iterazione
Vector slot 0: VLOAD  va,  [ptr_a]          // carica prossimo chunk di a
Vector slot 1: VLOAD  vb,  [ptr_b]          // carica prossimo chunk di b
Vector slot 2: VMAC   acc, va_prev, vb_prev // calcola sul chunk precedente
Scalar slot:   ADD    r1,  r1, #VL          // incrementa i
```

gli execution slot vettoriali non sono tutti uguali, al contrario **ogni slot ha una sua responsabilità**

- e.g. uno slot fa load/store di vettori mentre un altro ha FU per funzioni speciali (cos/sin, non linearità, ...) altri hanno chissà che cosa...
- il punto è che una determinata istruzione occuperà una determinata posizione nel bundle e verrà assegnata di conseguenza all'execution slot con la FU necessaria

**come mai VLIW funziona nella PPU?**

- nel caso general purpose il problema principale erano le cache che causano una latenza imprevedibile di accesso alla memoria in caso di miss
- se la latenza è imprevedibile, il compilatore non può fare stati scheduling -> quante istruzioni ci metto in mezzo??
- nel caso della PPU tutte le latenze sono note
  - la scratchpad viene popolata dal DMA e il suo accesso ha una latenza nota
  - il control flow di codice vettorizzabile è regolare (si sa quando si ha una branch misprediction (se c'è un branch predictor...))
- di conseguenza static scheduling è attuabile

---

the PPU is a dedicated co-processor not an ISA extension

- indipendent and autonomous
- located in the SoC and connect with standard inteconnect buses to the main tricore cpu

## Boot della PPU from tricore

the PPU is a coprocessor, thus

- it has a separate ISA (ARCv2 con V-DSP extension) compiler (MetaWare instead of Tasking (?)), linker script and resulting elf

during the boot sequence the Tricore

- loads the CSM with the PPU code (and i guess it configures a program counter)
- releases the PPU (with a blocking call)
- the PPU notifies the TriCore when the but finishes successfully

## Inter-Processor Communication (IPC)

TLDR: i tricore configurano la PPU mediante lo scalar core e attraverso vari interconnect e bridge (SRI (Infineon bus) e AXI)

- **NB**: da verificare però suona ragionevole

---

roba automotive (AUTOSAR) esegue sui TriCore

algoritmi, o loro parti, che beneficiano di SIMD vengono eseguiti sulla PPU mediante **richiesta esplicita**

Tricore:

- esegue il driver per la comunicazione con la PPU (configurazione dello scalar core menzionata sopra)
- il tricore richiede il servizio della PPU; **la risposta può essere sia sincrona che asincrona**

PPU:

- implements IPC handler state machine when a request arrives
- scalar core
  - performs input data transfer
  - invokes the requested kernel/function
  - performs output data transfer
  - sends the response to the tricore

## programming model

...

abbiamo vgather/vscatter operations to form vectors from non adjacent data and to store to non adjacent memory addresses

...

sembra che si utilizzi anche vector-C, un estensione di C che aggiunge tipi e funzioni built-in che il compilatore conosce e può quindi usare per una autovettorizzazione automatica

- simile all'uso di intrinseci ma meno verboso

## Compiler toolchain
