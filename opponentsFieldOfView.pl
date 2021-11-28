jest_w_polu_widzenia_przeciwnika(gracz) :- gracz_w_prostokacie_11x11_dookola_przeciwnika(gracz, przeciwnik), przeciwnik_patrzy_w_strone_gracza.
gracz_w_prostokacie_11x11_dookola_przeciwnika :- abs(gracz.x - przeciwnik.x) <= 5, abs(gracz.y - przeciwnik.y) <= 5.
przeciwnik_patrzy_w_strone_gracza :- przeciwnik_patrzy_w_lewo, gracz_na_lewo(przeciwnik), przeciwnik.x - gracz.x > abs(gracz.y - przeciwnik.y).
przeciwnik_patrzy_w_strone_gracza :- przeciwnik_patrzy_w_prawo, gracz_na_prawo(przeciwnik), gracz.x - przeciwnik.x > abs(gracz.y - przeciwnik.y).
przeciwnik_patrzy_w_strone_gracza :- przeciwnik_patrzy_w_gore, gracz_do_gory(przeciwnik), gracz.y - przeciwnik.y > abs(gracz.x - przeciwnik.x).
przeciwnik_patrzy_w_strone_gracza :- przeciwnik_patrzy_w_dol, gracz_na_dol(przeciwnik), przeciwnik.y - gracz.y > abs(gracz.x - przeciwnik.x).

gracz_na_lewo(przeciwnik) :- przeciwnik.x - gracz.x > 0.
gracz_na_prawo(przeciwnik) :- gracz.x - przeciwnik.x > 0.
gracz_do_gory(przeciwnik) :- gracz.y - przeciwnik.y > 0.
gracz_na_dol(przeciwnik) :- przeciwnik.y - gracz.y > 0.