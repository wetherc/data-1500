# SQL Fundamentals

This lab will review the `WHERE`, `JOIN`, `GROUP BY`, and `HAVING` SQL keywords.

------

## Lab Exercise

After connecting to our database, let's work through the following examples.

### Customer Rental and Spending Habits

Write a query that selects:

  - Customer name, email, and address;
  - The total count of movies rented;
  - The count of unique movies rented; and
  - The total amount paid for all rentals.

This query will select from the `customers` table, and will join to the `address`, `city`, `rental`, `inventory` and `payment` tables.

You should use a `GROUP BY` clause to aggregate your query results by customer name, email, and address.

You can use the syntax `COUNT(DISTINCT <column>)` to see the number of unique elements that appear.


### The `HAVING` clause

Using the query that you created for the previous example, filter down to only customers who have spent at least $200 on movie rentals. The `HAVING` clause is similar to the `WHERE` clause in that both are used for subsetting data.

The syntax for a `HAVING` clause looks like

```sql
SELECT <columns>
FROM <table>
GROUP BY <column(s)>
HAVING COUNT(<column>) > <value>
```

When we're thinking about the `WHERE` clause versus the `HAVING` clause, the `WHERE` clause introduces a condition on individual rows; the `HAVING` clause introduces a condition on aggregations. I.e., `HAVING` operates on the results of a selection where a single aggregation (`COUNT`, `AVERAGE`, `SUM`, etc.), has been produced from multiple rows.


### Film Language Preferences

Write a query that selects:

  - Each distinct language that films have been made available in;
  - The count of film titles released in that language;
  - The count of stores that stock one or more films in that language; and
  - The count of movies rented in that language.


### `INNER JOIN`s

Write a query that selects:
  - Customer first and last name;
  - Staff first and last name;
  - Payment amount; and
  - Movie title

for each rental. Use an `INNER JOIN` to join the `staff` and `rental` tables, and to join the `customer` and `rental` tables.


### `CASE` Statements

A `CASE` statement is a way to conditionally choose a value in SQL. It takes the format

```sql
SELECT
  CASE
    WHEN <column> = <criteria> THEN <result>
    ELSE <default>
  END
```

For example, if we wanted to create a new column indicating customers who rent a large quantity of films, we could use a query like:

```sql
SELECT
  c.first_name || ' ' || c.last_name AS customer_name
  CASE
    WHEN COUNT(r.rental_id) > 10 THEN 'frequent customer'
    ELSE 'infrequent customer'
  END AS customer_type
FROM customer c
JOIN rental r
  ON c.customer_id = r.customer_id
GROUP BY c.first_name || ' ' || c.last_name
```

Write a query that selects:

  - Each film title;
  - Its genre;
  - The store(s) it's available to rent from;
  - The number of times it has been rented from that store; and
  - An `is_popular` flag using a `CASE` statement where the value is `TRUE` if the movie has been rented more than 5 times and is `FALSE` otherwise
