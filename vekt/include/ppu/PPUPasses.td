#ifndef PPU_PASS
#define PPU_PASS

include "mlir/Pass/PassBase.td"

def PPUAddDLTIInfo : Pass<"ppu-add-dlti-info", "::mlir::ModuleOp"> {
  let summary = "aggiunge le informazioni di data-layout per la ppu al modulo mlir";
  let description = [{
    Vogliamo index e puntatori a 32 bit.
  }];

  // Questo dichiara che questo passo genererà/userà questi dialetti. In questa
  // maniera il costruttore generato del passo si assicurerà di caricare questi
  // dialetti prima che il passo esegua.
  let dependentDialects = [
    "mlir::DLTIDialect"
  ];
}


def PPUInsertVecLoad : Pass<"ppu-insert-vec-load", "::mlir::ModuleOp"> {
  let summary = "Insert a fake ppu.vec_load op for debugging";
  let description = [{
    This pass inserts a dummy a ppu.vec_load op and a memref as its argument
    into the module to validate the op definition.
  }];

  // Questo dichiara che questo passo genererà/userà questi dialetti. In questa
  // maniera il costruttore generato del passo si assicurerà di caricare questi
  // dialetti prima che il passo esegua.
  let dependentDialects = [
    "mlir::memref::MemRefDialect",
    "mlir::func::FuncDialect"
  ];
}

def PPURaiseAffineToLinalgGeneric: Pass<"ppu-raise-affine-to-linalg-generic", "::mlir::ModuleOp"> {
  let summary = "Effettua il raising di un loop nest affine perfetto nella "
                "versione equivalente espressa da linalg.generic. Inoltre, "
                "aggiunge alle memref con size dinamica generate da Polygeist, "
                "i valori per i loro campo 'sizes'";
  let description = [{
    Il passo esegue le seguenti macro-operazioni logiche:

    - cerca e recupera, se viene trovato, il loop nest perfetto da tradurre
      in una linalg.generic op
    - analizza il body del nest trovato e:
        - usa i subscript delle load e store (solo una) al suo interno per
          calcolare le indexing_maps
        - usa le dimensioni utilizzate dal subscript della store per capire
          quali loop sono parallel e quali loop sono di reduction
          (iterator_types)
          - verifica la presenza di un pattern RMW (store preceduta da una load
            allo stesso indirizzo)
          - verifica la validità del loop-nest (una sola store, solo op
            ammissibili, solo subscript ammissibili, ...)
    - costruzione della linalg.generic op utilizzando le informazioni ottenute
      dagli step precedenti
      - sostituzione delle load esplicite con i blockArgs di ins() e outs()
      - sostituzione della store esplicita con una yield
      - definizione del loop nest implicita tramite indexing_maps e
        iterator_types

    In seguito, un esempio di applicazione del passo:

    ```Matmul prima
    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to %1 {
        affine.for %arg8 = 0 to %2 {
          %3 = affine.load %arg3[%arg6, %arg8] : memref<?x?xi32>
          %4 = affine.load %arg4[%arg8, %arg7] : memref<?x?xi32>
          %5 = arith.muli %3, %4 : i32
          %6 = affine.load %arg5[%arg6, %arg7] : memref<?x?xi32>
          %7 = arith.addi %6, %5 : i32
          affine.store %7, %arg5[%arg6, %arg7] : memref<?x?xi32>
        }
      }
    }
    ```

    ```Matmul dopo
    #map = affine_map<(d0, d1, d2) -> (d0, d2)>
    #map1 = affine_map<(d0, d1, d2) -> (d2, d1)>
    #map2 = affine_map<(d0, d1, d2) -> (d0, d1)>

    ...

    linalg.generic {indexing_maps = [#map, #map1, #map2], iterator_types = ["parallel", "parallel", "reduction"]} ins(%arg3, %arg4 : memref<?x?xi32>, memref<?x?xi32>) outs(%arg5 : memref<?x?xi32>) {
    ^bb0(%in: i32, %in_0: i32, %out: i32):
      %3 = arith.muli %in, %in_0 : i32
      %4 = arith.addi %out, %3 : i32
      linalg.yield %4 : i32
    }
    ```
  }];

  let dependentDialects = [
    "mlir::linalg::LinalgDialect"
  ];
}

def PPUNormalizeIterargsReductions: Pass<"ppu-normalize-iterargs-reductions", "::mlir::ModuleOp"> {
  let summary = "riscrive nest di riduzione affine.for in forma funzionale (iter_args + risultato), in una forma che effettua load e store esplicite dell'accumulatore";
  let description = [{
    Il passo esegue le seguenti macro-operazioni logiche:

    - riconosce e recupera una struttura di riduzione con iter_args (pass-through
    chain)
    - analizza come viene usato il risultato della riduzione per vedere se
    matchare o meno. Sono supportati due casi:
      - il risultato viene storato subito fuori dall'outer-most loop (riduzione
      parziale tipo matmul)
      - il risultato viene ritornato dalla funzione (riduzione totale tipo dotp)
    - dopo le precedenti analisi viene effettuata la normalizzazione dei loop di
    riduzione vera e propria. Che consiste nel sostituire il for con iter_arg in
    un for normale senza risultato, per livello della catena di riduzione:
      - nel loop innermost bisogna inserire una load esplicita dell'accumulatore
        all'inizio del corpo e una store esplicita dell'accumulatore incrementato
        alla fine.
      - per il loop outermost
        - se il risultato veniva restituito, materializza una load per ottenere
          il valore della riduzione sostituendo il result del loop
        - se il risultato veniva memorizzato, elimina lo store originale fuori da
        outer perché ormai già avvenuto dentro ai nuovi loop di riduzione.

    Inoltre:

    - in caso di riduzione parziale, l'inizializzazione dell'accumulatore
      viene fatta materializzando un nest di inizializzazione esplicito con
      un numero di loop pari alle dimensioni parallele che racchiudono il
      nest di riduzione
    - in caso di riduzione totale viene anche materializzata una alloca
      fuori dal nest per l'accumulatore

    In seguito, un paio di esempi per le situazioni gestite:

    ```Matmul prima
    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to %1 {
        %3 = affine.for %arg8 = 0 to %2 iter_args(%arg9 = %c0_i32) -> (i32) {
          %4 = affine.load %arg3[%arg6, %arg8] : memref<?x?xi32>
          %5 = affine.load %arg4[%arg8, %arg7] : memref<?x?xi32>
          %6 = arith.muli %4, %5 : i32
          %7 = arith.addi %arg9, %6 : i32
          affine.yield %7 : i32
        }
        affine.store %3, %arg5[%arg6, %arg7] : memref<?x?xi32>
      }
    }
    ```

    ```Matmul dopo
    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to %1 {
      affine.store %c0_i32, %arg5[%arg6, %arg7] : memref<?x?xi32>
      }
    }

    affine.for %arg6 = 0 to %0 {
      affine.for %arg7 = 0 to %1 {
        affine.for %arg8 = 0 to %2 {
          %3 = affine.load %arg5[%arg6, %arg7] : memref<?x?xi32>
          %4 = affine.load %arg3[%arg6, %arg8] : memref<?x?xi32>
          %5 = affine.load %arg4[%arg8, %arg7] : memref<?x?xi32>
          %6 = arith.muli %4, %5 : i32
          %7 = arith.addi %3, %6 : i32
          affine.store %7, %arg5[%arg6, %arg7] : memref<?x?xi32>
        }
      }
    }
    ```

    ```Dotprod prima
    %1 = affine.for %arg3 = 0 to %0 iter_args(%arg4 = %c0_i32) -> (i32) {
      %2 = affine.load %arg0[%arg3] : memref<?xi32>
      %3 = affine.load %arg1[%arg3] : memref<?xi32>
      %4 = arith.muli %2, %3 : i32
      %5 = arith.addi %arg4, %4 : i32
      affine.yield %5 : i32
    }
    return %1 : i32
    ```

    ```Dotprod dopo
    %alloca = memref.alloca() : memref<i32>
    affine.store %c0_i32, %alloca[] : memref<i32>
    affine.for %arg3 = 0 to %0 {
      %2 = affine.load %alloca[] : memref<i32>
      %3 = affine.load %arg0[%arg3] : memref<?xi32>
      %4 = affine.load %arg1[%arg3] : memref<?xi32>
      %5 = arith.muli %3, %4 : i32
      %6 = arith.addi %2, %5 : i32
      affine.store %6, %alloca[] : memref<i32>
    }
    %1 = affine.load %alloca[] : memref<i32>
    return %1 : i32
    ```
  }];

  let dependentDialects = [
    "mlir::affine::AffineDialect",
    "mlir::linalg::LinalgDialect"
  ];
}

def ConvertLinalgToPPUAlgorithm: Pass<"convert-linalg-to-ppu-algorithm", "::mlir::ModuleOp"> {
  let summary = "Effettua il lowering di alcune linalg ops ad algoritmi vettorizzati destinati alla PPU";
  let description = [{
    Il lowering consiste nel sostituire la linalg op con:

    - Affine ops per il control flow
    - PPU ops per la computzione e il caricamento dei registri vettoriali

    In caso di memref con dimensione dimanica si effettua anche uno splitting del
    loop in un main loop vettorizzato e un remainder loop scalare.

    Il lowering introduce anche una sequenza di operazioni per estrarre l'aligned
    pointer delle memref usate nel resto dell'ir; ad esempio:

    %intptr = memref.extract_aligned_pointer_as_index %arg0 : memref<?xi32> -> index
    %1 = arith.index_cast %intptr : index to i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr<4>
    %3 = arith.index_cast %arg4 : index to i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr<4>, i64) -> !llvm.ptr<4>, i32
    "ppu.vec_store"(%val, %4) : (vector<16xi32>, !llvm.ptr<4>) -> ()
  }];

  let dependentDialects = [
    "mlir::memref::MemRefDialect",
    "mlir::affine::AffineDialect",
    "mlir::ppu::PPUDialect",
    "mlir::LLVM::LLVMDialect",
    "mlir::arith::ArithDialect",
  ];
}

def PPULowerToLLVM : Pass<"ppu-lower-to-llvm", "::mlir::ModuleOp"> {
  let summary = "Effettua il lowering da un mix di dialetti a llvm + ppu in maniera da esportare verso llvm-ir";
  let description = [{
    ...
  }];

  let dependentDialects = [
    "mlir::memref::MemRefDialect",
    "mlir::arith::ArithDialect",
    "mlir::vector::VectorDialect",
    "mlir::func::FuncDialect",
    "mlir::affine::AffineDialect",
    "mlir::vector::VectorDialect",
    "mlir::LLVM::LLVMDialect",
    "mlir::ub::UBDialect",
    "mlir::ppu::PPUDialect",
    "mlir::scf::SCFDialect"
  ];
}


#endif // PPU_PASS
