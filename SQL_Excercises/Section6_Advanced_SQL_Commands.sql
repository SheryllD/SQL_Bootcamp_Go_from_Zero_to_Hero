-- ---------------------------------------------------------
-- SECTION 6: Advanced SQL Commands
-- ---------------------------------------------------------

-- Overview of Advanced SQL Commands

------ Timestamps and Extract Part 1 ------ 

-- PostgreSQL can hold date and time information 
-- TIME - Contains only time 
-- DATE - Contains only date 
-- TIMESTAMP - Contains date and time 
-- TIMESTAMPTZ - Contains data, time and timezone

-- Careful considerations should be made when designing a table and database and choosing. a time data type.
-- However, depending on the situation you may or may not need the full level of TIMESTAMPTZ 
-- Remember, you can always remove historical information, but you can't add it. 

-- Functions, The following functions and operations are related to these specific data types: 
-- TIMEZONE 
-- NOW 
-- TIMEOFDAY
-- CURRENT_TIME
-- CURRENT_DATE

-- Examples

-- What is your current timezone you work on? 

-- SHOW ALL
-- SHOW TIMEZONE

SELECT NOW (); -- date and timezone 

SELECT TIMEOFDAY();  -- provides a string 

SELECT CURRENT_TIME; -- TIME WITH TIME ZONE

SELECT CURRENT_DATE; -- CURRENT DATE 

------ Timestamps and Extract Part 2 ------ 

-- You can extract information from a tim ebased data type using
-- EXTRACT()
-- AGE()
-- TO_CHAR()

-- EXTRACT()
-- Allows you ti extract or obtain a sub-component of a date value such as: 
-- YEAR, MONTH, DAY, WEEK, QUARTER
-- E.G: EXTRAXT(YEAR FROM date_col)

-- AGE()
-- Calculates and returns the current age given a timestamp
-- usage: AGE(date_col)
-- returns: 13 years 1 mon 5 days 01:34:13.003423

-- TO_CHAR()
-- general function to convert data types totext
-- usefulfor timestampformatting
-- usage: TO_CHAR(date_col, 'mm-dd-yyyy')

-- All of these functions are best understood through example, so lets jump to pgadmin and work with these functions 

-- EG. 
SELECT EXTRACT(YEAR FROM payment_date) AS myyear
FROM payment; 

SELECT EXTRACT(MONTH FROM payment_date) AS pay_month
FROM payment; 

SELECT EXTRACT(QUARTER FROM payment_date) 
AS pay_month
FROM payment;

SELECT AGE(payment_date)
FROM payment;

SELECT TO_CHAR(payment_date, 'MONTH-YYYY')
FROM payment;

SELECT TO_CHAR(payment_date, 'mon/dd/yyyy')
FROM payment;

-- Extra source: https://www.postgresql.org/docs/12/functions-formatting.html

-- ---------------------------------------------------------
-- Challenges
-- ---------------------------------------------------------

-- 1. During which month did payments occur? Format your answer to return back the full month name. 

SELECT TO_CHAR(payment_date, 'MONTH')
FROM payment;

-- Correct: 
SELECT 
DISTINCT(TO_CHAR(payment_date, 'MONTH'))
FROM payment;

-- 2. How many payments occured on a Monday 
-- SELECT COUNT(*)
-- FROM payment
-- WHERE (TO_CHAR(payment_date, 'Day')) = 'MONDAY'

SELECT COUNT(*)
FROM payment
WHERE EXTRACT(DOW FROM payment_date) = 1;
-- 2948
-- DOW() functio: Returns a numeric value (1 to 7) representing the day of the week for a specified date or datetime. Abbreviation for "Day of Week".

------ MATHEMATICAL FUNCTIONS AND OPERATORS ------ 

SELECT * FROM film;

SELECT ROUND(rental_rate/replacement_cost, 2)*100 AS percent_cost
FROM film;

SELECT 0.1 * replacement_cost  AS deposit
FROM film;

------ STRING FUNCTIONS AND OPERATORS ------

SELECT * FROM customer

SELECT LENGTH(first_name) 
FROM customer;

SELECT first_name || ' ' || last_name AS full_name
FROM customer;

SELECT upper(first_name) || ' ' || last_name AS full_name
FROM customer;

SELECT LOWER(LEFT(first_name, 1)) || LOWER(last_name) || 'gmail.com' 
AS custom_email
FROM customer; -- takes only the first letter and lowers everything of the last name.

------ SUBQUERY ------ 

-- A sub query allows you to construct complex queries, essentially performing a query on the results of another query
-- The syntax is straightforward and involves two SELECT statements.

-- Example: 
SELECT student, grade 
FROM test_scores
WHERE grade > (SELECT AVG(grade) 
FROM test_scores);
-- The subquery is performed first since it is inside the paranthesis 
-- We can also use the IN operator in conjuction with a subquery to check against multiple results return 

-- A subquery can operate on a seperate table: 
SELECT student, grade
FROM test_scores 
WHERE student IN 
(SELECT student
FROM honor_roll_table);

-- The EXISTS operator is used to test for existence of rows in a subquery
-- Typically a subquery is passed in the EXISTS() function to check if any rows are returned with the subquery 

-- Typical Syntax: 
SELECT column_name 
FROM table_name 
WHERE EXISTS 
(SELECT column_name 
FROM table_name 
WHERE condition);

--e.g. 

SELECT * FROM film;

SELECT title, rental_rate 
FROM film 
WHERE rental_rate > (select AVG(rental_rate) FROM film); 

SELECT * FROM rental;

SELECT * FROM inventory;

SELECT *
FROM rental 
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30';

SELECT *
FROM rental 
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30';

SELECT film_id, title 
FROM film 
WHERE film_id IN
(SELECT inventory.film_id
FROM rental 
INNER JOIN inventory on inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30')
ORDER BY film_id;

SELECT first_name, last_name 
FROM customer AS c
WHERE EXISTS 
(SELECT * FROM payment as p 
WHERE p.customer_id = c.customer_id
AND amount > 11);

SELECT first_name, last_name 
FROM customer AS c
WHERE NOT EXISTS 
(SELECT * FROM payment as p 
WHERE p.customer_id = c.customer_id
AND amount > 11);

------ SELF-JOIN ------ 

-- A self-join is a query in which a table joined itself
-- self-join are useful for comparing values in a column of rows within the same table. 

-- The self join can be viewed as a join of two copies of the same table 
-- The table is not actually copied, but SQL performs the command as though it were. 
-- There is no special keyword for a self join, its simply standard JOIN syntax with the same table in both parts. 
-- However, when using a self join it is necessary to use an alias for the table, otherwise the table nameswould be ambiguous. 
-- Let's see a syntax example of this. 

-- Syntax eg.
SELECT tableA.col, tableB.col
FROM table AS tableA
JOIN table AS tableB ON 
tableA.some_col = tableB.other_col;

-- Syntax eg. 
SELECT emp.name, report.name AS rep
FROM employees AS emp
JOIN employees AS report ON 
emp.emp_id = report.report_id;

-- eg. 
-- FIND ALL THE PAIRS OF THE FILMS THAT HAVE THE SAME LENGTH 
SELECT * FROM film;

SELECT title, length FROM film
WHERE length = 117;

SELECT f1.title, f2.title, f1.length   -- f stands for film
FROM film AS f1 
INNER JOIN film AS f2 ON 
f1.film_id != f2.film_id
AND f1.length = f2.length;


-- ---------------------------------------------------------
-- END OF SECTION 6: Advanced SQL Commands
-- ---------------------------------------------------------