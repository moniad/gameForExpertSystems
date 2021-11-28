=================== ruchy przeciwnika ===============

popatrz_w_strone(gracz) :- zaniepokojony(przeciwnik).

:- dynamic ma_wartosc/2, zmien_pozycje/3, pozycja/3.

#################### OBCHÓD ####################
zaczyna_obchod(przeciwnik) :- spokojny(przeciwnik).
# zerowanie licznika kroków, gdy przeciwnik zaczyna obchód lub zrobił pełny obchód
retract(ma_wartosc(licznik_krokow, _)) :- zaczyna_obchod(przeciwnik).
retract(ma_wartosc(licznik_krokow, _)) :- ma_wartosc(licznik_krokow, 36).
ma_wartosc(licznik_krokow, 0) :- zaczyna_obchod(przeciwnik).
ma_wartosc(licznik_krokow, 0) :- ma_wartosc(licznik_krokow, 36).


# obchod zaczyna sie od 3 krokow w prawo, a potem w gore
zrob_krok_w_prawo :- ma_wartosc_z_zakresu(licznik_krokow, [0, 1, 2, 6, 7, 8, 12, 13, 14]), nastapily_dwa_ruchy_gracza.
zrob_krok_w_gore :- ma_wartosc_z_zakresu(licznik_krokow, [3, 4, 5, 27, 28, 29, 33, 34, 35]), nastapily_dwa_ruchy_gracza.
zrob_krok_w_dol :- ma_wartosc_z_zakresu(licznik_krokow, [9, 10, 11, 15, 16, 17, 21, 22, 23]), nastapily_dwa_ruchy_gracza.
zrob_krok_w_lewo :- ma_wartosc_z_zakresu(licznik_krokow, [18, 19, 20, 24, 25, 26, 30, 31, 32]), nastapily_dwa_ruchy_gracza.

# czy element należy do listy
ma_wartosc_z_zakresu(licznik_krokow, [licznik_krokow | _]).
ma_wartosc_z_zakresu(licznik_krokow, [_ | T]) :- ma_wartosc_z_zakresu(licznik_krokow, T).


# usuniecie z bazy wiedzy potencjalnego poprzedniego kierunku patrzenia (konieczne, gdy nastąpiła zmiana kierunku chodu):
retract(przeciwnik_patrzy_w_lewo) :- zrob_krok_w_prawo.
retract(przeciwnik_patrzy_w_gore) :- zrob_krok_w_prawo.
retract(przeciwnik_patrzy_w_dol) :- zrob_krok_w_prawo.

retract(przeciwnik_patrzy_w_prawo) :- zrob_krok_w_lewo.
retract(przeciwnik_patrzy_w_gore) :- zrob_krok_w_lewo.
retract(przeciwnik_patrzy_w_dol) :- zrob_krok_w_lewo.

retract(przeciwnik_patrzy_w_prawo) :- zrob_krok_w_gore.
retract(przeciwnik_patrzy_w_lewo) :- zrob_krok_w_gore.
retract(przeciwnik_patrzy_w_dol) :- zrob_krok_w_gore.

retract(przeciwnik_patrzy_w_prawo) :- zrob_krok_w_dol.
retract(przeciwnik_patrzy_w_lewo) :- zrob_krok_w_dol.
retract(przeciwnik_patrzy_w_gore) :- zrob_krok_w_dol.


# patrzenie w tę samą stronę, w którą odbywają się kroki
przeciwnik_patrzy_w_prawo :- zrob_krok_w_prawo.
przeciwnik_patrzy_w_lewo :- zrob_krok_w_lewo.
przeciwnik_patrzy_w_gore :- zrob_krok_w_gore.
przeciwnik_patrzy_w_dol :- zrob_krok_w_dol.


zmien_pozycje(przeciwnik, x + 1, y) :- zrob_krok_w_prawo.
zmien_pozycje(przeciwnik, x, y + 1) :- zrob_krok_w_gore.
zmien_pozycje(przeciwnik, x, y - 1) :- zrob_krok_w_dol.
zmien_pozycje(przeciwnik, x - 1, y) :- zrob_krok_w_lewo.


# usuniecie z bazy wiedzy poprzedniej pozycji przeciwnika, aktualnego kierunku kroku przeciwnika i zmiennej mowiacej, ze przeciwnik moze wykonac kolejny ruch
retract(nastapily_dwa_ruchy_gracza) :- zmien_pozycje(przeciwnik, _, _).
retract(zrob_krok_w_prawo) :- zmien_pozycje(przeciwnik, _, _).
retract(zrob_krok_w_lewo) :- zmien_pozycje(przeciwnik, _, _).
retract(zrob_krok_w_gore) :- zmien_pozycje(przeciwnik, _, _).
retract(zrob_krok_w_dol) :- zmien_pozycje(przeciwnik, _, _).
retract(pozycja(przeciwnik, _, _)) :- zmien_pozycje(przeciwnik, _, _).
pozycja(przeciwnik, X, Y) :- zmien_pozycje(przeciwnik, X, Y).

# zwiekszanie wartosci licznika krokow przy zmianie pozycji
ma_wartosc(licznik_krokow, licznik_krokow + 1) :- zmien_pozycje(przeciwnik, _, _).
# wyrzucenie z bazy wiedzy poprzedniej wartości licznika oraz predykatu zmiany pozycji przeciwnika
retract(ma_wartosc(licznik_krokow, licznik_krokow - 1) :- zmien_pozycje(przeciwnik, _, _).
retract(zmien_pozycje(przeciwnik, _, _)).
