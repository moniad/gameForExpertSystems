%=================== ruchy opponenta ===============

popatrz_w_strone(gracz) :- zaniepokojony(opponent).

:- dynamic opponent_patrzy_w_prawo/0, opponent_patrzy_w_lewo/0, opponent_patrzy_w_gore/0, opponent_patrzy_w_dol/0.

% TODO: workaround until opponent's movement is fully integrated with player's movement
:- retract(players_movement_counter(0)).
:- asserta(players_movement_counter(2)).

:- asserta(opponent_patrzy_w_prawo).
:- asserta(opponents_movement_counter(0)).

% #################### OBCHÓD ####################
zaczyna_obchod(opponent) :- calm(opponent), players_movement_counter(2), opponents_movement_counter(0).
% TODO: pytac o zaczyna_obchod - ok??

% obchod zaczyna sie od 3 krokow w prawo, a potem w gore
zrob_krok_w_prawo :- opponents_movement_counter(0), players_movement_counter(2), move_opponent_right, update_movement_counters(0).
zrob_krok_w_prawo :- opponents_movement_counter(1), players_movement_counter(2), move_opponent_right, update_movement_counters(1).
zrob_krok_w_prawo :- opponents_movement_counter(2), players_movement_counter(2), move_opponent_right, update_movement_counters(2).
zrob_krok_w_prawo :- opponents_movement_counter(6), players_movement_counter(2), move_opponent_right, update_movement_counters(6).
zrob_krok_w_prawo :- opponents_movement_counter(7), players_movement_counter(2), move_opponent_right, update_movement_counters(7).
zrob_krok_w_prawo :- opponents_movement_counter(8), players_movement_counter(2), move_opponent_right, update_movement_counters(8).
zrob_krok_w_prawo :- opponents_movement_counter(12), players_movement_counter(2), move_opponent_right, update_movement_counters(12).
zrob_krok_w_prawo :- opponents_movement_counter(13), players_movement_counter(2), move_opponent_right, update_movement_counters(13).
zrob_krok_w_prawo :- opponents_movement_counter(14), players_movement_counter(2), move_opponent_right, update_movement_counters(14).

zrob_krok_w_gore :- opponents_movement_counter(3), players_movement_counter(2), move_opponent_up, update_movement_counters(3).
zrob_krok_w_gore :- opponents_movement_counter(4), players_movement_counter(2), move_opponent_up, update_movement_counters(4).
zrob_krok_w_gore :- opponents_movement_counter(5), players_movement_counter(2), move_opponent_up, update_movement_counters(5).
zrob_krok_w_gore :- opponents_movement_counter(27), players_movement_counter(2), move_opponent_up, update_movement_counters(27).
zrob_krok_w_gore :- opponents_movement_counter(28), players_movement_counter(2), move_opponent_up, update_movement_counters(28).
zrob_krok_w_gore :- opponents_movement_counter(29), players_movement_counter(2), move_opponent_up, update_movement_counters(29).
zrob_krok_w_gore :- opponents_movement_counter(33), players_movement_counter(2), move_opponent_up, update_movement_counters(33).
zrob_krok_w_gore :- opponents_movement_counter(34), players_movement_counter(2), move_opponent_up, update_movement_counters(34).
zrob_krok_w_gore :- opponents_movement_counter(35), players_movement_counter(2), move_opponent_up, update_movement_counters(35).

zrob_krok_w_dol :- opponents_movement_counter(9), players_movement_counter(2), move_opponent_down, update_movement_counters(9).
zrob_krok_w_dol :- opponents_movement_counter(10), players_movement_counter(2), move_opponent_down, update_movement_counters(10).
zrob_krok_w_dol :- opponents_movement_counter(11), players_movement_counter(2), move_opponent_down, update_movement_counters(11).
zrob_krok_w_dol :- opponents_movement_counter(15), players_movement_counter(2), move_opponent_down, update_movement_counters(15).
zrob_krok_w_dol :- opponents_movement_counter(16), players_movement_counter(2), move_opponent_down, update_movement_counters(16).
zrob_krok_w_dol :- opponents_movement_counter(17), players_movement_counter(2), move_opponent_down, update_movement_counters(17).
zrob_krok_w_dol :- opponents_movement_counter(21), players_movement_counter(2), move_opponent_down, update_movement_counters(21).
zrob_krok_w_dol :- opponents_movement_counter(22), players_movement_counter(2), move_opponent_down, update_movement_counters(22).
zrob_krok_w_dol :- opponents_movement_counter(23), players_movement_counter(2), move_opponent_down, update_movement_counters(23).

zrob_krok_w_lewo :- opponents_movement_counter(18), players_movement_counter(2), move_opponent_left, update_movement_counters(18).
zrob_krok_w_lewo :- opponents_movement_counter(19), players_movement_counter(2), move_opponent_left, update_movement_counters(19).
zrob_krok_w_lewo :- opponents_movement_counter(20), players_movement_counter(2), move_opponent_left, update_movement_counters(20).
zrob_krok_w_lewo :- opponents_movement_counter(24), players_movement_counter(2), move_opponent_left, update_movement_counters(24).
zrob_krok_w_lewo :- opponents_movement_counter(25), players_movement_counter(2), move_opponent_left, update_movement_counters(25).
zrob_krok_w_lewo :- opponents_movement_counter(26), players_movement_counter(2), move_opponent_left, update_movement_counters(26).
zrob_krok_w_lewo :- opponents_movement_counter(30), players_movement_counter(2), move_opponent_left, update_movement_counters(30).
zrob_krok_w_lewo :- opponents_movement_counter(31), players_movement_counter(2), move_opponent_left, update_movement_counters(31).
zrob_krok_w_lewo :- opponents_movement_counter(32), players_movement_counter(2), move_opponent_left, update_movement_counters(32).


% usuniecie z bazy wiedzy potencjalnego poprzedniego kierunku patrzenia (konieczne, gdy nastąpiła zmiana kierunku chodu):
remove_looking_directions :- retractall(opponent_patrzy_w_lewo), retractall(opponent_patrzy_w_prawo), retractall(opponent_patrzy_w_gore), retractall(opponent_patrzy_w_dol).
% todo: ładniej to zrobić z tym asserta(opponent_looks(direction)).

% update movement counters mod 36 - reaching 36 means that the opponent walked the full circle
update_movement_counters(OldValue) :- NewValue is OldValue + 1, NewValue == 36, retract(opponents_movement_counter(OldValue)), asserta(opponents_movement_counter(0)), update_players_movement_counter.
update_movement_counters(OldValue) :- NewValue is OldValue + 1, NewValue \= 36, retract(opponents_movement_counter(OldValue)), asserta(opponents_movement_counter(NewValue)), update_players_movement_counter.

% move opponent by one field in specified direction
% patrzenie w tę samą stronę, w którą odbywają się kroki
move_opponent_right :- position(opponent, X, Y), NewX is X + 1, step_opponent(NewX, Y), remove_looking_directions, asserta(opponent_patrzy_w_prawo).
move_opponent_left :- position(opponent, X, Y), NewX is X - 1, step_opponent(NewX, Y), remove_looking_directions, asserta(opponent_patrzy_w_lewo).
move_opponent_up :- position(opponent, X, Y), NewY is Y + 1, step_opponent(X, NewY), remove_looking_directions, asserta(opponent_patrzy_w_gore).
move_opponent_down :- position(opponent, X, Y), NewY is Y - 1, step_opponent(X, NewY), remove_looking_directions, asserta(opponent_patrzy_w_dol).