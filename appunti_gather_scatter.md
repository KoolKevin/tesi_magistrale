The gather and scatter instructions specify **n independent memory operations**. **The processor attempts to execute these independent memory operations in parallel by using multiple memory banks**. As long as each vector element addresses a different memory bank, the memory operations can proceed smoothly.  When two vector elements address the same memory bank, a bank conflict occurs. After a gather instruction is issued the processor can take multiple cycles to resolve bank conflicts for the data elements. Therefore **gather and scatter instructions can have a variable latency before they are completed, depending on bank conflicts**.

The software should be optimized to avoid stalls due to varying load latency of vector gathers. That can be done by leaving load delay slots after the gather instruction to be filled with instructions that do not depend on the gather.  Software pipelining can be used to create distance between a gather instruction and instructions that depend on it.

The software must preferably schedule gather and scatter instructions in a way that use of the load and store pipeline is spread out over time. Interspersing load and store instructions with other instructions allows more time for the vector load and store unit to handle bank conflicts without stall cycles.  The performance of gather and scatter instructions is implementation-dependent. Simple implementations have less hardware to resolve multiple simultaneous bank accesses and bank conflicts than complex implementations.

Application software must be optimized to avoid bank conflicts whenever possible. Following are some of
the guidelines:

- Avoid column bank conflicts with image padding.
    - When you do a column access to the pixels in an image, you do a vector gather with elements that are in the same column col in a 640x480 image pixel[row, col]. The image memory m has 16 banks of 32-bit words. The address bits M[5:2] are used to select one of the 16 memory banks. To avoid column bank conflicts, the pixels in the same column must be in different memory banks. That can be achieved with image padding: store an image of 640x480 pixels in memory as a slightly wider image of 644x480 with an additional column. The image is stored in row-major order starting at address 0.  Then pixel[0,0] is at address 0 and bank 0. Pixel [1,0] is at address 644, which is in bank 1, pixel [2,0] is at address 1288, which is in bank 2, and so on. Thus bank conflicts are avoided for gather of a vector of elements in the same column.

# banchi

Significato delle opzioni

-Xvec_mem_banks=32: Specifica che la memoria VCCM (Vector Closely Coupled Memory) è suddivisa in 32 banchi fisici indipendenti .
-Xvec_mem_bank_width=16: Indica che ogni banco ha una larghezza di 16 bit (ovvero 2 byte) .

In questa architettura, gli indirizzi di memoria sono intercalati tra i banchi a livello di byte. Poiché ogni banco è largo 2 byte, la mappatura avviene nel seguente modo:

- Banco 0: Indirizzi 0-1
- Banco 1: Indirizzi 2-3
- ...
- Banco 31: Indirizzi 62-63
- Banco 0 (ritorno): Indirizzi 64-65

Il "passo" (stride) necessario per tornare allo stesso banco è quindi di 64 byte (32 banchi×2 byte/banco).

Come massimizzare i conflitti

Le operazioni di gather (vvld.fa) caricano più elementi utilizzando un vettore di indirizzi in un unico ciclo di istruzione. Se tutti gli indirizzi generati dal gather puntano allo stesso banco, l'operazione non può essere completata in parallelo e l'hardware deve inserire cicli di stallo per elaborare le richieste sequenzialmente.

Per ottenere il massimo numero di conflitti con un accesso a passo fisso (strided access):

Imposta uno stride di 64 byte (banchi * byte_per_banco): Utilizzando uno stride che sia un multiplo esatto della distanza di interleaving dei banchi (64 byte), ti assicurerai che ogni singola lane del vettore di input punti esattamente allo stesso banco di memoria.
