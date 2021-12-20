%=================== ruchy opponenta ===============
:- dynamic opponent_looks/1, opponents_movement_counter/1.

% przeciwnik patrzy w prawo na początku, bo tak xd
opponent_looks(right).
opponents_movement_counter(0).

move_opponent :- calm(opponent), make_a_circuit_step_in_calm_state.
move_opponent :- disturbed(opponent), make_a_move_in_disturbed_state.

% #################### MOVE IN DISTURBED STATE ####################
make_a_move_in_disturbed_state :- x_diff_greater_than_or_eq_y_diff, is_on_the_left(player, opponent), move_opponent_left, update_movement_counter_in_disturbed_state(18).
make_a_move_in_disturbed_state :- x_diff_greater_than_or_eq_y_diff, is_on_the_right(player, opponent), move_opponent_right, update_movement_counter_in_disturbed_state(0).
make_a_move_in_disturbed_state :- y_diff_greater_than_x_diff, is_above(player, opponent), move_opponent_up, update_movement_counter_in_disturbed_state(3).
make_a_move_in_disturbed_state :- y_diff_greater_than_x_diff, is_below(player, opponent), move_opponent_down, update_movement_counter_in_disturbed_state(9).

x_diff_greater_than_or_eq_y_diff :- position(player, PX, PY), position(opponent, OX, OY), X_DIFF is abs(PX - OX), Y_DIFF is abs(PY - OY), X_DIFF >= Y_DIFF.
y_diff_greater_than_x_diff :- position(player, PX, PY), position(opponent, OX, OY), X_DIFF is abs(PX - OX), Y_DIFF is abs(PY - OY), Y_DIFF > X_DIFF.

% #################### CIRCUIT ####################
make_a_circuit_step_in_calm_state :- try_to_move_opponent_one_field_to_the_right.
make_a_circuit_step_in_calm_state :- try_to_move_opponent_one_field_to_the_left.
make_a_circuit_step_in_calm_state :- try_to_move_opponent_one_field_up.
make_a_circuit_step_in_calm_state :- try_to_move_opponent_one_field_down.
%make_a_circuit_step_in_calm_state :- opponents_movement_counter(OldValue), skip_3_steps(OldValue). % if opponent hits the wall, skip 3 steps and move them in a different direction

% obchod zaczyna sie od 3 krokow w prawo, a potem w gore
try_to_move_opponent_one_field_to_the_right :- opponents_movement_counter(0), players_movement_counter(1), move_opponent_right, update_movement_counters(0).
try_to_move_opponent_one_field_to_the_right :- opponents_movement_counter(1), players_movement_counter(1), move_opponent_right, update_movement_counters(1).
try_to_move_opponent_one_field_to_the_right :- opponents_movement_counter(2), players_movement_counter(1), move_opponent_right, update_movement_counters(2).
try_to_move_opponent_one_field_to_the_right :- opponents_movement_counter(6), players_movement_counter(1), move_opponent_right, update_movement_counters(6).
try_to_move_opponent_one_field_to_the_right :- opponents_movement_counter(7), players_movement_counter(1), move_opponent_right, update_movement_counters(7).
try_to_move_opponent_one_field_to_the_right :- opponents_movement_counter(8), players_movement_counter(1), move_opponent_right, update_movement_counters(8).
try_to_move_opponent_one_field_to_the_right :- opponents_movement_counter(12), players_movement_counter(1), move_opponent_right, update_movement_counters(12).
try_to_move_opponent_one_field_to_the_right :- opponents_movement_counter(13), players_movement_counter(1), move_opponent_right, update_movement_counters(13).
try_to_move_opponent_one_field_to_the_right :- opponents_movement_counter(14), players_movement_counter(1), move_opponent_right, update_movement_counters(14).

try_to_move_opponent_one_field_up :- opponents_movement_counter(3), players_movement_counter(1), move_opponent_up, update_movement_counters(3).
try_to_move_opponent_one_field_up :- opponents_movement_counter(4), players_movement_counter(1), move_opponent_up, update_movement_counters(4).
try_to_move_opponent_one_field_up :- opponents_movement_counter(5), players_movement_counter(1), move_opponent_up, update_movement_counters(5).
try_to_move_opponent_one_field_up :- opponents_movement_counter(27), players_movement_counter(1), move_opponent_up, update_movement_counters(27).
try_to_move_opponent_one_field_up :- opponents_movement_counter(28), players_movement_counter(1), move_opponent_up, update_movement_counters(28).
try_to_move_opponent_one_field_up :- opponents_movement_counter(29), players_movement_counter(1), move_opponent_up, update_movement_counters(29).
try_to_move_opponent_one_field_up :- opponents_movement_counter(33), players_movement_counter(1), move_opponent_up, update_movement_counters(33).
try_to_move_opponent_one_field_up :- opponents_movement_counter(34), players_movement_counter(1), move_opponent_up, update_movement_counters(34).
try_to_move_opponent_one_field_up :- opponents_movement_counter(35), players_movement_counter(1), move_opponent_up, update_movement_counters(35).

try_to_move_opponent_one_field_down :- opponents_movement_counter(9), players_movement_counter(1), move_opponent_down, update_movement_counters(9).
try_to_move_opponent_one_field_down :- opponents_movement_counter(10), players_movement_counter(1), move_opponent_down, update_movement_counters(10).
try_to_move_opponent_one_field_down :- opponents_movement_counter(11), players_movement_counter(1), move_opponent_down, update_movement_counters(11).
try_to_move_opponent_one_field_down :- opponents_movement_counter(15), players_movement_counter(1), move_opponent_down, update_movement_counters(15).
try_to_move_opponent_one_field_down :- opponents_movement_counter(16), players_movement_counter(1), move_opponent_down, update_movement_counters(16).
try_to_move_opponent_one_field_down :- opponents_movement_counter(17), players_movement_counter(1), move_opponent_down, update_movement_counters(17).
try_to_move_opponent_one_field_down :- opponents_movement_counter(21), players_movement_counter(1), move_opponent_down, update_movement_counters(21).
try_to_move_opponent_one_field_down :- opponents_movement_counter(22), players_movement_counter(1), move_opponent_down, update_movement_counters(22).
try_to_move_opponent_one_field_down :- opponents_movement_counter(23), players_movement_counter(1), move_opponent_down, update_movement_counters(23).

try_to_move_opponent_one_field_to_the_left :- opponents_movement_counter(18), players_movement_counter(1), move_opponent_left, update_movement_counters(18).
try_to_move_opponent_one_field_to_the_left :- opponents_movement_counter(19), players_movement_counter(1), move_opponent_left, update_movement_counters(19).
try_to_move_opponent_one_field_to_the_left :- opponents_movement_counter(20), players_movement_counter(1), move_opponent_left, update_movement_counters(20).
try_to_move_opponent_one_field_to_the_left :- opponents_movement_counter(24), players_movement_counter(1), move_opponent_left, update_movement_counters(24).
try_to_move_opponent_one_field_to_the_left :- opponents_movement_counter(25), players_movement_counter(1), move_opponent_left, update_movement_counters(25).
try_to_move_opponent_one_field_to_the_left :- opponents_movement_counter(26), players_movement_counter(1), move_opponent_left, update_movement_counters(26).
try_to_move_opponent_one_field_to_the_left :- opponents_movement_counter(30), players_movement_counter(1), move_opponent_left, update_movement_counters(30).
try_to_move_opponent_one_field_to_the_left :- opponents_movement_counter(31), players_movement_counter(1), move_opponent_left, update_movement_counters(31).
try_to_move_opponent_one_field_to_the_left :- opponents_movement_counter(32), players_movement_counter(1), move_opponent_left, update_movement_counters(32).


% usuniecie z bazy wiedzy potencjalnego poprzedniego kierunku patrzenia (konieczne, gdy nastąpiła zmiana kierunku chodu):
remove_looking_directions :- retractall(opponent_looks(_)).

% update movement counters mod 36 - reaching 36 means that the opponent walked the full circle
update_movement_counters(OldValue) :- NewValue is OldValue + 1, NewValue == 36, retract(opponents_movement_counter(OldValue)), asserta(opponents_movement_counter(0)).
update_movement_counters(OldValue) :- NewValue is OldValue + 1, NewValue \= 36, retract(opponents_movement_counter(OldValue)), asserta(opponents_movement_counter(NewValue)).

% opponent hit the wall, so skipping the move in the direction in which it was impossible to move (by incrementing the counter by 3)
skip_3_steps(OldValue) :- NewValue is OldValue + 3, NewValue >= 36, NewValue is NewValue - 36, retract(opponents_movement_counter(OldValue)), asserta(opponents_movement_counter(NewValue)).
skip_3_steps(OldValue) :- NewValue is OldValue + 3, retract(opponents_movement_counter(OldValue)), asserta(opponents_movement_counter(NewValue)).

% counter update in disturbed state
update_movement_counter_in_disturbed_state(NewValue) :- retractall(opponents_movement_counter(_)), asserta(opponents_movement_counter(NewValue)).

% move opponent by one field in specified direction and make them look in this direction
move_opponent_right :- position(opponent, X, Y), NewX is X + 1, step_opponent(NewX, Y), remove_looking_directions, asserta(opponent_looks(right)).
move_opponent_left :- position(opponent, X, Y), NewX is X - 1, step_opponent(NewX, Y), remove_looking_directions, asserta(opponent_looks(left)).
move_opponent_up :- position(opponent, X, Y), NewY is Y + 1, step_opponent(X, NewY), remove_looking_directions, asserta(opponent_looks(up)).
move_opponent_down :- position(opponent, X, Y), NewY is Y - 1, step_opponent(X, NewY), remove_looking_directions, asserta(opponent_looks(down)).