=================== stany przeciwnika ===============
# zmiana stanu następuje dopiero po tym, jak nastapily_dwa_ruchy_gracza

spokojny(przeciwnik) :- nastapily_dwa_ruchy_gracza, odleglosc(gracz, przeciwnik, 1-7), kuca(gracz). # predykaty o wygranej i przegranej mają być najwyżej
spokojny(przeciwnik) :- nastapily_dwa_ruchy_gracza, odleglosc(gracz, przeciwnik, _). # >7 w każdą stronę

zaniepokojony(przeciwnik) :- nastapily_dwa_ruchy_gracza, odleglosc(gracz, przeciwnik, 1-7), stoi(gracz). # przeciwnik wyczuwa/słyszy gracza, wiec staje sie zaniepokojony
# TODO: odległość