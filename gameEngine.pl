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

game_over :- loses(player).
game_over :- wins(player).

loses(player) :- is_in_the_field_of_view(player, opponent).

wins(player) :- distance(player, opponent, DIST), DIST = 1.

%----------------- pytania ------------------
%- w Prologu jest domyślnie backward chaining - czyli apka ma działać tak, że odpytujemy z poziomu aplikacji
%Pythonowej o to, czy po wykonaniu ruchu gracz wygrywa/przegrywa, gdzie przesunąć gracza i przeciwnika? Y