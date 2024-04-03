WITH actor_movies AS (
	SELECT
		a.first_name || ' ' || a.last_name AS actor_name,
		a.actor_id,
		c.name AS genre,
		f.release_year,
		COUNT(f.film_id) AS movie_count,
		DENSE_RANK() OVER(
			PARTITION BY a.actor_id
			ORDER BY COUNT(f.film_id) DESC
		) AS genre_rank
	FROM actor a
	JOIN film_actor fa
	  ON a.actor_id = fa.actor_id
	JOIN film f
	  ON fa.film_id = f.film_id
	JOIN film_category fc
	  ON f.film_id = fc.film_id
	JOIN category c
	  ON fc.category_id = c.category_id
	GROUP BY
		actor_name, a.actor_id, genre, release_year
),

yearly_movies AS (
	SELECT
		actor_name,
		actor_id,
		release_year,
		SUM(movie_count) AS yearly_movie_count,
		DENSE_RANK() OVER(
			PARTITION BY actor_id
			ORDER BY SUM(movie_count) DESC
		) year_rank
	FROM actor_movies
	GROUP BY actor_name, release_year, actor_id
)

SELECT
	ym.actor_name,
	ym.release_year,
	ym.yearly_movie_count,
	am.genre,
	am.movie_count
FROM yearly_movies ym
JOIN actor_movies am
  ON ym.actor_id = am.actor_id
WHERE ym.year_rank = 1
  AND am.genre_rank = 1
