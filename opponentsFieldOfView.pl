gracz_w_prostokacie_11x11_dookola_przeciwnika :- abs(gracz.x - przeciwnik.x) <= 5, abs(gracz.y - przeciwnik.y) <= 5.
przeciwnik_patrzy_w_strone_gracza :- przeciwnik_patrzy_w_lewo, gracz_na_lewo(przeciwnik), przeciwnik.x - gracz.x > abs(gracz.y - przeciwnik.y).
przeciwnik_patrzy_w_strone_gracza :- przeciwnik_patrzy_w_prawo, gracz_na_prawo(przeciwnik), gracz.x - przeciwnik.x > abs(gracz.y - przeciwnik.y).
przeciwnik_patrzy_w_strone_gracza :- przeciwnik_patrzy_w_gore, gracz_do_gory(przeciwnik), gracz.y - przeciwnik.y > abs(gracz.x - przeciwnik.x).
przeciwnik_patrzy_w_strone_gracza :- przeciwnik_patrzy_w_dol, gracz_na_dol(przeciwnik), przeciwnik.y - gracz.y > abs(gracz.x - przeciwnik.x).

gracz_na_lewo(przeciwnik) :- przeciwnik.x - gracz.x > 0.
gracz_na_prawo(przeciwnik) :- gracz.x - przeciwnik.x > 0.
gracz_do_gory(przeciwnik) :- gracz.y - przeciwnik.y > 0.
gracz_na_dol(przeciwnik) :- przeciwnik.y - gracz.y > 0.

:- dynamic in_opponent_fov/1.
:- dynamic opponent_looks_right/0.
:- dynamic opponent_looks_left/0.
:- dynamic opponent_looks_down/0.
:- dynamic opponent_looks_up/0.

opponent_looks_down.
in_opponent_fov(player) :- opponent_looks_right, position(player, X, Y), position(opponent, Z, W), A is abs(Y - W), A = 4, B is X - Z, B = 1.
in_opponent_fov(player) :- opponent_looks_right, position(player, X, Y), position(opponent, Z, W), A is abs(Y - W), A = 3, B is X - Z, B >= 1, B =< 2.
in_opponent_fov(player) :- opponent_looks_right, position(player, X, Y), position(opponent, Z, W), A is abs(Y - W), A = 2, B is X - Z, B >= 1, B =< 3.
in_opponent_fov(player) :- opponent_looks_right, position(player, X, Y), position(opponent, Z, W), A is abs(Y - W), A = 1, B is X - Z, B >= 1, B =< 4.
in_opponent_fov(player) :- opponent_looks_right, position(player, X, Y), position(opponent, Z, W), A is abs(Y - W), A = 0, B is X - Z, B >= 1, B =< 5.

in_opponent_fov(player) :- opponent_looks_left, position(player, X, Y), position(opponent, Z, W), A is abs(Y - W), A = 4, B is Z - X, B = 1.
in_opponent_fov(player) :- opponent_looks_left, position(player, X, Y), position(opponent, Z, W), A is abs(Y - W), A = 3, B is Z - X, B >= 1, B =< 2.
in_opponent_fov(player) :- opponent_looks_left, position(player, X, Y), position(opponent, Z, W), A is abs(Y - W), A = 2, B is Z - X, B >= 1, B =< 3.
in_opponent_fov(player) :- opponent_looks_left, position(player, X, Y), position(opponent, Z, W), A is abs(Y - W), A = 1, B is Z - X, B >= 1, B =< 4.
in_opponent_fov(player) :- opponent_looks_left, position(player, X, Y), position(opponent, Z, W), A is abs(Y - W), A = 0, B is Z - X, B >= 1, B =< 5.

in_opponent_fov(player) :- opponent_looks_down, position(player, X, Y), position(opponent, Z, W), A is abs(X - Z), A = 4, B is W - Y, B = 1.
in_opponent_fov(player) :- opponent_looks_down, position(player, X, Y), position(opponent, Z, W), A is abs(X - Z), A = 3, B is W - Y, B >= 1, B =< 2.
in_opponent_fov(player) :- opponent_looks_down, position(player, X, Y), position(opponent, Z, W), A is abs(X - Z), A = 2, B is W - Y, B >= 1, B =< 3.
in_opponent_fov(player) :- opponent_looks_down, position(player, X, Y), position(opponent, Z, W), A is abs(X - Z), A = 1, B is W - Y, B >= 1, B =< 4.
in_opponent_fov(player) :- opponent_looks_down, position(player, X, Y), position(opponent, Z, W), A is abs(X - Z), A = 0, B is W - Y, B >= 1, B =< 5.

in_opponent_fov(player) :- opponent_looks_up, position(player, X, Y), position(opponent, Z, W), A is abs(X - Z), A = 4, B is Y - W, B = 1.
in_opponent_fov(player) :- opponent_looks_up, position(player, X, Y), position(opponent, Z, W), A is abs(X - Z), A = 3, B is Y - W, B >= 1, B =< 2.
in_opponent_fov(player) :- opponent_looks_up, position(player, X, Y), position(opponent, Z, W), A is abs(X - Z), A = 2, B is Y - W, B >= 1, B =< 3.
in_opponent_fov(player) :- opponent_looks_up, position(player, X, Y), position(opponent, Z, W), A is abs(X - Z), A = 1, B is Y - W, B >= 1, B =< 4.
in_opponent_fov(player) :- opponent_looks_up, position(player, X, Y), position(opponent, Z, W), A is abs(X - Z), A = 0, B is Y - W, B >= 1, B =< 5.
