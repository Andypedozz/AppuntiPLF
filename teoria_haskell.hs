-- ##########################################
-- #               HASKELL                  #
-- ##########################################
--
-- Differenze con la programmazione imperativa
-- * I programmi sono collezioni di funzioni da valutare, non sequenze di istruzioni
-- * Le variabili creano legami immutabili
-- * Assenza di effetti collaterarli
-- * LA ricorsione è il principale strumento per l'iterazione
--
-- Caratteristiche principali di Haskell:
-- * Sintassi equazionale:
-- * Stile dichiarativo: definizioni di funzioni per casi, con guardie e sezioni locali (where)
-- * Pattern Matching: i modelli nei parametri formali semplificano la definizione
-- * Funzioni di ordine superiore: funzioni che accettano e restituiscono altre funzioni
-- * Valutazione pigra: gli argomenti vengono valutati solo quando necessario
-- * Tipi e classi di tipi: sistema di tipi forte con inferenza, polimorfismo e overloading
-- * Gestione automatica della memoria: garbage collection
-- * Sistema di I/O e moduli: modularità programmi

-- Quicksort
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x : xs) = quicksort xs_inf ++ [x] ++ quicksort xs_sup
    where
        xs_inf = filter (<= x) xs
        xs_sup = filter (> x) xs

-- Spiegazione: la funzione filter ammette un argomento di tipo predicato (a -> Bool) che dato un elemento
-- restituisce un valore True o False, una lista di elementi, e ha come dato di output una nuova lista
-- di elementi.
-- Il caso base della ricorsione indica che la funzione myFilter, applicata a _ (pattern che indica un
-- qualsiasi valore che poi non viene più usato) e [] (lista vuota), restituisce la lista vuota.
-- Il caso generale indica che la funzione applicata a un predicato e a una lista non vuota (x : xs) restituisce:
-- * l'elemento corrente (x) se esso soddisfa il predicato p, e poi prosegue ad analizzare i restanti elementi richiamando myFilter
-- * scarta l'elemento corrente (x) e passa ad analizzare gli elementi successivi
myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter p (x : xs) | p x = x : myFilter p xs
                    | otherwise = myFilter p xs

-- Espressioni, Tipi di Dati e Classi di Tipi
-- * Espressioni: formate da valori, operatori e identificatori. Vengono valutate SOLO se ben tipate
-- * Tipi scalari predefiniti: Int, Integer, Float, Double, Bool, Char
-- * Classi di Tipi: Collezioni di tipi che confividono operatori (overloading). Formano una gerarchia
--     * Eq: Uguaglianza (==, /=)
--     * Ord: ordinamento (<, <=, >, >=, min, max). Sottoclasse di Eq
--     * Num: operazioni aritmetiche (+,-,*,negate, abs, signum). Sottoclasse di Eq
--            ma non di Ord a causa dei numeri complessi.
--     * Integral: Interi (div, mod, even, odd). Sottoclasse di Num, Enum, Ord
--     * Fractional: Reali (/, recip). Sottoclasse di Num
--     * Floating: Funzioni matematiche (pi, exp, log, sqrt, sin, cos). Sottoclasse di Fractional

-- Esempi:
-- div 7 2 (o 7 `div` 2) = 3
-- 7 / 2 = 3.5
-- 4 + 1.0 = 5.0 (Fractional)
-- abs (-8.3) = corretto, abs -8.3 = scorretto
-- False < True = True
--
-- Tipi enumerati definiti dall utente (Dati)
data Giorno = Lunedi | Martedi | Mercoledi | Giovedi | Venerdi | Sabato | Domenica
    deriving (Eq, Ord, Enum)
domani :: Giorno -> Giorno
domani Domenica = Lunedi
domani g = succ g

ieri :: Giorno -> Giorno
ieri Lunedi = Domenica
ieri g = pred g

-- Tipi strutturati
-- * Tuple: sequenza di lungehzza fissa di elementi di tipi anche diversi (1, "Ciao")
-- * Liste: sequenza di lungehzza variabile di elementi dello STESSO tipo
--      Operatori:
--         * ":" Costruttore di lista
--         * "++" Concatenazione
--      Le stringhe sono liste di Char
-- * Alias (type): servono a ridenominare tipi.
type Relazione a = [(a, a)]

-- Tipi unione e ricorsivi
data Numero = I Int | F Float
data Nat = Z | S Nat

-- Definizioni e legami: le variabili sono costanti simboliche, possono essere globali o locali.
-- L'ordine delle definizioni è irrilevante
circonferenza :: Float
circonferenza = pi * diametro
    where
        diametro = raggio * 2
        raggio = sqrt 15.196

-- oppure
circonferenzaLetIn :: Float
circonferenzaLetIn = let
                    raggio = sqrt 15.196
                    diametro = 2 * raggio
                in
                    pi * diametro

-- Funzioni, Guardie, Pattern Matching
-- In haskell il formato della definizione di una funzione è un estensione del legamento di variabile.
-- Le uniche differenze sono la presenza dell'operatore -> e gli argomenti formali.
--
-- La definizione di una funzione consiste in una o più equazioni (casi base e generale della ricorsione)
-- ciascuna delel quali stabilische l'applicazione della funzioni ai suoi argomenti (a sinsitra di =),
-- e il corpo della funzione denotano lo stesso valore. In alternativa può essere vista come una λ-astrazione
-- La definizione di funzione può essere globale o locale e fare uso di if else oppure espressioni
-- condizionali seguite alla fine da otherwise
--
-- Esempio signum
signumBad x = if (x > 0)
            then 1
           else
            if (x == 0)
             then 0
            else -1

signum x | x > 0  = 1
         | x == 0 = 0
         | x < 0  = -1

-- Pattern Matching
-- Un pattern (modello) è un costrutto sintattico che specifica valori correlati e fornisce
-- nomi per accedere alle parti di tali valori
-- * ogni valore numerico, logico, carattere, enumerato, tupla, lista o stringa è un pattern
-- che intercetta solo il valore stesso (utili per casi base)
-- * ogni identificatore è un pattern che intercetta un qualsiasi valore, il quale viene legato
--  all'identificatore
-- * il simbolo _ è un pattern che intercetta un qualsiasi valore a cui non si fa iù riferimento
-- a destra di =
-- * se p1 e p2 sono pattern, allora anche p1 : p2 è un pattern che intercetta una lista il
-- cui primo elemento corrisponde a p1 e la cui sottolista degli elementi successivi corrisponde a p2
-- * se p1,...,pn sono pattern, allora anche (p1,...,pn) è un pattern che intercetta una tupla il cui
-- i-esimo elemento corrisponde a pi
-- * se p è un pattern e x è un identificatore, allora x@p è un pattern, detto ASCRIZIONE
-- utile nel caso in cui p non sia un valore scalare o un identificatore

-- Fattoriale
fattoriale :: Int -> Int
fattoriale 0 = 1
fattoriale n | n > 0 = n * fattoriale (n - 1)

-- Fibonacci
fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n | n > 1 = fibonacci (n - 1) + fibonacci (n - 2)

-- Operatori binari e ternari cortocircuitati
disg :: Bool -> Bool -> Bool
disg True _ = True
disg False x = x

cong :: Bool -> Bool -> Bool
cong False _ = False
cong True x = x

cond :: Bool -> a -> a -> a
cond True e _ = e
cond False _ e = e

membro :: (Eq a) => a -> [a] -> Bool
membro _ [] = False
membro x (y : ys) | x == y = True
                  | otherwise = membro x ys

lunghezza :: [a] -> Int
lunghezza [] = 0
lunghezza (_ : xs) = 1 + lunghezza xs

-- Funzioni polimorfe, di Ordine Superiore, Anonime
-- Polimorfismo: funzioni che operano su tipi generici (variabili di tipo)
identita :: a -> a
identita x = x

-- Overloading: polimorfismo ristretto a classi di tipi (Num a, Ord a) => a -> a
-- Funzioni di ordine superiore: accettano e restituiscono funzioni
-- * filter: seleziona elementi
-- * map: applica una funzione a un insieme di elementi
myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (x : xs) = f x : myMap f xs
-- * foldl e foldr; riduzione di liste da sinistra o destra. La loro applicazione permette
-- di definire sum, product, reverse, etc.
mySum :: (Num a) => [a] -> a
mySum = foldl (+) 0

-- Valutazione Pigra
-- Gli argomenti vengono valutati solo quando necessari.
-- Permette di gestire strutture dati infinite.
generaDa :: Int -> [Int]
generaDa m = m : generaDa (m + 1)

generaDaA :: Int -> Int -> [Int]
generaDaA m n = take (n - m + 1) (generaDa m)

-- I/O: Azioni che interagiscono con l'ambiente. Il tipo "IO a" denota un'azione
-- che produce un valore di tipo a. Le azioni sono combinate con do
main = do
    putStrLn "Inserisci il tuo nome: "
    nome <- getLine
    putStrLn ("Ciao, " ++ nome)

-- Classi Read e Show: per convertire stringhe in valori (read) e valori in stringhe (show)
main = do
    input <- getLine
    putStrLn $ show (quicksort (read input :: [Int]))

-- Moduli
-- Organizzazione del codice. Ogni modulo inizia con "module Nome where".
-- Si importano altri moduli con import. Il modulo Prelude è importato automaticamente
module AlberoBin where
data AlberoBin a = Nil | Nodo a (AlberoBin a) (AlberoBin a) deriving  (Read, Show)
-- definizioni di funzioni per alberi
