=================== ruchy gracza ===============
# zrob_krok to event z poziomu Pythona
zrob_krok_graczem_w_lewo :- zrob_krok(gracz, lewo)
zrob_krok_graczem_w_prawo :- zrob_krok(gracz, prawo)
zrob_krok_graczem_w_gore :- zrob_krok(gracz, gora)
zrob_krok_graczem_w_dol :- zrob_krok(gracz, dol)

pozycja(gracz, X - 1, Y) :- zrob_krok_graczem_w_lewo, pole_miesci_sie_w_planszy(X - 1, Y)
pozycja(gracz, X + 1, Y) :- zrob_krok_graczem_w_prawo, pole_miesci_sie_w_planszy(X + 1, Y)
pozycja(gracz, X, Y + 1) :- zrob_krok_graczem_w_gore, pole_miesci_sie_w_planszy(X, Y + 1)
pozycja(gracz, X, Y - 1) :- zrob_krok_graczem_w_dol, pole_miesci_sie_w_planszy(X, Y - 1)