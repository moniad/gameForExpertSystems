%=================== ruchy playera ===============
:- dynamic position/3.
:- dynamic players_movement_counter/1.
:- dynamic crawls/1.
position(player, 0, 0).
position(opponent, 8, 8).
players_movement_counter(0).

%# move_player_to_the_left/right/etc., make_crawl i make_stand to eventy z poziomu Pythona
move_player_to_the_left :- position(player, X, Y), S is X - 1, step_player(S, Y).
move_player_to_the_right :- position(player, X, Y), S is X + 1, step_player(S, Y).
move_player_up :- position(player, X, Y), S is Y + 1, step_player(X, S).
move_player_down :- position(player, X, Y), S is Y - 1, step_player(X, S).

step_player(X, Y) :- field_on_board(X, Y), retract(position(player, _, _)), asserta(position(player, X, Y)), update_players_movement_counter.
step_opponent(X, Y) :- field_on_board(X, Y), retract(position(opponent, _, _)), asserta(position(opponent, X, Y)).
field_on_board(X, Y) :- X >= 0, X < 30, Y >= 0, Y < 30.

make_crawl :- asserta(crawls(player)).
make_stand :- retract(crawls(player)).

%# update flagi dla kolejnego kroku w obchodzie przeciwnika - uwzględnia pierwszy ruch gracza przed ruchem przeciwnika
update_players_movement_counter :- players_movement_counter(0), retract(players_movement_counter(0)), asserta(players_movement_counter(1)).
% synchro with opponent's movement
update_players_movement_counter :- players_movement_counter(1), move_opponent, retract(players_movement_counter(1)), asserta(players_movement_counter(0)).