Anche qui (similmente a conv2d e conv1d) l'autovettorizzatore cerca di vettorizzare l'inner loop

**in pratica vettorizza solo se W > VL**

Lo schema è questo:

- broadcast del valore iniziale letto dell'output in un vettore
- lettura di un segmento di input
- max tra vettore-segmento letto e accumulatore tante volte tanto è grande la finestra in larghezza (devo finire la riga corrente)
- finitra la riga scrittura del max corrente
- ripeti per le prossime righe (righe appartenenti alla stessa finestra scrivono nella stessa cella di output) 