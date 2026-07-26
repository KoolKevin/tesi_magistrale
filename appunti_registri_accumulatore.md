## Bit di guardia (Guard Bits)

ogni lane dell'accumulatore dispone di bit aggiuntivi chiamati guard bits. La loro quantità dipende dalla larghezza del dato:
- Per accumulatori a 32 bit (vNaccint_t) e 16 bit double-wide (vNx2accshort_t)
- sono presenti 8 bit di guardia per ogni lane
 Questo rende ogni elemento dell'accumulatore largo 40 bit

Per accumulatori a 8 bit (vNx4accchar_t, anche questo double-wide), sono presenti 4 bit di guardia, per un totale di 12 bit per elemento

Questi bit permettono di eseguire numerose somme consecutive (fino a 256 per gli interi a 32 bit) prima che si verifichi un overflow che corrompa il risultato

## Sovrapposizione (Overlay) sui registri vettoriali

I registri accumulatore non sono file di registri separati, ma sono sovrapposti (overlay) al file dei registri vettoriali standard (vr0...vrK)

Un tipo single-wide accumulator (come vNaccint_t) si sovrappone a un singolo registro vettoriale da 512 bit

Un tipo double-wide accumulator (come vNx2accint_t) si sovrappone a una coppia di registri vettoriali

La distinzione a livello di codice rispetto ai registri vettoriali normali (== usare i tipi vNacc*) serve a istruire il compilatore a utilizzare le istruzioni hardware specifiche (come vvcmac) che attivano l'accesso ai bit di guardia, i quali risiedono in una parte speciale del file dei registri non accessibile con le normali operazioni su vNint_t

## Selezione dei bit in vvcmpy_lo e vvcmpy_hi

Quando moltiplichi due interi a 32 bit, il risultato matematico è a 64 bit. Poiché un elemento dell'accumulatore "single-wide" è di 40 bit, il processore deve selezionare quali bit memorizzare:

- vvcmpy_lo:
    - Questa istruzione è **pensata per l'aritmetica intera standard**.
    - Prende i 32 bit inferiori (LSB) del prodotto a 64 bit e li inserisce nella parte principale della lane. I bit dal 32 al 39 del prodotto vengono inseriti negli 8 bit di guardia

- vvcmpy_hi:
    - Questa istruzione è tipicamente **usata per calcoli fixed-point** (formato Q31).
    - Prende i 32 bit superiori (MSB, ovvero i bit 63..32) del prodotto e li inserisce nella parte principale della lane
    - Gli 8 bit di guardia in questo caso conterranno l'estensione del segno o l'eventuale overflow derivante da operazioni di shift frazionario (preshift)

Se hai bisogno dell'intero risultato a 64 bit, dovresti usare gli intrinseci per double-wide accumulators (come vNx2accint_t), che occupano due registri vettoriali e possono contenere tutti i 64 bit del prodotto più gli eventuali bit di guardia (fino a 72 bit totali)

### Uso dei bit di guardia

In contesti come il Digital Signal Processing (DSP) o l'Inferenza AI su Edge (INT8/Quantized Networks), la pipeline tipica è:

- Moltiplicazione & Accumulo (MAC): Moltiplichi ingressi a 8 bit e li accumuli nell'accumulatore esteso per N iterazioni.
- Post-elaborazione (normalizzazione / scaling): Applichi un fattore di scala, uno shift a destra (bit-shift) o una normalizzazione
- Saturazione FINALE: Solo alla fine, il valore accumulato e scalato viene riconvertito (e eventualmente saturato) nel formato a 8 bit per essere scritto in memoria

es:

- Hai un accumulo che dà come risultato intero preciso 1024 (richiede 11 bit, quindi ha sconfinato nei bit di guardia).
- Se avessi saturato a 8 bit durante il calcolo, avresti ottenuto 255.
- Ora devi applicare la normalizzazione (dividere per 4):
    - Senza bit di guardia (saturato): 255 >> 2 = 63 (errato!)
    - Con bit di guardia: 1024 >> 2 = 256
- NB: grazie ai bit di guardia abbiamo potuto continuare ad accumulare senza doverci interrompere a metà per fare un calcolo parziale del risultato finale

Con dati fixed point, una lane di registro di accumulatore viene tipicamente suddivisa in tre zone:
- Bit di Guardia  |  Parte Intera |  Parte Frazionaria extra
- == (Guard bits) |    (MSBs)     |      (LSBs)

NB: in questo caso i bit di guardia gestiscono la crescita della parte intera durante i cicli di accumulo evitando l'overflow mantenendo la parte frazionaria (precisione). Quando si avrà finito di accumulare, si potrà eliminare la parte frazionaria shiftando portando così dentro i bit di guardia dentro al dato (alta precisione)

