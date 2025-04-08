-- ---------------------------------------------------------
-- SECTION 5: Joins
-- ---------------------------------------------------------

-- OVERVIEW OF JOIN

-- Links for more information:
-- https://blog.codinghorror.com/a-visual-explanation-of-sql-joins/
-- https://www.talend.com/
-- https://en.wikipedia.org/wiki/Join_(SQL)

------ INTRODUCTION TO JOINS ------ 

-- Joins will allow to combine information from multiple tables.

------ AS Statement ------ 
-- AS for creating an ALIAS 

-- Example
SELECT amount AS rental_price -- alias, just for readability
FROM payment; 

SELECT SUM(amount) AS net_revenue 
FROM payment; 

-- The AS operator gets executed at the very end of a query, meaning that we can not use the ALIAS
-- inside a WHERE operator. Let's walk through some examples. 

SELECT COUNT(amount) AS number_transactions
from payment;

-- same 

SELECT COUNT(*) AS number_transactions
from payment;

SELECT customer_id, SUM(amount) AS total_spent
from payment
GROUP BY customer_id;

-- This is the same as the previous example, but we are using an alias.

SELECT customer_id, SUM(amount) AS total_spent
from payment
GROUP BY customer_id
HAVING SUM(amount) > 100; -- Alias can't be used here to filter by

SELECT customer_id, amount
from payment
WHERE amount > 2;

------ INNER JOINS ------ 
-- Innerjoin will result with the set of records that match in both tables. 

SELECT *
FROM payment;

SELECT *
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

--- only certain columns
SELECT 	payment_id, payment.customer_id, first_name
FROM 	payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

------ FULL OUTER JOIN ------ 

-- There are a few different types of OUTER JOINS 
-- They will allow us to specify how to deal with values only present in one of the tables being joined. 
-- These are the most complex JOINS. 

-- Grabs everything 
-- SELECT * FROM TableA
-- FULL OUTER JOIN TableB
-- ON TableAl.col_match = TableB.col_match

SELECT * 
FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id;

-- Additional filter 
-- no customer id's that are unique 

SELECT * 
FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS null
OR payment.payment_id IS null;

SELECT COUNT(DISTINCT customer_id)
FROM payment;

-- same, but doesnt fully answer the question
SELECT COUNT(DISTINCT customer_id) 
FROM customer;

------ LEFT OUTER JOIN ------ 

-- A LEFT OUTER JOIN results in the set of records. that are in the left table, if there is no match with the right table. 
-- The resuls are null. Later we will learn how to add WHERE statements to futher modify a LEFT OUTER JOIN
-- LEFT JOIN and OUTER JOIN are the same

SELECT * 
FROM film;

SELECT * 
FROM inventory;

SELECT film.film_id, title, inventory_id, store_id 
FROM film
LEFT JOIN inventory 
ON inventory.film_id = film.film_id
WHERE inventory.film_id IS NULL;

------ Right Joins ------ 

-- A right JOIN is essentially the same as a LEFT JOIN, except the tables are switched.
-- This would be the same as switching the tableorder in a LEFT OUTER JOIN. 
-- Let's Quickly see some examples of a RIGHT JOIN. 

------ Union ------ 

-- The UNION operator is used to combine the result-set of two or more SELECT statements
-- It basically serves ot directly concatenate two results together, essentially 'pasting' them together.

------ JOIN challenge Tasks ------ 

-- CHALLENGE 1: California sales tax laws have changed and we need to alert our customers through email. 
-- What are the emails of the customers who live in California? 

SELECT address.district, email 
FROM customer
LEFT JOIN address
ON address.address_id = customer.address_id
WHERE district = 'California';

-- Answer
-- "California"	"patricia.johnson@sakilacustomer.org"
-- "California"	"betty.white@sakilacustomer.org"
-- "California"	"alice.stewart@sakilacustomer.org"
-- "California"	"rosa.reynolds@sakilacustomer.org"
-- "California"	"renee.lane@sakilacustomer.org"
-- "California"	"kristin.johnston@sakilacustomer.org"
-- "California"	"cassandra.walters@sakilacustomer.org"
-- "California"	"jacob.lance@sakilacustomer.org"
-- "California"	"rene.mcalister@sakilacustomer.org"

-- Solution was: 

SELECT district, email 
FROM address
INNER JOIN customer 
ON address.address_id = customer.address_id
WHERE district = 'California';


-- Steps was: 
--1 
SELECT *
FROM address
INNER JOIN customer 
ON address.address_id = customer.address_id

--2 
SELECT district, email 
FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
WHERE district = 'California'

-- CHALLENGE 2: A customer walks in and is a huge fan of the actor 'Nick Wahlberg' and wants to know which movies he is in. 
-- Get a list of all the movies 'Nick Wahlberg' has been in. 

SELECT title, first_name, last_name
FROM actor
INNER JOIN film_actor 
ON actor.actor_id = film_actor.actor_id 
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE first_name= 'Nick' AND last_name = 'Wahlberg';

-- Answer: 
-- "Adaptation Holes"		"Nick"	"Wahlberg"
-- "Apache Divine"			"Nick"	"Wahlberg"
-- "Baby Hall"				"Nick"	"Wahlberg"
-- "Bull Shawshank"			"Nick"	"Wahlberg"
-- "Chainsaw Uptown"		"Nick"	"Wahlberg"
-- "Chisum Behavior"		"Nick"	"Wahlberg"
-- "Destiny Saturday"		"Nick"	"Wahlberg"
-- "Dracula Crystal"		"Nick"	"Wahlberg"
-- "Fight Jawbreaker"		"Nick"	"Wahlberg"
-- "Flash Wars"				"Nick"	"Wahlberg"
-- "Gilbert Pelican"		"Nick"	"Wahlberg"
-- "Goodfellas Salute"		"Nick"	"Wahlberg"
-- "Happiness United"		"Nick"	"Wahlberg"
-- "Indian Love"			"Nick"	"Wahlberg"
-- "Jekyll Frogmen"			"Nick"	"Wahlberg"
-- "Jersey Sassy"			"Nick"	"Wahlberg"
-- "Liaisons Sweet"			"Nick"	"Wahlberg"
-- "Lucky Flying"			"Nick"	"Wahlberg"
-- "Maguire Apache"			"Nick"	"Wahlberg"
-- "Mallrats United"		"Nick"	"Wahlberg"
-- "Mask Peach"				"Nick"	"Wahlberg"
-- "Roof Champion"			"Nick"	"Wahlberg"
-- "Rushmore Mermaid"		"Nick"	"Wahlberg"
-- "Smile Earring"			"Nick"	"Wahlberg"
-- "Wardrobe Phantom"		"Nick"	"Wahlberg"
 
-- ---------------------------------------------------------
-- END OF SECTION 5: Joins
-- ---------------------------------------------------------