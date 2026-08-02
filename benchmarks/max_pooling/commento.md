anche qui l'autovettorizzatore cerca di vettorizzare l'inner loop

**in pratica vettorizza solo se W > VL**

Lo schema è questo:

- broadcast del valore iniziale letto dell'output in un vettore
- lettura di un vettore di input
- max tra vettore e accumulatore tante volte tanto è grande la finestra (in larghezza)
- finitra la riga scrittura del max corrente
- ripeti per le prossime righe (righe appartenenti alla stessa finestra scrivono nella stessa cella di output) 