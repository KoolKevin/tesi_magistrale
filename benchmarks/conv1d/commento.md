Dando un'occhiata veloce all'IR ho trovato questo

```
vector.body:                                      ; preds = %vector.body, %iter.check
  %index = phi i32 [ 0, %iter.check ], [ %index.next, %vector.body ]
  %vec.phi = phi <16 x i32> [ %22, %iter.check ], [ %27, %vector.body ]

  %23 = add nuw nsw i32 %index, %i.021.us

  %24 = getelementptr inbounds i32, ptr addrspace(4) %input, i32 %23
  %wide.load = load <16 x i32>, ptr addrspace(4) %24, align 4, !tbaa !3
  %25 = getelementptr inbounds i32, ptr addrspace(4) %window, i32 %index
  %wide.load25 = load <16 x i32>, ptr addrspace(4) %25, align 4, !tbaa !3

  %26 = mul nsw <16 x i32> %wide.load25, %wide.load
  %27 = add <16 x i32> %26, %vec.phi

  %index.next = add nuw i32 %index, 16
  %28 = icmp eq i32 %index.next, %n.vec
  br i1 %28, label %middle.block, label %vector.body, !llvm.loop !26

middle.block:                                     ; preds = %vector.body
  %29 = tail call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %27)
  br i1 %min.epilog.iters.check.not.not, label %for.body4.us.preheader, label %vec.epilog.ph
```

in sostanza, l'autovettorizzatore ha vettorizzato il loop interno facendo un dotproduct tra un vettore di valori del kernel e vettore di valori dell'input. 

Il compilatore ha poi generato tante versioni di conv1d in base alla dimensione della finestra (< 8 == scalare; 8 <= w < 16 == vettori da 8; w >= 16 == vettori da 16)

Le load, mul e add vettoriali dovrebbero dare uno speedup alto, però questo non sembra funzionare in realtà (per K=9 e N=1024 -> speedup = 1.5x). Non ho ben capito bene il perchè, penso che la colpa sia delle somme orizzontali fatte per ogni elemento dell'output che annullano il beneficio dei calcoli vettorizzati

# version vettorizzata

speedup maggiore di > 16 grazie ad ILP

```
.vvsbundle  "v1sc" 
 ;	 { 
	vvld.ab.w	%vr0,%r12,4             ; @0x260
	ld.ab	%r14,[%r13,4]                   ; @0x260
 ;	 }
	vvcmac.lo.w	%vr17, %vr0, %r14       ; @0x26a
```