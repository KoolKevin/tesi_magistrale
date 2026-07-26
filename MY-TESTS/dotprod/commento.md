interessante notare come grazie al loop unrolling fatto dall'autovettorizzatore, iterazioni diverse vengano sovrapposte (software pipelining)

- guarda riga 438 di dotp.s
- parto con 2 load
- faccio la mac ma anche una load della prossima iterazione in un bundle
- faccio la load che mi rimane
- e poi un altro bundle
- e così via