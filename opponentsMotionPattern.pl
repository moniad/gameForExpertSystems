=================== ruchy przeciwnika ===============
#TODO
zrob_krok(przeciwnik, kierunek) :- pole_miesci_sie_w_planszy(...) # przejscie o jedno pole w lewo, prawo, góra, dół
# gdy jesteśmy na skraju planszy i kolejny ruch spowoduje wyjście poza planszę - losujemy inny kierunek ruchu i zaczynamy obchód w nową stronę

popatrz_w_strone(przeciwnik, kierunek) :- obrot_w_obchodzie(przeciwnik, 3), popatrz_w_strone(gracz)

obchod(przeciwnik) :- spokojny(przeciwnik)

ruch_w_obchodzie(przeciwnik, licznik, kierunek) :- obchod(przeciwnik), licznik==1, zrob_krok(przeciwnik, kierunek)
# w stanie spokojnym przeciwnik się rusza co 2 ruchy gracza, po 3 takich przejściach zmienia stronę patrzenia

obrot_w_obchodzie(przeciwnik, licznik_ruchow) :- obchod(przeciwnik), licznik_ruchow == 3 # todo: po obrocie zerować licznik_ruchów
popatrz_w_strone(gracz) :- zaniepokojny(przeciwnik)