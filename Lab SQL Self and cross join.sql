-- Lab | SQL Self and cross join

USE sakila;

-- Get all pairs of actors that worked together.
-- (in the same movie)
SELECT 
    fa1.film_id,
    a1.first_name,
    a1.last_name,
    fa1.actor_id AS first_actor_id,
    a2.first_name,
    a2.last_name,
    fa2.actor_id AS second_actor_id
FROM
    film_actor fa1
        JOIN
    film_actor fa2 ON fa1.film_id = fa2.film_id
        AND fa1.actor_id <> fa2.actor_id
        JOIN
    actor a1 ON a1.actor_id = fa1.actor_id
        JOIN
    actor a2 ON a2.actor_id = fa2.actor_id
ORDER BY a1.actor_id;

-- Get all pairs of customers that have rented the same film more than 3 times
-- (inventory_id)
SELECT 
    title,
    r1.customer_id,
    r2.customer_id,
    COUNT(DISTINCT r1.inventory_id) AS rentals
FROM
    inventory i
        JOIN
    film f ON f.film_id = i.film_id
        JOIN
    rental r1 ON r1.inventory_id = i.inventory_id
        JOIN
    rental r2 ON r1.inventory_id = r2.inventory_id
        AND r1.customer_id < r2.customer_id
GROUP BY r1.customer_id , r2.customer_id
HAVING rentals > 3;

-- Get all possible pairs of actors and films.
SELECT 
    *
FROM
    (SELECT DISTINCT
        first_name, last_name
    FROM
        actor) sub1
        CROSS JOIN
    (SELECT 
        title
    FROM
        film) sub2;