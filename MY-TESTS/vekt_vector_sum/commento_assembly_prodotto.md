l'add è stata vettorizzata, ma le masked load/store no
- il backend ha legalizzato l'intrinseco utilizzando scalar loads/stores
- la PPU non supporta questo tipo di istruzioni masked, sebbene abbia predicated instructions per altri casi

## Calcolo della Maschera (Predicazione)

Prima di caricare i dati, il codice calcola la maschera di bit che determina quali elementi del vettore processare. In LLVM-IR corrisponde alla comparazione icmp sgt.
.LBB0_2:                          ; Inizio del loop principale
    sub     %r14, %r4, %r3        ; Calcola n - i
    vvmov.w  %vr1, %r14           ; Sposta il valore scalare nel registro vettoriale
    vvpcmp.gt.w %p1, %vr1, %vr0    ; Compara vettorialmente > 0, salva in p1 (predicato)
    vvpmovps %r14, %p1, 0         ; Fondamentale: sposta i bit della maschera da p1 a r14 (scalare)
    st      %r14, [%sp, 42]       ; Passaggio temporaneo su stack della maschera
    ldh     %r15, [%sp, 42]       ; Carica la maschera in r15 per i test bit-a-bit

## Masked Loads (Scalarizzati)

Questa è la parte più corposa e ripetitiva. Poiché l'ISA non ha un vvld.masked, il compilatore esegue 16 test condizionali. Per ogni lane (0-15):

- Controlla il bit corrispondente nella maschera (r15).
- Se il bit è 1, esegue una ld_s (load scalare).
- Inserisce il valore nel registro vettoriale %vr1 (per il vettore A) o %vr2 (per il vettore B).

Esempio per le prime due lane:
    and     %r0, %r15, 1          ; Test bit 0 (Lane 0)
    breq_s  %r0, 0, .LBB0_4       ; Se il bit è 0, salta il caricamento
    ld_s    %r0, [%r14, 0]        ; Load scalare dell'elemento 0
    vvmov.w  %vr1, %r0            ; Inserisce nella Lane 0

.LBB0_4:
    and     %r0, %r15, 2          ; **Test bit 1 (==immediato 2) (Lane 1)**
    breq_s  %r0, 0, .LBB0_6       ; Se 0, salta
    ld_s    %r0, [%r14, 4]        ; Load scalare elemento 1 (offset 4 byte)
    vvmov1.vi.to.w %vr1, 1, %r0   ; **Inserisce specificamente nella Lane 1**




Questa sequenza si ripete identica per 16 volte per il vettore A e altre 16 volte per il vettore B

Poi abbiamo una somma vettoriale e la stessa cosa per la store
