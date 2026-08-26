
% Giovanni è genitore di Andrea
genitore(giovanni, andrea).
% Andrea è genitore di Paolo
genitore(andrea, paolo).

% X è antenato di Y se X è genitore di Y
antenato(X, Y) :- genitore(X, Y).
% X è antenato di Y se X è genitore di Z e Z è antenato di Y
antenato(X, Y) :- genitore(X, Z), antenato(Z, Y).

% Termini: gli elementi base di Prolog sono:
% * Atomi
%   * costanti numeriche: 10, -13.5
%   * costanti simboliche: iniziano con una lettera minuscola
%     gatto, 'Proprietario_di'
% * Variabili: iniziano con una lettera Maiuscola (X, Risultato_operazione)
%   o sono il singolo underscore _ (variabile anonima).
% * Termini composti: strutturati come funtore(arg1, arg2, ...)
%   Esempio: ab(5, nil, nil).
% * Liste: sequenze di elementi tra parentesi quadre [].
%   L'operatore | divide la testa dalla coda ([X | L]). Lista vuota []
% * Stringhe: sequenze di caratteri tra virgolette doppie ("Ciao")
%   implementate come liste
%
% Predicati di base ed esempi:

lista([]).
lista([X | L]). % Verifica se un termine è una lista

membro(X, [X | L]).
membro(X, [Y | L]) :- membro(X, L).

prefisso([], L)              :- lista(L).
prefisso([X | L1], [X | L2]) :- prefisso(L1, L2).


