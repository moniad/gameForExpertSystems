=================== ruchy gracza ===============
:- dynamic pozycja/3

# zrob_krok to event z poziomu Pythona
zrob_krok_graczem_w_lewo :- zrob_krok(gracz, lewo)
zrob_krok_graczem_w_prawo :- zrob_krok(gracz, prawo)
zrob_krok_graczem_w_gore :- zrob_krok(gracz, gora)
zrob_krok_graczem_w_dol :- zrob_krok(gracz, dol)

zmien_pozycje(gracz, x - 1, y) :- zrob_krok_graczem_w_lewo, pole_miesci_sie_w_planszy(x - 1, y)
zmien_pozycje(gracz, x + 1, y) :- zrob_krok_graczem_w_prawo, pole_miesci_sie_w_planszy(x + 1, y)
zmien_pozycje(gracz, x, y + 1) :- zrob_krok_graczem_w_gore, pole_miesci_sie_w_planszy(x, y + 1)
zmien_pozycje(gracz, x, y - 1) :- zrob_krok_graczem_w_dol, pole_miesci_sie_w_planszy(x, y - 1)

retract(pozycja(gracz, _, _)) :- zmien_pozycje(gracz, _, _)
pozycja(gracz, nowy_x, nowy_y) :- zmien_pozycje(gracz, nowy_x, nowy_y)

# update flagi dla kolejnego kroku w obchodzie przeciwnika
nastapily_dwa_ruchy_gracza :- zmien_pozycje(gracz, _, _), nastapil_jeden_ruch_gracza
retract(nastapil_jeden_ruch_gracza) :- nastapily_dwa_ruchy_gracza
retract(zmien_pozycje(gracz, _, _)) :- nastapily_dwa_ruchy_gracza

nastapil_jeden_ruch_gracza :- zmien_pozycje(gracz, _, _)
retract(zmien_pozycje(gracz, _, _)) :- nastapil_jeden_ruch_gracza