=================== ruchy gracza ===============
# zrob_krok to event z poziomu Pythona
zrob_krok_graczem_w_lewo :- zrob_krok(gracz, lewo)
zrob_krok_graczem_w_prawo :- zrob_krok(gracz, prawo)
zrob_krok_graczem_w_gore :- zrob_krok(gracz, gora)
zrob_krok_graczem_w_dol :- zrob_krok(gracz, dol)

pozycja(gracz, x - 1, y) :- zrob_krok_graczem_w_lewo, pole_miesci_sie_w_planszy(x - 1, y)
pozycja(gracz, x + 1, y) :- zrob_krok_graczem_w_prawo, pole_miesci_sie_w_planszy(x + 1, y)
pozycja(gracz, x, y + 1) :- zrob_krok_graczem_w_gore, pole_miesci_sie_w_planszy(x, y + 1)
pozycja(gracz, x, y - 1) :- zrob_krok_graczem_w_dol, pole_miesci_sie_w_planszy(x, y - 1)