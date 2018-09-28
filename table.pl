


at_this_table(Person1, Person2, ThisTable) :-
    member(Person1, ThisTable),
    member(Person2, ThisTable).

at_same_table(Person1, Person2, AllTables) :-
    member(ThisTable, AllTables),
    at_this_table(Person1, Person2, ThisTable).

pair_at_same_table(Pair, AllTables) :-
    nth1(1, Pair, Person1),
    nth1(2, Pair, Person2),
    at_same_table(Person1, Person2, AllTables).

at_different_tables(Person1, Person2, AllTables) :-
    member(Table1, AllTables),
    member(Table2, AllTables),
    member(Person1, Table1),
    member(Person2, Table2),
    intersection(Table1, Table2, []).


pair_at_different_tables([], _) :- !.

pair_at_different_tables(Pair, AllTables) :-
    nth1(1, Pair, Person1),
    nth1(2, Pair, Person2),
    at_different_tables(Person1, Person2, AllTables).

assign_length(X, Ts, Ls) :- 
    nth1(X, Ts, T),
    nth1(X, Ls, L),
    length(T, L).

ground_member(X, Y) :-
    member(X, Y),
    ground(X).

ground_members_of_table(Table, GroundTable) :-
    findall(X, ground_member(X, Table), GroundTable).

not_ground_member_of_table(Person, AnotherTable) :-
    ground_members_of_table(AnotherTable, GroundTable),
    \+ member(Person, GroundTable).

only_at_one_table(Person, AllTables) :-
    member(Table1, AllTables),
    member(Person, Table1),
    subtract(AllTables, [Table1], OtherTables),
    foreach(member(AnotherTable, OtherTables), not_ground_member_of_table(Person, AnotherTable)).


arrangement(Tables, Lengths, Pairs, Exclusions) :-
    length(Tables, Y),
    length(Lengths, Y),
    foreach(between(1, Y, X), assign_length(X, Tables, Lengths)),
    foreach(member(Pair, Pairs), pair_at_same_table(Pair, Tables)),
    foreach(member(Excl, Exclusions), pair_at_different_tables(Excl, Tables)),
    flatten(Pairs, AllPeople),
    foreach(member(Person, AllPeople), only_at_one_table(Person, Tables)).

