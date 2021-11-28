=================== ruchy gracza ===============
:- dynamic pozycja/3.

# zrob_krok to event z poziomu Pythona
zrob_krok_graczem_w_lewo :- zrob_krok(gracz, lewo).
zrob_krok_graczem_w_prawo :- zrob_krok(gracz, prawo).
zrob_krok_graczem_w_gore :- zrob_krok(gracz, gora).
zrob_krok_graczem_w_dol :- zrob_krok(gracz, dol).

zmien_pozycje(gracz, X - 1, Y) :- zrob_krok_graczem_w_lewo, pole_miesci_sie_w_planszy(X - 1, Y).
zmien_pozycje(gracz, X + 1, Y) :- zrob_krok_graczem_w_prawo, pole_miesci_sie_w_planszy(X + 1, Y).
zmien_pozycje(gracz, X, Y + 1) :- zrob_krok_graczem_w_gore, pole_miesci_sie_w_planszy(X, Y + 1).
zmien_pozycje(gracz, X, Y - 1) :- zrob_krok_graczem_w_dol, pole_miesci_sie_w_planszy(X, Y - 1).

retract(pozycja(gracz, _, _)) :- zmien_pozycje(gracz, _, _).
pozycja(gracz, NOWY_X, NOWY_Y) :- zmien_pozycje(gracz, NOWY_X, NOWY_Y).

# update flagi dla kolejnego kroku w obchodzie przeciwnika
nastapily_dwa_ruchy_gracza :- zmien_pozycje(gracz, _, _), nastapil_jeden_ruch_gracza.
retract(nastapil_jeden_ruch_gracza) :- nastapily_dwa_ruchy_gracza.
retract(zmien_pozycje(gracz, _, _)) :- nastapily_dwa_ruchy_gracza.

nastapil_jeden_ruch_gracza :- zmien_pozycje(gracz, _, _).
retract(zmien_pozycje(gracz, _, _)) :- nastapil_jeden_ruch_gracza.