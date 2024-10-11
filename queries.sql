@@ -35,39 +35,50 @@ SELECT * FROM albums WHERE title LIKE 'A%' ORDER BY title;
-- "invoices" table
-- Remember: run ".schema invoices" to see the structure of the "invoices" table

-- Every invoice

-- Every invoice
SELECT * FROM invoices;
-- Every invoice ordered by total invoice amount ("total")
SELECT * FROM invoices ORDER BY total DESC;

-- Every invoice with a total greater than 10
SELECT * FROM invoices WHERE total > 10;

-- The 10 least expensive invoices
-- Remember: ORDER BY orders from lowest-to-highest by default
SELECT * FROM invoices ORDER BY total LIMIT 10;

-- The 10 most expensive invoices
SELECT * FROM invoices ORDER BY total DESC LIMIT 10;

-- The 15 most recent invoices
SELECT * FROM invoices ORDER BY invoice_date DESC LIMIT 15;

-- The 15 oldest invoices
SELECT * FROM invoices ORDER BY invoice_date LIMIT 15;

-- The 10 most expensive invoices from the US
SELECT * FROM invoices WHERE billing_country = "USA" ORDER BY total DESC LIMIT 10;

-- The 10 least expensive invoices from the US
SELECT * FROM invoices WHERE billing_country = "USA" ORDER BY total LIMIT 10;

-- The 10 most expensive invoices from outside the US
-- Hint: If "=" means equal, use "!=" to mean "not equal"
SELECT * FROM invoices WHERE billing_country != "USA" ORDER BY total DESC LIMIT 10;

-- Every invoice from Chicago, IL
SELECT * FROM invoices WHERE billing_city = "Chicago" AND billing_state = "IL" AND billing_country="USA";

-- A list of all the invoices worth more than $5.00 from Chicago, IL
SELECT * FROM invoices WHERE billing_city = "Chicago" AND billing_state = "IL" AND billing_country="USA" AND total > 5.00;

-- The billing addresses of the 5 most valuable invoices from Mountain View CA
-- Gotta reward those big spenders!
SELECT billing_address FROM invoices WHERE billing_city = "Mountain View" AND billing_state = "CA" ORDER BY total DESC LIMIT 5;

-- A list of the 10 most valuable invoices made before January 1st, 2010
-- Hint: Dates are formatted like 'YYYY-MM-DD' and you can compare them using '<', '>', '<=' and '>='
SELECT * FROM invoices WHERE invoice_date < '2010-01-01' ORDER BY total DESC LIMIT 10;


-- The number of invoices from Chicago, IL
@@ -89,9 +100,14 @@ SELECT billing_state, COUNT(*), SUM(total) FROM invoices WHERE billing_country =
SELECT billing_state, COUNT(*), SUM(total), AVG(total) FROM invoices WHERE billing_country = "USA" and billing_state = "CA";

-- The count, total, and average of invoice totals, grouped by state, ordered by average invoice total from highest-to-lowest
SELECT billing_state, COUNT(*), SUM(total), AVG(total) FROM invoices WHERE billing_country = "USA" GROUP BY billing_state ORDER BY AVG(total) DESC;

-- A list of the top 5 countries by number of invoices
SELECT billing_country, COUNT(*) FROM invoices GROUP BY billing_country ORDER BY COUNT(*) DESC LIMIT 5;

-- A list of the top 5 countries by gross/total invoice size
SELECT billing_country, SUM(total) FROM invoices GROUP BY billing_country ORDER BY SUM(total) DESC LIMIT 5;

-- A list of the top 5 countries by average invoice size
SELECT billing_country, AVG(total) FROM invoices GROUP BY billing_country ORDER BY AVG(total) DESC LIMIT 5;
