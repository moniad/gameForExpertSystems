%=================== ruchy playera ===============
:- dynamic position/3, players_movement_counter/1, players_crawling_counter/1, crawls/1, crawling_forbidden/1.

position(player, 0, 0).
position(opponent, 8, 8).
players_movement_counter(0).
players_crawling_counter(0).
crawling_forbidden(0).

% move_player_left/right/etc., make_crawl i make_stand to eventy z poziomu Pythona
% clauses for crawling and non-crawling
move_player_left :- not(crawls(player)), position(player, X, Y), S is X - 1, step_player_and_allow_crawling(S, Y).
move_player_left :- handle_crawling(player), position(player, X, Y), S is X - 1, step_player(S, Y).

move_player_right :- not(crawls(player)), position(player, X, Y), S is X + 1, step_player_and_allow_crawling(S, Y).
move_player_right :- handle_crawling(player), position(player, X, Y), S is X + 1, step_player(S, Y).

move_player_up :- not(crawls(player)), position(player, X, Y), S is Y + 1, step_player_and_allow_crawling(X, S).
move_player_up :- handle_crawling(player), position(player, X, Y), S is Y + 1, step_player(X, S).

move_player_down :- not(crawls(player)), position(player, X, Y), S is Y - 1, step_player_and_allow_crawling(X, S).
move_player_down :- handle_crawling(player), position(player, X, Y), S is Y - 1, step_player(X, S).

handle_crawling(player) :- crawls(player), crawling_forbidden(0), players_crawling_counter(OldValue), update_crawling_counter(OldValue).

step_player_and_allow_crawling(X, Y) :- step_player(X, Y), make_crawling_allowed.
step_player(X, Y) :- field_on_board(X, Y), retract(position(player, _, _)), asserta(position(player, X, Y)), update_players_movement_counter.
step_opponent(X, Y) :- field_on_board(X, Y), retract(position(opponent, _, _)), asserta(position(opponent, X, Y)).
field_on_board(X, Y) :- X >= 0, X < 30, Y >= 0, Y < 30.

make_crawl :- crawling_forbidden(0), asserta(crawls(player)).
make_stand :- retract(crawls(player)), reset_crawling_counter.
reset_crawling_counter :- retractall(players_crawling_counter(_)), asserta(players_crawling_counter(0)).

%# update flagi dla kolejnego kroku w obchodzie przeciwnika - uwzględnia pierwszy ruch gracza przed ruchem przeciwnika
update_players_movement_counter :- game_over, retractall(players_movement_counter(_)). % prevents opponent from making next move in case player wins
update_players_movement_counter :- players_movement_counter(0), retract(players_movement_counter(0)), asserta(players_movement_counter(1)).
% synchro with opponent's movement
update_players_movement_counter :- players_movement_counter(1), move_opponent, retract(players_movement_counter(1)), asserta(players_movement_counter(0)).

make_crawling_allowed :- retractall(crawling_forbidden(_)), asserta(crawling_forbidden(0)).
make_crawling_forbidden :- retractall(crawling_forbidden(_)), asserta(crawling_forbidden(1)).

% making crawling forbidden for 1 move after 5 crawling steps
update_crawling_counter(OldValue) :- NewValue is OldValue + 1, NewValue == 5, retract(players_crawling_counter(OldValue)), asserta(players_crawling_counter(0)), make_crawling_forbidden.
update_crawling_counter(OldValue) :- NewValue is OldValue + 1, retract(players_crawling_counter(OldValue)), asserta(players_crawling_counter(NewValue)).

distance(player, opponent, DIST) :- position(player, PX, PY), position(opponent, OX, OY), DIST is max(abs(PX - OX), abs(PY - OY)).