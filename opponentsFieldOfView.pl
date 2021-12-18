is_in_the_field_of_view(player, opponent) :- in_the_11x11_rectangle_around(player, opponent), opponent_looks_in_the_players_direction(player, opponent).

in_the_11x11_rectangle_around(player, opponent) :- position(opponent, OX, OY), position(player, PX, PY), X_DIFF is PX - OX, DIST_X is abs(X_DIFF), DIST_X =< 5, Y_DIFF is PY - OY, DIST_Y is abs(Y_DIFF), DIST_Y =< 5.

opponent_looks_in_the_players_direction(player, opponent) :- opponent_looks(left), is_on_the_left(player, opponent), is_ox_minus_px_greater_than_abs_y_diff(player, opponent).
opponent_looks_in_the_players_direction(player, opponent) :- opponent_looks(right), is_on_the_right(player, opponent), is_px_minus_ox_greater_than_abs_y_diff(player, opponent).
opponent_looks_in_the_players_direction(player, opponent) :- opponent_looks(up), is_above(player, opponent), is_py_minus_oy_greater_than_abs_x_diff(player, opponent).
opponent_looks_in_the_players_direction(player, opponent) :- opponent_looks(down), is_below(player, opponent), is_oy_minus_py_greater_than_abs_x_diff(player, opponent).

is_ox_minus_px_greater_than_abs_y_diff(player, opponent) :- position(opponent, OX, OY), position(player, PX, PY), X_DIFF is OX - PX, Y_DIFF is PY - OY, DIST_Y is abs(Y_DIFF), X_DIFF > DIST_Y.
is_px_minus_ox_greater_than_abs_y_diff(player, opponent) :- position(opponent, OX, OY), position(player, PX, PY), X_DIFF is PX - OX, Y_DIFF is PY - OY, DIST_Y is abs(Y_DIFF), X_DIFF > DIST_Y.
is_py_minus_oy_greater_than_abs_x_diff(player, opponent) :- position(opponent, OX, OY), position(player, PX, PY), X_DIFF is PX - OX, DIST_X is abs(X_DIFF), Y_DIFF is PY - OY, Y_DIFF > DIST_X.
is_oy_minus_py_greater_than_abs_x_diff(player, opponent) :- position(opponent, OX, OY), position(player, PX, PY), X_DIFF is PX - OX, DIST_X is abs(X_DIFF), Y_DIFF is OY - PY, Y_DIFF > DIST_X.

is_on_the_left(player, opponent) :- position(opponent, OX, _), position(player, PX, _), OX - PX > 0.
is_on_the_right(player, opponent) :- position(opponent, OX, _), position(player, PX, _), PX - OX > 0.
is_above(player, opponent) :- position(opponent, _, OY), position(player, _, PY), PY - OY > 0.
is_below(player, opponent) :- position(opponent, _, OY), position(player, _, PY), OY - PY > 0.