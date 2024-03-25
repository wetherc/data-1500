-- Creates a CTE called weekly_rentals which selects:
-- The COUNT() of movies rented each week;
-- The COUNT() of movies returned each week;
-- The store id that the movie was rented from;
-- The calendar week (HINT: you can use DATE_PART('week', rental_date) AS rental_week)

WITH moviesRented AS (
  SELECT
    COUNT(r.rental_id) AS movies_rented,
    i.store_id,
    DATE_PART('week', r.rental_date) AS week_number
  FROM rental r
  JOIN inventory i
    ON r.inventory_id = i.inventory_id
    GROUP BY store_id, week_number
), moviesReturned AS (
  SELECT
    COUNT(r.rental_id) AS movies_returned,
    i.store_id,
    DATE_PART('week', r.return_date) AS week_number
  FROM rental r
  JOIN inventory i
    ON r.inventory_id = i.inventory_id
    GROUP BY store_id, week_number
),
store_weekly_rentals AS(
  SELECT
    movies_rented,
    movies_returned,
    COALESCE(r.store_id, r2.store_id) AS store_id,
    COALESCE(r.week_number, r2.week_number) AS week_number
  FROM moviesRented r
  FULL OUTER JOIN moviesReturned r2 USING(week_number)
),
store_revenues AS (
  SELECT
    SUM(p.amount) AS rental_amount,
    DATE_PART('week', r.rental_date) AS week_number,
    i.store_id
  FROM rental r
  JOIN payment p
    ON p.rental_id = r.rental_id
  JOIN inventory i
    ON r.inventory_id = i.inventory_id
  GROUP BY week_number, store_id
)

SELECT
  COALESCE(rev.week_number, rent.week_number) AS week_number,
  COALESCE(rev.store_id, rent.store_id) AS store_id,
  rev.rental_amount,
  rent.movies_rented,
  rent.movies_returned,
  rev.rental_amount / rent.movies_rented AS avg_price_per_movie
FROM store_revenues rev
FULL OUTER JOIN store_weekly_rentals rent
USING (week_number, store_id)
ORDER BY week_number, store_id;
