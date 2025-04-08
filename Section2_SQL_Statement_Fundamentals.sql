-- ---------------------------------------------------------
--			SECTION 2: SQL STATEMENT FUNDAMENTALS 
-- ---------------------------------------------------------

-- Situation: We want to send out a promotional email to our existing customers. 

SELECT first_name, last_name, email
FROM customer; 

-- SELECT DISTINCT 

-- SELECT DISTINCT choice 
-- FROM color_table

SELECT * FROM film;

SELECT DISTINCT (release_year) 
FROM film;

SELECT DISTINCT (rental_rate)
FROM film;

-- ---------------------------------------
-- SELECT DISTINCT FUNCTION 
-- ---------------------------------------
-- Challenge: SELECT DISTINCT 
-- Situation: An Australain visitor isn't familiar with MPAA movie ratings (e.g. PG, PG-13, R etc.)
-- We want to know the types of ratings we have in our database. What ratings do we have available? 

-- Solution: 
SELECT DISTINCT (rating)
FROM film;

-- Answer: 
-- "PG-13"
-- "NC-17"
-- "R"
-- "G"
-- "PG"

-- ---------------------------------------
-- COUNT FUNCTION 
-- ---------------------------------------
-- The COUNT function returns the number of input rows that match a specific condition of a query. 
-- We can apply COUNT on a specific column or just pass COUNT(*), we will soon see this should return the same result. 

SELECT COUNT(*) FROM payment;

SELECT COUNT(amount) FROM payment;

SELECT amount FROM payment;

SELECT DISTINCT amount FROM payment; -- what/how many unique payment amounts?

SELECT COUNT(DISTINCT amount) FROM payment; -- 19 unique distinct amounts

-- ---------------------------------------
-- SELECT WHERE
-- ---------------------------------------

-- SELECT and WHERE are the most fundamental SQL statements and you will find yourself using them often! 
-- the WHERE statement allows us to specify conditions on columns for the rows to be returned. 

-- BASIC SYNTAC EXAMPLE: 

-- SELECT column1, column2
-- FROM table 
-- WHERE conditions; 

-- The WHERE clause appears immediately after FROM clause of the SELECT statement. The conditions are used to filter the rows returned from the SELECT statement.
-- POSTgreSQL provides a variety of standard operators to construct the conditions. 

SELECT *
FROM customer; 

SELECT * 
FROM customer      -- to see all the customers with the name 'Jared'
WHERE first_name = 'Jared';

SELECT * 
FROM film
WHERE rental_rate > 4;

SELECT * 
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating ='R';

SELECT title 
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating ='R';

SELECT COUNT(title) 
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating ='R';

-- same 

SELECT COUNT(*) 
FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating ='R';

SELECT COUNT(*) 
FROM film
WHERE rating ='R' OR rating ='PG-13';

SELECT * 
FROM film
WHERE rating !='R';

-- Challenge 1: SELECT WHERE 
-- Situation: A customer forgot their wallet at out store. We need to track down their email to inform them. 
-- What is the email for the customerwith the name Nancy Thomas? 

SELECT * 
FROM customer 
WHERE first_name = 'Nancy' 
AND last_name = 'Thomas';

-- Just only the email information 
SELECT email
FROM customer 
WHERE first_name = 'Nancy' 
AND last_name = 'Thomas';

-- Challenge 2
-- A customer wants toknow what the movie 'Outlaw Hanky' is about. 
-- Could you give them the description for the movie 'Outlaw Hanky'.

SELECT * 
FROM film
WHERE title = 'Outlaw Hanky';

-- Only description 
SELECT description
FROM film
WHERE title = 'Outlaw Hanky';

-- Challenge 3
-- A customer is late on their movie return, and we've mailed them a letter to their address at '259 Ipoh Drive'. We schould also call them on the phone to let them know. 
-- Can you get the phone number for the customer who lives at '259 Ipoh Drive'? 

SELECT *
FROM  address 
WHERE address = '259 Ipoh Drive';

-- OR 
SELECT phone
FROM  address 
WHERE address = '259 Ipoh Drive';

-- ---------------------------------------
-- ORDER BY FUNCTION
-- ---------------------------------------

-- Basic syntax for ORDER BY:
-- SELECT column1, column2 
-- FROM table 
-- ORDER BY column1 ASC/DESC

SELECT * 
FROM customer;

SELECT *
FROM customer
ORDER BY first_name ASC;

SELECT *
FROM customer
ORDER BY first_name DESC;

SELECT store_id, first_name, last_name
FROM customer
ORDER BY store_id, first_name;

SELECT store_id, first_name, last_name
FROM customer
ORDER BY store_id DESC, first_name ASC;

SELECT first_name, last_name
FROM customer
ORDER BY store_id DESC, first_name ASC;

-- ---------------------------------------
-- LIMIT FUNCTION
-- ---------------------------------------

-- LIMIT goes at the very end of a query request and is the last command to be executed. 
-- Let's learn the basic syntax of LIMIT through some examples. 

SELECT *
FROM payment
ORDER BY payment_date DESC;

-- Question what where the ten most recent purchaises in the payment? 
SELECT * 
FROM payment
WHERE amount != 0.00
ORDER BY payment_date DESC
LIMIT 10;

-- Just for seeing the layout you can input the following query: 
SELECT * 
FROM payment 
Limit 1;

-- Challenge: ORDER BY and Limit 

-- Challenge 1: We want to reward our first 10 paying customers. 
-- What are the customers ids of the first 10 customers who created a payment 

SELECT customer_id, payment_date
FROM payment
ORDER BY payment_date ASC
LIMIT 10;

-- Challenge 2: A customer wants to quickly rent a video to watch over their short lunch break. 
-- What are the titles of the 5 shortest (in length or runtime) movies?

SELECT title, length
FROM film
ORDER BY length ASC
LIMIT 5;

-- Quick Bonus: If the previous customer can watch any movie that is 50 minutes or less in run time, how many options does she have? 
SELECT COUNT(title)
FROM film 
WHERE length <= 50 

-- ---------------------------------------
-- BETWEEN OPERATOR
-- ---------------------------------------

-- The BETWEEN operator can be used to match a value against a range of values. 
-- value between low and high 
-- You can also combinee BETWEEN with the NOT logical operator: value NOT BETWEEN low AND high

-- The NOT BETWEEN operator is the same as: 
-- value < low or value > high 
-- value NOT BETWEEN low AND high

-- The BETWEEN operator is the same as: 
-- value >= low AND value <= high 
-- value BETWEEN low AND high 

-- The BETWEEN operator can also be used with dates. Note that you need to format dates in the ISO 8601 standard format, 
-- which is YYYY-MM-DD
-- date BETWEEN '2007-01-01' AND '2007-02-01'

SELECT * 
FROM payment 
LIMIT 2; 

SELECT * 
FROM payment 
WHERE amount BETWEEN 8 AND 9;

-- If I want to know how many in between 8 and 9 

SELECT COUNT(*) 
FROM payment 
WHERE amount BETWEEN 8 and 9;

SELECT COUNT(*) 
FROM payment 
WHERE amount NOT BETWEEN 8 and 9;

SELECT * 
FROM payment 
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';


-- ---------------------------------------
-- IN OPERATOR
-- ---------------------------------------
-- In certain cases you want to check for multiple possible value options, for example, if a user's name shows up IN a list of known names. 
-- We can use the IN operator to create a condition that checks to see if a value in included in a list of multiple options.
-- General syntax is: 
-- value IN (op1ion1, option2, ....)

-- Example query: 
-- SELECT color FROM table
-- WHERE color IN ('red', 'blue')

SELECT * 
FROM payment
LIMIT 2; 

SELECT DISTINCT(amount) 
FROM payment
ORDER BY amount

SELECT * 
FROM payment
WHERE amount in (0.99, 1.98, 1.99)
ORDER BY amount

SELECT COUNT(*)
FROM payment
WHERE amount in (0.99, 1.98, 1.99)

SELECT COUNT(*)
FROM payment
WHERE amount NOT in (0.99, 1.98, 1.99)
--11295

SELECT *
FROM customer
WHERE first_name IN ('John', 'Jake', 'Julie')

SELECT *
FROM customer
WHERE first_name NOT IN ('John', 'Jake', 'Julie')


-- ---------------------------------------
-- LIKE and ILIKE OPERATOR
-- ---------------------------------------
-- The LIKE operator allows us to perform pattern matching against string data with the use of wildcard characters: 
-- Percent % : Matches any sequences of characters
-- Underscore_ : Matches any single character

-- All names that begin with an 'A'
-- WHERE name LIKE 'A%'
-- All names that end with an 'a'
-- WHERE name LIKE '%a'
-- Like is case-sensitive, we can use ILIKE which is case-insensitive. 

-- Using the underscore allows us to replace jsut a single character
-- Get all Mission Impossible films
-- WHERE title LIKE 'Mission Impossible_'
-- You can use multope underscores. 
-- Imagine 'Version#A4', 'Version#B7', etc... 
-- WHERE value LIKE 'Version#__'

-- We can also combine pattern matching operators to create more complex patterns 
-- WHERE name LIKE '_her%'
-- Chery
-- Theresa 
-- Sherri

-- PostgreSQL support full regex capabilities 

-- EXAMPLES 
-- How many people start with the name 'J'

SELECT * 
FROM customer 
WHERE first_name LIKE 'J%' AND last_name LIKE 'S%'

-- LIKE is case sensitive ... so you could also do the following with ILIKE 
-- ILIKE is not case sensitve. 

SELECT * 
FROM customer 
WHERE first_name ILIKE 'j%' AND last_name ILIKE 's%'

SELECT *
FROM customer 
WHERE first_name LIKE '%er%'


SELECT *
FROM customer 
WHERE first_name LIKE '_her%'


SELECT *
FROM customer 
WHERE first_name NOT LIKE '_her%'

SELECT *
FROM customer 
WHERE first_name LIKE 'A%' AND last_name NOT LIKE 'B%'
ORDER BY last_name

-- ---------------------------------------
-- GENERAL CHALLENGE  
-- ---------------------------------------

-- CHALLENGE 1: How many payment transactions were greather than $5.00?
SELECT * 
FROM payment 
WHERE amount > 5.00;

SELECT COUNT(*) 
FROM payment 
WHERE amount > 5.00;
-- 3618

SELECT COUNT(amount) 
FROM payment 
WHERE amount > 5.00;

-- CHALLENGE 2: How many actors have a first name that starts with the letter 'P'? 
SELECT first_name
FROM actor 
WHERE first_name LIKE 'P%';

SELECT COUNT(first_name)
FROM actor 
WHERE first_name LIKE 'P%';
-- 5

SELECT COUNT(*)
FROM actor 
WHERE first_name LIKE 'P%';

-- CHALLENGE 3: How many unique dictricts are our customers from?
SELECT DISTINCT(COUNT(district))
FROM address ;
-- 603 -- the above is incorrect

SELECT COUNT(DISTINCT(district))
FROM address;
-- 378

-- CHALLENGE 4: Retrieve the list of names for those distinct districts from the previous question. 
SELECT DISTINCT(district)
FROM address;

-- CHALLENGE 5: How many films have a rating of R and a replacement cost between $5 and 15? 
SELECT COUNT(*) 
FROM film 
WHERE rating = 'R' AND replacement_cost BETWEEN 5.00 AND 15.00;
-- 52

-- CHALLENGE 6: How many films have the word 'Truman' somewhere in the title?
SELECT COUNT(title)
from film 
WHERE title LIKE '%Truman%';
-- 5

SELECT COUNT(*)
from film 
WHERE title LIKE '%Truman%';

-- ---------------------------------------------------------
--		END OF SECTION 2: SQL STATEMENT FUNDAMENTALS 
-- ---------------------------------------------------------
