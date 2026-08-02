Autovettorizzatore è in grado di vettorizzare matrici quadrate utilizzando load vettoriali e scatter per scrivere a colonne (dovrei guardarci meglio)

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            t[j*N + i] = a[i*N + j]; 
        }
    }

Speedup di circa x3.5


Tuttavia, se le matrici sono rettangolari, non riesce a fare la stessa cosa (?)

    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            t[j*M + i] = a[i*N + j]; 
        }
    }

