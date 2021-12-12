%=================== stany przeciwnika ===============
calm(opponent).

calm(opponent) :- distance(player, opponent, DIST), DIST >= 1, DIST =< 7, crawls(player).
calm(opponent) :- distance(player, opponent, DIST), DIST >= 7.

disturbed(opponent) :- distance(player, opponent, DIST), DIST >= 1, DIST =< 7, not(crawls(player)).
distance(A, B, C) :- position(A, X, Y), position(B, Z, W), C is min(abs(X-Z), abs(Y-W)).