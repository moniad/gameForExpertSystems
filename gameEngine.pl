- system eks. sterujący przeciwnikiem i grą
- w bazie wiedzy trzymamy fakty o pozycji gracza i przeciwnika (tutaj też info o jego rotacji).
W razie zmian usuwamy stare reguly i dodajemy nowe
- ruchy gracza i przeciwnika polegają na każdorazowym przejściu o jedno pole w lewo/prawo/górę/dół
- przeciwnik ma 2 stany: spokojny i zaniepokojony. W stanie spokojnym robi obchód. Gdy gracz zblizy się zbyt blisko do przeciwnika i nie kuca, przeciwnik go wyczuje/usłyszy i wówczas przeciwnik staje się zaniepokojony. Tym samym obchód kończy się, a przeciwnik się obraca w stronę gracza i z kolejnym ruchem rozpoczyna znowu obchód.

=================== wygrana/przegrana ===============

# gdy przeciwnik widzi gracza, gracz przegrywa
ginie(gracz) :- odleglosc(gracz, przeciwnik, 1-5), stoi(gracz)
ginie(gracz) :- jest_w_polu_widzenia_przeciwnika(gracz)

wygrywa(gracz) :- spokojny(przeciwnik), odleglosc(gracz, przeciwnik, 1)

----------------- pytania ------------------
- czy w Pythonie mamy programować sprawdzanie, czy gracz nie wychodzi poza planszę, czy tak jak dla przeciwnika, ma to być w Prologu? W Prologu

------ TODO: do przemyślenia:
- czy gracz wygrywa, gdy podejdzie też do przeciwnika w odl. 1 na ukos ??
- wyznaczanie kierunku przeciwnika, jak zobaczy gracza: mamy policzyć różnicę w odległościach po x i y, i wybrać większą - w tą stronę przeciwnik się obraca
- kucnięcie NIE powoduje utraty ruchu gracza - na wejściu podajemy następną pozycję + info, czy kuca, czy idzie normalnie - JEDNAK nie, gracz może kucać przez 5 ruchów (może więcej?)
- koszty kucania: np. dwukrotnie wolniejszy chód (rytm jak kroki przeciwnika)
- co z kierunkiem patrzenia? na razie będziemy go znać w pełni (później można zmodyfikować grę - tzn. zwiększyć długość kroku przeciwnika, dodać wnioskowanie kierunku patrzenia)
- gracz musi wywnioskować algorytm obchodu przeciwnika (np. przeciwnik będzie sie poruszac po kwiatku) - jakiś skomplikowany, ustalony algorytm
- kod bardziej wykonywalny
- zerknąć na kod z wykładu
