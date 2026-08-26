## 1. **Sintassi del λ-Calcolo**

Il λ-calcolo definisce le funzioni in modo **intensionale**, cioè attraverso un processo computazionale, non come insieme di coppie ordinate.

- **Alfabeto**: un insieme numerabile di variabili `Var = {x, y, z, ...}`.
- **Termini (Λ)**: definiti per ricorsione:
  - Ogni variabile è un termine: `x ∈ Λ`.
  - Se `E ∈ Λ` e `x ∈ Var`, allora `λx.E ∈ Λ` (astrazione).
  - Se `E₁, E₂ ∈ Λ`, allora `(E₁ E₂) ∈ Λ` (applicazione).

**Convenzioni di precedenza** per ridurre le parentesi:
- L'applicazione è associativa a sinistra: `E₁ E₂ E₃` ≡ `((E₁ E₂) E₃)`.
- L'astrazione è associativa a destra: `λx.λy.E` ≡ `λx.(λy.E)`.
- L'applicazione ha priorità sull'astrazione: `λx.E₁ E₂` ≡ `λx.(E₁ E₂)`.

**Esempi fondamentali**:
- `λx.x` : funzione identità.
- `λx.λy.x` : proiezione del primo argomento.
- `λx.λy.y` : proiezione del secondo argomento.

---

## 2. **Variabili libere, legate e sostituzione**

### Sottotermini
L'insieme dei sottotermini `st(E)` è definito induttivamente:
- `st(x) = {x}`
- `st(λx.E) = {λx.E} ∪ st(E)`
- `st(E₁ E₂) = {E₁ E₂} ∪ st(E₁) ∪ st(E₂)`

### Variabili occorrenti, libere e legate
- Un'occorrenza di `x` è **legata** se si trova nel corpo di un `λx`; altrimenti è **libera**.
- `var(E)`: insieme di tutte le variabili che compaiono in `E`.
- `varlib(E)`: insieme delle variabili con almeno un'occorrenza libera.
- `varleg(E)`: insieme delle variabili con almeno un'occorrenza legata.

**Nota**: `var(E) = varleg(E) ∪ varlib(E)`, ma i due insiemi possono intersecarsi (es. `(λx.x) x`).

- **Termine chiuso**: `varlib(E) = ∅`.  
- **Termine aperto**: `varlib(E) ≠ ∅`.

### Sostituzione `E[F/x]`
Sostituisce `F` a ogni occorrenza **libera** di `x` in `E`.  
La definizione è complessa perché deve evitare la **cattura di variabili**:
- Se `E = λx.E'` (legatore omonimo), la sostituzione non entra nel corpo.
- Se `E = λy.E'` con `y ≠ x`, e `y` non è libera in `F`, si sostituisce normalmente.
- Se `y` è libera in `F`, si deve prima rinominare `y` in `E'` con una variabile `z` fresca, poi sostituire.

**Esempio**:
`(λx.x y)[x/y]` non diventa `λx.x x` (errato), ma dopo α-rinominazione:  
`λz.(z y)[x/y] = λz.z x`.

---

## 3. **Regole di conversione (semantica)**

Il λ-calcolo ha tre regole di riscrittura:

1. **α-conversione**:  
   `λx.E =α λy.(E[y/x])`, se `y ∉ varLibere(E)`.  
   Permette di rinominare variabili legate senza cambiare il significato.

2. **β-conversione** (regola fondamentale):  
   `(λx.E) F =β E[F/x]`.  
   Formalizza l'applicazione di una funzione a un argomento.

3. **η-conversione** (estensionalità):  
   `λx.E x =η E`, se `x ∉ varLibere(E)`.  
   Esprime che due funzioni sono uguali se producono gli stessi risultati su ogni argomento.

Queste regole generano relazioni di equivalenza (`≡α`, `≡β`, `≡η`) che sono **congruenze** rispetto a sintassi e applicazione.

---

## 4. **Riduzione e strategie**

Le regole possono essere orientate come **riduzioni**:

- **β-riduzione**: `(λx.E) F →β E[F/x]`
- **η-riduzione**: `λx.E x →η E` (se `x` non libera in `E`)

### Forma normale
Un termine è in **forma normale** se non contiene β-radicali, cioè nessun sottotermine della forma `(λx.E) F`.  
Non tutti i termini hanno forma normale (es. `Ω = (λx.x x)(λx.x x)` che riduce all'infinito).

### Strategie di riduzione
- **Call-by-name**: riduce sempre il radicale più esterno a sinistra.  
  - Se la forma normale esiste, questa strategia la trova (teorema di Curry).
- **Call-by-value**: riduce il radicale più interno a sinistra (prima valuta gli argomenti).  
  - Più efficiente in alcuni casi, ma può non terminare anche se la forma normale esiste.
- **Call-by-need** (lazy evaluation): condivide i sottotermini per evitare ricalcoli, combinando i vantaggi delle due precedenti.

### Confluenza (Teorema di Church-Rosser)
- Se `E →β* E₁` e `E →β* E₂`, allora esiste `E'` tale che `E₁ →β* E'` e `E₂ →β* E'`.
- **Conseguenza**: la forma normale, se esiste, è unica (a meno di α-conversione).
- La β-teoria è **coerente**: non tutti i termini sono equivalenti.

---

## 5. **Logica Combinatoria**

La logica combinatoria è un formalismo equivalente al λ-calcolo ma **senza variabili legate**.  
Si basa su due soli combinatori:

- `K = λx.λy.x`
- `S = λx.λy.λz.x z (y z)`

Regole di riduzione:
- `K P Q → P`
- `S P Q R → P R (Q R)`

### Simulazione della λ-astrazione
Si definisce `λx.P` (per variabili e combinatori) induttivamente:
- Se `P = x` → `S K K`
- Se `x ∉ var(P)` → `K P`
- Se `P = P₁ P₂` → `S (λx.P₁) (λx.P₂)`

**Teorema**: per ogni `P, Q`, si ha `(λx.P) Q →* P[Q/x]`.  
Quindi la logica combinatoria è Turing-equivalente al λ-calcolo.

---

## 6. **Ricorsione e combinatori di punto fisso**

Le funzioni nel λ-calcolo sono anonime, quindi la ricorsione diretta non è possibile.  
Si usano **combinatori di punto fisso**:

- **Combinatore di Turing**:  
  `Θ = (λx.λy.y (x x y)) (λx.λy.y (x x y))`  
  Proprietà: `Θ E →β E (Θ E)`

- **Combinatore di Curry**:  
  `Y = λf.(λx.f (x x)) (λx.f (x x))`  
  Proprietà: `Y E →β E (Y E)`

Questi combinatori permettono di definire funzioni ricorsive nel modo seguente:  
data una funzione ricorsiva `f = ... f ...`, la si esprime come `F = λf. ... f ...`, e si pone `f = Θ F`.

---

## 7. **Rappresentazione dei numeri (Church numerals)**

I numeri naturali sono rappresentati come iteratori:

- `0 = λs.λz.z`
- `1 = λs.λz.s z`
- `2 = λs.λz.s (s z)`
- `n = λs.λz.sⁿ z`

Operazioni aritmetiche definibili:
- `succ = λn.λs.λz.s (n s z)`
- `add = λm.λn.λs.λz.m s (n s z)`
- `mult = λm.λn.λs.m (n s)`
- `exp = λm.λn.n m`

Predicati e controllo:
- `test0 = λn.λp.λq.n (K q) p`  
  Restituisce `p` se `n = 0`, altrimenti `q`.

---

## 8. **Calcolabilità e ricorsione generale**

- **Tesi di Church-Turing**: le funzioni calcolabili con un metodo effettivo sono esattamente quelle λ-definibili, Turing-calcolabili o ricorsive generali.
- **Funzioni ricorsive primitive**:  
  - Base: zero, successore, proiezioni.  
  - Chiuse per composizione e ricorsione primitiva.  
  - Non includono tutte le funzioni calcolabili (es. Ackermann).
- **Ricorsione generale**: aggiunge l'operatore di minimizzazione (`μ`), che cerca il primo `k` tale che `h(k, x₁, ..., xₘ) = 0`.

**Codifica nel λ-calcolo**:
- Ogni funzione ricorsiva primitiva è definibile con Church numerals.
- La ricorsione generale si implementa con un combinatore di punto fisso che genera la sequenza dei valori di `h` fino a trovare zero.

---

## 9. **Sistemi di tipi**

I tipi servono a prevenire paradossi e garantire terminazione.

### Tipi semplici
- Tipi base: `τ, σ, ρ, ...`
- Tipo funzione: `τ → σ` (associativo a destra).

### Due approcci
- **Church-style**: i tipi sono esplicitati nei termini.  
  Esempio: `λx:τ.x:τ → τ`
- **Curry-style**: i tipi sono inferiti tramite regole.  
  Data una base `Γ` di assunzioni di tipo per variabili, si derivano giudizi `Γ ⊢ E : τ`.

Regole di inferenza (Curry):
- Se `x:τ ∈ Γ` → `Γ ⊢ x : τ`
- Se `Γ ∪ {x:τ} ⊢ E : σ` → `Γ ⊢ λx.E : τ → σ`
- Se `Γ ⊢ E₁ : τ → σ` e `Γ ⊢ E₂ : τ` → `Γ ⊢ E₁ E₂ : σ`

### Proprietà
- **Strong normalizzazione**: ogni termine tipato (senza punti fissi) termina.
- **Isomorfismo di Curry-Howard**:  
  - Tipi ↔ formule logiche (implicazione).  
  - Termini ↔ dimostrazioni.  
  - β-riduzione ↔ eliminazione del taglio (modus ponens).

### Punti fissi e ricorsione
I combinatori di punto fisso **non sono tipabili**. Per introdurre ricorsione si aggiungono costanti `Fτ` di tipo `(τ → τ) → τ` con regola δ:
`Fτ E →δ E (Fτ E)`

---

## 10. **Conclusioni e proprietà generali**

- Il λ-calcolo è un modello di computazione universale.
- La sua sintassi semplice e la potenza espressiva lo rendono ideale per studiare calcolabilità, logica e linguaggi di programmazione.
- I sistemi di tipi garantiscono proprietà di terminazione e correttezza, ma limitano l'espressività (es. nessuna ricorsione non tipata).
- La confluenza assicura che il risultato di una computazione, se esiste, è unico indipendentemente dalla strategia.