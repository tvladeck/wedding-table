
This prolog program solves the classic wedding table problem, where you have people that you want to sit next at the same table, and people that you want to make sure sit at different tables, given a certain number of tables each with a certain number of seats.

The entry point is `arrangment/4`, whose arguments are:
  - The list of lists of who is sitting at which table (this will be left specified as logic variables)
  - The list of number of seats at each table, e.g. `[3,3]` for two tables each with three seats
  - A list of pairwise pairings, e.g. `[[Trevor, Tom], [Ellen, Sarah], [Trevor, Gabby]]` which constrains that Trevor, Tom, and Gabby sit at the same table, and Ellen and Sarah sit at the same table
  - A lis of pairwise exclusions, e.g. `[[Ellen, Tom], [Sarah, Trevor]]`, which constrains that Ellen & Tom will sit at different tables and Sarah and Trevor will sit at different tables


The way to run the program is to call `arrangement/4` with like so

```
?- consult('table.pl').
?- arrangment([X,Y], [3,3], [[a,b], [c,d]], [[a,c]]).
X = [a, b, a],
Y = [c, d, c]
% variables may be duplicated within the same table if there is space
```

This trivial example finds two tables X and Y such that:

- They both have 3 seats
- `a` and `b` sit at the same table
- `c` and `d` sit at the same table
- `a` and `c` sit at different tables

Impossible arrangements will fail:

```
?- consult('table.pl').
?- arrangment([X,Y], [3,3], [[a,b], [c,d]], [[a,b]]).
false.
```


