%=================== stany przeciwnika ===============
calm(opponent).

calm(opponent) :- distance(player, opponent, DIST), DIST >= 1, DIST =< 7, crawls(player).
calm(opponent) :- distance(player, opponent, DIST), DIST > 7.

disturbed(opponent) :- distance(player, opponent, DIST), DIST >= 1, DIST =< 7, not(crawls(player)).
distance(player, opponent, DIST) :- position(player, PX, PY), position(opponent, OX, OY), DIST is max(abs(PX - OX), abs(PY - OY)).