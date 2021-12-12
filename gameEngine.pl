%- system eks. sterujący przeciwnikiem i grą
%- w bazie wiedzy trzymamy fakty o pozycji gracza i przeciwnika (tutaj też info o jego rotacji).
%W razie zmian usuwamy stare reguly i dodajemy nowe
%- ruchy gracza i przeciwnika polegają na każdorazowym przejściu o jedno pole w lewo/prawo/górę/dół
%- przeciwnik ma 2 stany: spokojny i zaniepokojony. W stanie spokojnym robi obchód. Gdy gracz zblizy się zbyt blisko do przeciwnika i nie kuca, przeciwnik go wyczuje/usłyszy i wówczas przeciwnik staje się zaniepokojony. Tym samym obchód kończy się, a przeciwnik się obraca w stronę gracza i z kolejnym ruchem rozpoczyna znowu obchód.

%- w Prologu mamy programować sprawdzanie, czy gracz nie wychodzi poza planszę, tak jak dla przeciwnika
%- gracz musi wywnioskować algorytm obchodu przeciwnika (np. przeciwnik będzie sie poruszac po kwiatku) - jakiś skomplikowany, ustalony algorytm
%- gracz może kucać max przez 5 ruchów
%- co z kierunkiem patrzenia przeciwnika? na razie będziemy go znać w pełni (później można zmodyfikować grę - tzn. zwiększyć długość kroku przeciwnika, dodać wnioskowanie kierunku patrzenia)

%=================== wygrana/przegrana ===============

%# gdy przeciwnik widzi gracza, gracz przegrywa
dies(player) :- distance(player, opponent, DIST), DIST =< 5, not(crawls(player)).
dies(player) :- in_opponent_fov(player).

wins(player) :- calm(opponent), distance(player, opponent, DIST), DIST = 1, crawls(player).

%----------------- pytania ------------------
%- w Prologu jest domyślnie backward chaining - czyli apka ma działać tak, że odpytujemy z poziomu aplikacji
%Pythonowej o to, czy po wykonaniu ruchu gracz wygrywa/przegrywa, gdzie przesunąć gracza i przeciwnika? Y
%- czy da się wywnioskować dwa predykaty, jeśli ich przesłanka złożona z jednego predykatu bedzie prawdziwa?
%np. # patrzenie w tę samą stronę, w którą odbywają się kroki. ANS: Napisać nowy wniosek, który ma w koniunkcji te dwa
%chyba wystarczy nie zastosować operatora cięcia? wtedy wszystkie predykaty, które są prawdziwe powinny zostać
%wyprowadzone? chociaż to jest forward chaining...
%- czy początkową pozycję gracza i przeciwnika możemy wstawić poprzez wywołanie Prologa z poziomu Pythona?
%chodzi o to, żeby zapobiec temu, że przy każdym wnioskowaniu będą wstawiane do bazy wiedzy początkowe pozycje gracza i przeciwnika
%- przeciwnik_patrzy_w_dol :- krok_w_dol # TODO: czy "przeciwnik_patrzy_w_dol" z automatu przestanie być prawdziwe, gdyby "krok_w_dol" usunac z bazy wiedzy???
%chyba tak, bo w Prologu nie ma lazy evaluation?
