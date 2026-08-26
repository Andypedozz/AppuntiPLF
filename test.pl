% Correct
lunghezza([_|T], L) :-
    lunghezza(T, L1),
    L is 1 + L1.

% Calcolo somma
somma([], 0).
somma([X|T], S) :-
    somma(T, S1),
    S is X + S1.

% Ultimo elemento
ultimo([_|T], U) :-
    ultimo(T, U).

% Membro
membro(X, [X|_]).
membro(X, [_|T]) :-
    membro(X, T).

% Scarta multipli dispari di 5
scarta([], []).
scarta([X|T], L) :-
    X mod 5 =:= 0,
    X mod 2 =\= 0,
    scarta(T, L).
scarta([X|T], [X|L]) :-
    \+ (X mod 5 =:= 0, X mod 2 =\= 0),
    scarta(T, L).
