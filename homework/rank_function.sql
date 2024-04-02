-- Which staff member has had the most rentals per store?

with store_rentals AS (
	SELECT
		s.first_name || ' ' || s.last_name AS staff_name,
		to_char(r.rental_date, 'YYYY-MM') AS rental_month,
		COUNT(r.rental_id) AS rental_count,
		RANK() OVER (
			PARTITION BY to_char(r.rental_date, 'YYYY-MM')
			ORDER BY COUNT(r.rental_id) DESC
		) AS idx
	FROM rental r
	JOIN staff s
	  ON r.staff_id = s.staff_id
	JOIN inventory i
	  ON r.inventory_id = i.inventory_id
	GROUP BY
		staff_name,
		rental_month
)

SELECT
	staff_name,
	rental_month,
	rental_count
FROM store_rentals
WHERE idx = 1
