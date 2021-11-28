%=================== ruchy gracza ===============
:- dynamic pozycja/3.
:- dynamic ruchy_gracza/1.
pozycja(gracz, 0, 0).
ruchy_gracza(0).

%# zrob_krok to event z poziomu Pythona
zrob_krok_graczem_w_lewo :- pozycja(gracz, X, Y), S is X - 1, pole_miesci_sie_w_planszy(S, Y), zrob_krok(S, Y).
zrob_krok_graczem_w_prawo :- pozycja(gracz, X, Y), S is X + 1, pole_miesci_sie_w_planszy(S, Y), zrob_krok(S, Y).
zrob_krok_graczem_w_gore :- pozycja(gracz, X, Y), S is Y + 1, pole_miesci_sie_w_planszy(X, S), zrob_krok(X, S).
zrob_krok_graczem_w_dol :- pozycja(gracz, X, Y), S is Y - 1, pole_miesci_sie_w_planszy(X, S), zrob_krok(X, S).
zrob_krok(X, Y) :- retract(pozycja(gracz, _, _)), asserta(pozycja(gracz, X, Y)), aktualizuj_licznik_ruchow_gracza.
pole_miesci_sie_w_planszy(X, Y) :- X >= 0, X < 30, Y >= 0, Y < 30.

%# update flagi dla kolejnego kroku w obchodzie przeciwnika
aktualizuj_licznik_ruchow_gracza :- ruchy_gracza(0), retract(ruchy_gracza(0)), asserta(ruchy_gracza(1)).
aktualizuj_licznik_ruchow_gracza :- ruchy_gracza(1), retract(ruchy_gracza(1)), asserta(ruchy_gracza(0)).