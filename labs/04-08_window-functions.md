# Window Function

A window function generically is a way to perform an operation over a set of data, optionally with ordering and/or grouping constraints applied.

The syntax for a window function ooks like

```sql
window_function(arg1, arg2,..) OVER (
   [PARTITION BY partition_expression]
   [ORDER BY sort_expression [ASC | DESC] [NULLS {FIRST | LAST }])  
```

In this syntax,

### `PARTITION BY` clause

The `PARTITION BY` groups rows by one or more columns, with the window function being applied separately over each group. For example, we might `PARTITION BY year` to apply a window function to each separate year in our dataset.

This clause is optional. If it is omitted, the window function will be run over the entire result set.


### `ORDER BY` clause

The `ORDER BY` clause defines how rows within each partition should be ordered prior to the window function being applied.

-----

## Exercise 01: `RANK`

Write a query that returns the popularity of each film genre by:
  - number of rentals; and (separately)
  - number of films in the genre

This should use two different `RANK` functions, one for popularity by number of films, and one for popularity by number of rentals. 

## Exercise 02: `ROW_NUMBER`

Write a query that returns the name, length, and rating of the 3rd and 7th film that each customer has rented. Why? Why not!

## Exercise 03: `PERCENT_RANK`

Using the query from [Exercise 01](#exercise-01) as your starting point, what is the percentile rank of each movie's popularity by its number of rentals?

The `PERCENT_RANK` function will evaluate the relative standing of each result relative to the total result set.

## Exercise 04: `LAG`

Write a query that,
  - for each store,
  - for each year,
  - for each month
returns the number of rentals and the revenue generated from rentals in that month, as well as the number of rentals and their revenue from the prior month.
