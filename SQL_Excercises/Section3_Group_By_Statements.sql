-- ---------------------------------------------------------
-- SECTION 3: GROUP BY STATEMENTS
-- ---------------------------------------------------------

-- Overview 
-- Aggregate Functions 
-- GROUP BY - part 1 - Theory
-- GROUP BY - part 2 - Implementation 
-- Challenge Task for Group BY 
-- Having - Filtering with GROUP BY 
-- Challenge Task for HAVING 

-- ---------------------------
-- Introduction to GROUP BY		
-- ---------------------------


-- ---------------------------
-- AGGREGATION FUNCTIONS	
-- ---------------------------

-- SQL Provides a variety of aggreate functions. 
-- The main idea behind an aggreagate function is to take multiple inputs and return a single output. 
-- Aggregate function calls happen ONLY in the SELECT clause or the HAVING clause.

-- Special notes: AVG() returns floating point value many decimal places (e.g. 2.342419)
-- You can use ROUND() to specify precision after the decimal 
-- COUNT() simply returns the number of reows, which means by convetion we just use COUNT(*)

-- Most Common Aggregate Fuctions: 
-- AVG() - returns average value
-- COUNT() - returns number of values
-- MAX () - returns maximum value 
-- MIN () - returns minimum value
-- SUM() - returns the sum of all values

SELECT *
FROM film; 

-- What is the minimum replacement cost? 
SELECT MIN(replacement_cost)
FROM film; 
-- 9.99 

-- What is the most replacement cost? 
SELECT MAX(replacement_cost)
FROM film;
-- 29.99

SELECT MAX(replacement_cost), MIN(replacement_cost)
FROM film;
-- 29.99 & 9.99

SELECT COUNT(*)
FROM film;

SELECT ROUND(AVG(replacement_cost),2) -- to round with 2 decimals 
FROM film;

SELECT SUM(replacement_cost)
FROM film;
-- 19.984,00 

-- ---------------------------
-- GROUP BY - PART 1	
-- ---------------------------

-- GROUP BY allows us to aggregate columns per some category. 

-- Example:
-- SELECT category_col, AGG(data_col)
-- FROM table
-- GROUP BY category_col

-- You can also filter things by using a WHERE statement. 

-- Example: 

-- SELECt category_col, AGG(data_col)
-- FROM table 
-- WHERE category_col != 'A'
-- GROUP BY category_col

-- The GROUP BY clause must appear right after a FROM or WHERE statement.
-- In the SELECT statement, columns must either have an aggregate function or be in the GROUP BY call.

-- different example: 
-- SELECT company, division, SUM(sales)
-- FROM finance_table 
-- GROUP BY company, division 

-- In the SELECT statement, columns must either have an aggregate function or be in the GROUP BY call.

-- other example: 
-- SELECT company, division, SUM(sales)
-- FROM finance_table 
-- WHERE division IN ('marketing', 'transport')
-- GROUP BY company, divsion 

-- WHERE statements should not refer to the aggregation result.

-- if you wnat to sort results based on the aggregate, make sure to reference the entire function 
-- SELECT company, SUM(sales)
-- FROM finance_table 
-- GROUP BY company 
-- ORDER BY SUM(sales)
-- LIMIT 5 				-- if you want to see the top 5.

-- ---------------------------
-- GROUP BY - PART 2	
-- ---------------------------

SELECT *
FROM payment;

-- GROUP BY customer ID's

SELECT customer_id 
FROM payment 
GROUP BY customer_id
ORDER BY customer_id;

-- What customer is spending the most money?
SELECT 
	customer_id ,SUM(amount)
FROM 
	payment
GROUP BY 
	customer_id
ORDER BY SUM
	(amount) DESC;

-- or

SELECT 
	customer_id , COUNT(amount)
FROM 
	payment
GROUP BY 
	customer_id
ORDER BY SUM
	(amount) DESC;

SELECT customer_id, staff_id, SUM(amount)
FROM payment
GROUP BY staff_id, customer_id
ORDER BY customer_id;

SELECT staff_id, customer_id, SUM(amount)
FROM payment
GROUP BY staff_id, customer_id
ORDER BY customer_id;

SELECT staff_id, customer_id, SUM(amount)
FROM payment
GROUP BY staff_id, customer_id
ORDER BY SUM(amount);

-- converting and group by date
SELECT DATE(payment_date), SUM(amount)
FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;

-- ---------------------------
-- GROUP BY - CHALLENGES	
-- ---------------------------

-- Challenge 1: We have two staffmembers, with Staff IDs 1 and 2. 
-- We want to give a bonus to the staff members that handled the most payments. (most in terms of number of payments processed, not total dollar amount). 
-- How many payments did each staff member handle and who gets the bonus?

SELECT * 
from payment; 

SELECT staff_id, COUNT(payment_id)
from payment
GROUP BY staff_id
ORDER BY COUNT(payment_id) DESC; 
-- Staff number 2 gets the bonus with 7304

-- Another query: 
SELECT staff_id, COUNT(amount)
from payment
GROUP BY staff_id;
-- Staff number 2 gets the bonus

-- Another query: 
SELECT staff_id, COUNT(*)
from payment
GROUP BY staff_id;

---------------------------------

-- Challenge 2: HQ is conducting a study on the relationship between replacement cost
-- and a movie MPAA rating (e.g. G, PG, R, etc....).
-- What is the average replacement cost per MPAA rating?
-- Note: You may need to expand the AVG column to view correct results 

SELECT *
FROM film; 

SELECT rating, 
ROUND(AVG(replacement_cost), 2)
from film
GROUP BY rating
ORDER BY COUNT(replacement_cost) DESC; 
-- "PG-13"		20.40
-- "NC-17"		20.14
-- "R"			20.23
-- "PG"			18.96
-- "G"			20.12

-- solution: 
SELECT rating, 
ROUND(AVG(replacement_cost), 2)
FROM film
GROUP BY rating;

---------------------------------

-- Challenge 3: We are running a promotion to reward our top 5 customers with coupons.
-- What are the customers IDS of the top 5 customers by total spend? 

SELECT customer_id, SUM(amount)
From payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

-- result: 
-- 148	211.55
-- 526	208.58
-- 178	194.61
-- 137	191.62
-- 144	189.60

-- ---------------------------
-- HAVING
-- ---------------------------

-- The HAVING clause allows us to filter after an aggregation hs already taken place. 

-- SELECT company, SUM(sales)
-- From finance_table 
-- WHERE company != 'Google'
-- GROUP BY company

-- what if we want to filter based on sales? 
-- SELECT company, SUM(sales)
-- From finance_table 
-- WHERE company != 'Google'
-- GROUP BY company
-- HAVING SUM(sales) >1000

-- Having allows us to use the aggregate result as a filter along with a GROUP BY.

-- EXAMPLES 

SELECT * 
from payment; 

SELECT customer_id, SUM(amount)
from payment
GROUP BY customer_id
HAVING SUM(amount) >100; 

SELECT *
FROM customer;

SELECT store_id, COUNT(customer_id)
FROM customer
GROUP BY store_id;

SELECT store_id, COUNT(*)
FROM customer
GROUP BY store_id
HAVING COUNT(*) > 300;

-- or 

SELECT store_id, COUNT(customer_id)
FROM customer
GROUP BY store_id
HAVING COUNT(customer_id) > 300;

-- ---------------------------
-- HAVING - CHALLENGE TASK
-- ---------------------------

-- Challenge 2: We are launching a platinum service for our most loyal customers. 
-- We will assign platinum status to customers that have had 40 or more transaction payments. 
-- What customer_ids are eligible for platinum status? 

SELECT customer_id, COUNT(payment_id)
FROM payment
GROUP by customer_id
HAVING COUNT(payment_id) >= 40;

-- Results: 
-- 144	40
-- 526	42
-- 148	45

-- Another Query: 
SELECT customer_id, COUNT(*)
FROM payment
GROUP by customer_id
HAVING COUNT(payment_id) >= 40;

---------------------------------

-- Challenge 2: What are the customer ids of customers who have spent 
-- more than $100 in payment transactions with our staff_id member 2?

SELECT customer_id, SUM(amount)
FROM payment
WHERE staff_id = '2' 
GROUP BY customer_id
HAVING SUM(amount) >= 100 ; 

-- Answer: 
-- 187	110.81
-- 522	102.80
-- 526	101.78
-- 211	108.77
-- 148	110.78


-- ---------------------------------------------------------
-- END OF SECTION 3: GROUP BY STATEMENTS
-- ---------------------------------------------------------