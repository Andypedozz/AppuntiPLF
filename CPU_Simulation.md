Certo. Ti propongo una CPU **semplice ma completa**, abbastanza piccola da essere implementata in Node.js in pochi giorni, ma con caratteristiche reali (registri, RAM, stack, istruzioni, flag, fetch/decode/execute).

## Specifica: CPU "N8" (8 bit)

### Obiettivo

Simulare un processore 8-bit con:

* bus dati: **8 bit**
* bus indirizzi: **16 bit**
* memoria: **64 KB**
* 8 registri
* set di istruzioni compatto
* esecuzione step-by-step (`clock()`)

---

# 1. Architettura

## Registri

| Registro | Dimensione | Scopo             |
| -------- | ---------- | ----------------- |
| A        | 8 bit      | Accumulatore      |
| B        | 8 bit      | Registro generale |
| C        | 8 bit      | Registro generale |
| D        | 8 bit      | Registro generale |
| X        | 16 bit     | Registro indice   |
| SP       | 16 bit     | Stack Pointer     |
| PC       | 16 bit     | Program Counter   |
| FLAGS    | 8 bit      | Flag CPU          |

---

## FLAGS

```
bit 0: Z (Zero)
bit 1: C (Carry)
bit 2: N (Negative)
bit 3: V (Overflow)
bit 4-7: inutilizzati
```

Esempio:

```
A = 0

FLAGS:
00000001
       ^
       Z
```

---

# 2. Memoria

RAM:

```
indirizzi:
0x0000 - 0xFFFF

dimensione:
65536 byte
```

Implementazione:

```js
const RAM = new Uint8Array(65536);
```

---

# 3. Ciclo CPU

Ogni clock:

```
FETCH
 |
 v
Leggi istruzione da PC
 |
 v
Incrementa PC
 |
 v
DECODE
 |
 v
EXECUTE
```

Esempio:

Memoria:

```
0000: 10
0001: 42
```

CPU:

```
PC = 0000

FETCH:
opcode = RAM[PC]
PC++

opcode = 10

DECODE:
LDA immediate

FETCH ARG:
42

EXECUTE:
A = 42
```

---

# 4. Instruction Set

Ogni istruzione è lunga 1-3 byte.

Formato:

```
[opcode] [argomento]
```

---

## Movimento dati

### NOP

```
00
```

Non fa nulla.

### LDA immediate

```
10 xx
```

Carica un valore in A.

Esempio:

```
10 55
```

Risultato:

```
A = 0x55
```

---

### LDB immediate

```
11 xx
```

---

### STA

```
20 lo hi
```

Salva A in memoria.

Esempio:

```
20 00 80
```

scrive:

```
RAM[0x8000] = A
```

---

### LDA memoria

```
21 lo hi
```

Carica:

```
A = RAM[address]
```

---

# 5. Aritmetica

## ADD

```
30 xx
```

```
A = A + xx
```

Aggiorna:

* Z
* C
* N

Esempio:

```
A=10

30 05

A=15
```

---

## SUB

```
31 xx
```

```
A = A - xx
```

---

## INC

```
32
```

```
A++
```

---

# 6. Salti

## JMP

```
40 lo hi
```

```
PC = address
```

---

## JZ

```
41 lo hi
```

Salta se:

```
FLAGS.Z = 1
```

---

## JNZ

```
42 lo hi
```

Salta se:

```
Z = 0
```

---

# 7. Stack

Stack cresce verso il basso.

SP iniziale:

```
SP = 0xFFFF
```

## PUSH A

```
50
```

equivalente:

```
RAM[SP] = A
SP--
```

---

## POP A

```
51
```

```
SP++
A = RAM[SP]
```

---

# 8. Input/Output

Riserviamo:

```
0xFF00 = output carattere
0xFF01 = input tastiera
```

Scrivere:

```
STA FF00
```

stampa un carattere.

Esempio:

```
LDA 41
STA FF00
```

stampa:

```
A
```

---

# 9. Programma di esempio

Stampare "HI":

Assembly:

```
LDA #72
STA $FF00

LDA #73
STA $FF00

HLT
```

Bytecode:

```
10 48
20 00 FF

10 49
20 00 FF

FF
```

---

# 10. Opcode finale

| Opcode | Istruzione |
| ------ | ---------- |
| 00     | NOP        |
| 10     | LDA #      |
| 11     | LDB #      |
| 20     | STA        |
| 21     | LDA addr   |
| 30     | ADD #      |
| 31     | SUB #      |
| 32     | INC        |
| 40     | JMP        |
| 41     | JZ         |
| 42     | JNZ        |
| 50     | PUSH A     |
| 51     | POP A      |
| FF     | HALT       |

---

# 11. Struttura Node.js consigliata

```
cpu-sim/
│
├── cpu.js       // core CPU
├── memory.js    // RAM
├── assembler.js // opzionale
├── programs/
│    └── hello.asm
└── index.js
```

---

# 12. Interfaccia minima della CPU

```js
const cpu = new CPU();

cpu.load(program, 0x0000);

while(!cpu.halted){
    cpu.clock();
}

cpu.dump();
```

Output:

```
A: 49
PC: 0007
FLAGS: 00000000
```

---

Questa specifica è volutamente simile a una versione semplificata di CPU storiche come il MOS Technology 6502 o lo Intel 8080, ma abbastanza piccola da poter essere scritta interamente in JavaScript.

Una buona evoluzione dopo questa versione sarebbe aggiungere:

1. un **assembler vero** (`LDA #10` → bytecode),
2. un **debugger con breakpoint**,
3. una **pipeline a stadi**,
4. una **GPU virtuale collegata alla RAM**.
