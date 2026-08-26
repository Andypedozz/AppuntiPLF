## Principio di Induzione
E' il quinto assioma introdotto da Giuseppe Peano per dare una definizione assiomatica dei numeri naturali, ossia il più piccolo insieme che contiene lo 0 ed è chiuso rispetto alla operazione di successore.

Definizione:
1. Esiste un elemento 0∈N
2. Esiste una funzione totale succ: N -> N
3. Per ogni n∈N, succ(n) != 0
4. Per ogni n,n'∈N, se n != n' => succ(n) != succ(n')
5. Se M ⊆ N tale che:
    * 0∈M
    * per ogni n∈N, n∈M => succ(n)∈M
    allore M = N

I naturali sono quindi denotati con 0, succ(0), succ(succ(0)),... dove succ(0) = 1, succ(suc(0)) = 2 e cosi via.

Oltre ai naturali, il principio di induzione consente di definire in modo finito le quattro operazioni su N tramite succ: N -> N e la funzione totale pred: N \ {0} -> N | pred(succ(n)) = n per ogni n∈N \ {0}.

Definizione tramite succ e pred delle operazioni aritmetiche:
* Addizione:
m + n = 
{
    m                 se n = 0
    succ(m) + pred(n) se n != 0
}
* Sottrazione:
m - n =
{
    m                 se n = 0
    pred(m) - pred(n) se n != 0
}
* Moltiplicazione:
m * n =
{
    0                 se n = 0
    m + (m * pred(n)) se n > 0
}
* Divisione
m / n =
{
    0                 se m < n
    succ((m - n) / n) se m >= n
                      dove n != 0
}

Il principio di induzione fornisce un meccanismo per descrivere in modo finito un insieme infinito numerabile tramite la sua definizione ricorsiva che comprende uno o più casi base, in cui la definizione è espressa direttamente, e uno o più casi induttivi, in cui la definizione è espressa tramite una definizione della stessa natura ma più vicina a un caso base.
