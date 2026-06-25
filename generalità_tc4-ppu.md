# Appunti ppu e aurix TC4xx

- supporta virtualizzazione
- cpu multicore (6 nella famiglia TC4 Dx)
- 24 MiB of on-chip non-volatile program memory (NVM)
- abbiamo dei functional blocks
  - compute: cpu, PPU
  - interconnect: busses, bridges, DMAs
  - system functions: peripherals, interrupt, debug
  - ports, pads, pins

## Tricore cpu

- 400/500MHz
- pipeline a 8 stadi
- superscalar di grado 3
- supporta double precision floats

`slide 6 di cpu-docs contiene tanti acronimi utili`

- harwardish architecture (separated instruction and data memory)
- **32 bit load/store architecture**
  - i.e. register-register architecture
  - la memoria si accede solo con istruzioni di load/store
- 32/16 bit instructions

- ogni core ha una data/program scratchpad ram
  - Determinismo temporale (il motivo principale)
    - Le cache hanno latenza non deterministica: un cache miss può causare stalli imprevedibili.
    - Negli AURIX i cicli di accesso alla DSPR/PSPR sono fissi e garantiti (tipicamente 1–2 cicli), il che è fondamentale per: Sistemi hard real-time (controllo motore, ABS, airbag), ...
  - Il programmatore (o il linker script) decide cosa mette nello scratchpad:
    - Stack dei task critici → DSPR
    - Codice ISR hot-path → PSPR
    - Lookup table frequenti → DSPR
  - comuni nei sistemi embedded dove si conosce bene il working set, al contrario dei sistemi general-purpose dove la cache è necessaria perché il working set è imprevedibile.

**register file**

- 32 32-bit registers split into:
  - address registers
    - contain addresses (pointers)
    - there is a dedicated register for the return address and stack pointer
  - data registers
    - contain data
  - possono essere accoppiati per supportare tipi di dato più grandi

## PPU

- vector cores
  - con private memory per core
- DMA della ppu
- cluster shared-mem (CSM) (shared between the vector and scalar unit?)

basata su ARC EV71FS processor from synopsys

**VLIW architecture** that combines scalar and vector instruction in one (ARCv2 ISA con estensione per embedded vision) instruction bundle

`why do you need to combine scalar and vector instructions? seems a bit conflicting`

32bit scalar unit

vector DSP (simd) unit

**Scalar unit**

- MAC hardware
- 32 gp registers  that can be paired for 64 bit data types (support for 64 bit operands)

**Vector DSP unit**

- up to three vector instructions in a bundle
- 32 vector registers 512bit wide (variations exist)
- gather/scatter instructions

### Execution model

- the scalar unit fetches and decodes instructions
- vector instructions are forwarded to the vector DSP unit where they are executed in one out of three execution slots (three vector instructions per bundle) -> superscalare
- vector instructions typically operate on vectors in the **vector rf**
  - some vector instructions return a scalar value that is written to a scalare register in the rf of the scalar unit
- loading and storing of vectors is done with vector instructions that access the **vector memory (VMEM/VCCM)**, a local memory whithing the vector unit
- data transfers between VMEM, CSM and PPU external memories are handled by the **Streaming Transfer Unit (STU)**, basically a **DMA**.
  - the STU can be programmed by the scalar core through CSRs and also from and external master (i.e. core)
- the CSM is a scratchpad
- there is a special function register (SFR) to configure the PPU for control and status information (e.g. run or halt)
