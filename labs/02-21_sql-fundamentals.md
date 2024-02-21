# SQL Fundamentals

This lab will review the `SELECT`, `AS`, `FROM`, `WHERE`, `JOIN`, and `ORDER BY` SQL keywords.

## Connecting to the `dvdrental` database

To create our lab database, open up a new Terminal window in Codio and run:

```bash
$ ./data-1500/bin/storage upgrade dvdrentals
```

Once this completes, you can connect with

```bash
$ psql -d dvdrental
```

## Common Commands

  - `\l` — List all databases
  - `\c <database>` — Connect to a specific database
  - `\dt` — List all tables
  - `\d` — Describe all tables
  - `\?` — List all psql commands
  - `\q` — Exit the psql shell

------

## Lab Exercise

After connecting to our database, let's work through the following examples.

### Rental Stores and their Managers

Write a query that returns:

  - The street address, city, and phone number of each store; and
  - The store manager's first name and last name

This will use the `store` table and will join to the `address`, `city`, and `staff` tables


### WHERE clauses

Write a query that returns:

  - The customer's first and last name;
  - The name of the film; and
  - The rental date and the return date

for films rented by any customer whose last name starts with the letters `Ro`. Order the results by customer first name (alphabetized), and then by rental date from oldest to newest.

This will use the `customer` table and will join to the `rental`, `inventory`, and `film` tables.


### Movie Genre Preferences

Write a query that returns the distinct movie categories for all DVDs rented by the customer with first name `Terrance` and last name `Roush`.

This will use the `customer` table and will join to the `rental`, `inventory`, `film`, `film_category`, and `category` tables.


### Actor Typecasting

Write a query that returns:

  - the first and last name of each actor who has starred in a film in the `Action` category;
  - the name of the movie(s) they starred in; and
  - the length of each movie.

This will use the `actor` table and will join to the `film_actor`, `film`, `film_category`, and `category` tables.
