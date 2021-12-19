%=================== stany przeciwnika ===============

% TODO: determine which distance is best - I think if we assume maximum crawling counter value is 5, then distance value should be 3
calm(opponent) :- distance(player, opponent, DIST), DIST >= 1, DIST =< 3, crawls(player).
calm(opponent) :- distance(player, opponent, DIST), DIST > 3.

disturbed(opponent) :- distance(player, opponent, DIST), DIST >= 1, DIST =< 3, not(crawls(player)).