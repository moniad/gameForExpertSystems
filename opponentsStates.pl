=================== stany przeciwnika ===============

spokojny(przeciwnik) :- odleglosc(gracz, przeciwnik, >7) # >7 w każdą stronę
spokojny(przeciwnik) :- odleglosc(gracz, przeciwnik, 1-7), kuca(gracz), !jest_w_polu_widzenia_przeciwnika(gracz)

zaniepokojony(przeciwnik) :- odleglosc(gracz, przeciwnik, 1-7), stoi(gracz) # przeciwnik wyczuwa/słyszy gracza, wiec staje sie zaniepokojony
# TODO: odległość