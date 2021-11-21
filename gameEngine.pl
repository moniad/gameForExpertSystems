- system eks. sterujący przeciwnikiem i grą
- w bazie wiedzy trzymamy fakty o pozycji gracza i przeciwnika (tutaj też info o jego rotacji).
W razie zmian usuwamy stare reguly i dodajemy nowe
- ruchy gracza i przeciwnika polegają na każdorazowym przejściu o jedno pole w lewo/prawo/górę/dół
- przeciwnik ma 2 stany: spokojny i zaniepokojony. W stanie spokojnym robi obchód. Gdy gracz zblizy się zbyt blisko do przeciwnika i nie kuca, przeciwnik go wyczuje/usłyszy i wówczas przeciwnik staje się zaniepokojony. Tym samym obchód kończy się, a przeciwnik się obraca w stronę gracza i z kolejnym ruchem rozpoczyna znowu obchód.

----------------- pytania ------------------
- czy w Pythonie mamy programować sprawdzanie, czy gracz nie wychodzi poza planszę, czy tak jak dla przeciwnika, ma to być w Prologu? W Prologu

===== ruchy przeciwnika ====== # TODO
zrob_krok(przeciwnik, kierunek) :- TODO. jeśli nowa pozycja nie będzie poza planszą # przejscie o jedno pole w lewo, prawo, góra, dół
# gdy jesteśmy na skraju planszy i kolejny ruch spowoduje wyjście poza planszę - losujemy inny kierunek ruchu i zaczynamy obchód w nową stronę

popatrz_w_strone(przeciwnik, kierunek) :- obrot_w_obchodzie(przeciwnik, 3), popatrz_w_strone(gracz)

obchod(przeciwnik) :- spokojny(przeciwnik)

ruch_w_obchodzie(przeciwnik, licznik, kierunek) :- obchod(przeciwnik), licznik==1, zrob_krok(przeciwnik, kierunek)
# w stanie spokojnym przeciwnik się rusza co 2 ruchy gracza, po 3 takich przejściach zmienia stronę patrzenia

obrot_w_obchodzie(przeciwnik, licznik_ruchow) :- obchod(przeciwnik), licznik_ruchow == 3 # todo: po obrocie zerować licznik_ruchów

=================== stany przeciwnika i wygrana/przegrana ===============
spokojny(przeciwnik) :- odleglosc(gracz, przeciwnik, >7) # >7 w każdą stronę
spokojny(przeciwnik) :- odleglosc(gracz, przeciwnik, 1-7), kuca(gracz), poza_polem_widzenia_przeciwnika(gracz)

popatrz_w_strone(gracz) :- zaniepokojny(przeciwnik)
zaniepokojony(przeciwnik) :- odleglosc(gracz, przeciwnik, 1-7), stoi(gracz) # przeciwnik wyczuwa/słyszy gracza, wiec staje sie zaniepokojony

# gdy przeciwnik widzi gracza, gracz przegrywa
ginie(gracz) :- odleglosc(gracz, przeciwnik, 1-5), stoi(gracz)
ginie(gracz) :- jest_w_polu_widzenia_przeciwnika(gracz)

wygrywa(gracz) :- spokojny(przeciwnik), odleglosc(gracz, przeciwnik, 1)

jest_w_polu_widzenia_przeciwnika(gracz) :- dowolny stan gracza, pozycja #todo


------ TODO: do przemyślenia:
- wyznaczanie kierunku przeciwnika, jak zobaczy gracza: mamy policzyć różnicę w odległościach po x i y, i wybrać większą - w tą stronę przeciwnik się obraca
- kucnięcie NIE powoduje utraty ruchu gracza - na wejściu podajemy następną pozycję + info, czy kuca, czy idzie normalnie - JEDNAK nie, gracz może kucać przez 5 ruchów (może więcej?)
- koszty kucania: np. dwukrotnie wolniejszy chód (rytm jak kroki przeciwnika)
- co z kierunkiem patrzenia? na razie będziemy go znać w pełni (później można zmodyfikować grę - tzn. zwiększyć długość kroku przeciwnika, dodać wnioskowanie kierunku patrzenia)
- gracz musi wywnioskować algorytm obchodu przeciwnika (np. przeciwnik będzie sie poruszac po kwiatku) - jakiś skomplikowany, ustalony algorytm
- kod bardziej wykonywalny
- zerknąć na kod z wykładu
