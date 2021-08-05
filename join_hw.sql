--1. List all customers who live in Texas (use JOINs)
SELECT *
FROM customer
-- country_id
SELECT *
FROM city
-- country_id

SELECT first_name, last_name, district
FROM customer
LEFT JOIN address
ON customer.address_id=address.address_id
WHERE district = 'Texas'
-------------------------------------------
--2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM customer
LEFT JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
--------------------------------------------
--3. Show all customers names who have made payments over $175(use subqueries)
SELECT customer_id, first_name, last_name, email
FROM customer
WHERE customer_id IN (
	SELECT customer_id  -- INNER QUERY
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
);
-------------------------------------------------
--4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country
FROM city
INNER JOIN country
ON city.country_id = country.country_id
INNER JOIN address
ON address.city_id = city.city_id
INNER JOIN customer
ON customer.address_id = address.address_id
WHERE country LIKE 'Nepal'
---------------------------------------------
--5. Which staff member had the most transactions?

SELECT staff.staff_id, first_name, last_name, COUNT(payment.staff_id) AS number_of_transactions
FROM staff
JOIN payment USING (staff_id)
GROUP BY staff.staff_id
ORDER BY COUNT(payment.staff_id) DESC;

--jon

----------------------------------
--6. What film had the most actors in it?
SELECT title, COUNT(film_actor.film_id) AS number_of_actors
FROM film
JOIN film_actor USING (film_id)
JOIN actor USING(actor_id)

GROUP BY film.title
ORDER BY COUNT(film_actor.film_id) DESC;
-- Lambs cincinatti

-----------------------------------
--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
);
--------------------------------------
--8.Which category is most prevalent in the films?
SELECT category.name, COUNT(film_category.category_id)
FROM category
JOIN film_category USING(category_id)
JOIN film USING (film_id)
GROUP BY category.name
ORDER BY COUNT(film_category.category_id) DESC;
--sports