-- Outline
--
-- So far, we've been talking about joins using the JOIN keyword. This is
-- just one type of join, called an INNER JOIN.  In fact, wherever we've
-- been using the "JOIN" keyword we could instead replace it with "INNER JOIN"
-- without changing anything.
--
-- There's a second type of join, called a left join or left outer join.
-- It's a bit difficult to explain, but here are some blog posts:
--   http://stackoverflow.com/questions/448023/what-is-the-difference-between-left-right-outer-and-inner-joins
--   http://blog.codinghorror.com/a-visual-explanation-of-sql-joins/

-- Compare the output of these queries:
-- JOIN
SELECT employees.id, employees.first_name, employees.last_name,
       COUNT(DISTINCT(customers.id)) AS customers_served
FROM employees
JOIN customers
  ON (employees.id = customers.support_rep_id)
GROUP BY employees.id;

-- LEFT JOIN
SELECT employees.id, employees.first_name, employees.last_name,
       COUNT(DISTINCT(customers.id)) AS customers_served
FROM employees
LEFT JOIN customers
  ON (employees.id = customers.support_rep_id)
GROUP BY employees.id;

-- Note: Unlike JOIN, with a LEFT JOIN it does matter which table comes first.
-- That is,
--   FROM TableA LEFT JOIN TableB
-- **IS NOT THE SAME AS**
--   FROM TableB LEFT JOIN TableA
-- This is an example of a RIGHT JOIN.

SELECT employees.id, employees.first_name, employees.last_name,
  COUNT(DISTINCT(customers.id)) AS customers_served
FROM employeess
RIGHT JOIN customers
  ON (employees.id = customers.support_rep_id)
GROUP BY employees.id;

-- This will return a SINGLE row, even though there are no corresponding customers.
-- The fields from the customers table are displayed as empty (or NULL), telling
-- us that Employee #1 has no associated customers.
SELECT *
FROM employees
LEFT JOIN customers
  ON (employees.id = customers.support_rep_id)
WHERE employees.id = 1;

-- Employees is the left table, customers is the right table, and the join
-- condition is employees.id = customers.support_rep_id.

SELECT Employees.*, Customers.*
FROM Employees
LEFT JOIN Customers
ON Employees.id = Customers.support_rep_id;

-- One handy thing is that this allows us to create queries like...
-- Show me all employees who don't support any customers

SELECT *
FROM employees
LEFT JOIN customers
  ON (employees.id = customers.support_rep_id)
WHERE customers.id IS NULL;

-- There are no exercises, here, because the toy database doesn't have
-- interesting enough data to merit the use of LEFT JOINs in many contexts.
-- For example, this query would return all customers who had yet to make an
-- order.  In the toy database, there are no such customers, alas!

SELECT *
FROM customers
LEFT JOIN invoices
  ON (invoices.customer_id = customers.id)
WHERE invoices.id IS NULL;
