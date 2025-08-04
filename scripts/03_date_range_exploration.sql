/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last order date and the total duration in months
-- code for postgres
-- testing code

-- SELECT 
--     AGE(MAX(order_date), MIN(order_date)),
--     EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))),
--     EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date)))
--     FROM gold.fact_sales;

SELECT 
    EXTRACT(YEAR FROM order_date)
    FROM gold.fact_sales;

SELECT 
    MIN(order_date) AS first_order_date, 
    MAX(order_date) AS last_order_date, 
    EXTRACT(YEAR FROM AGE(MAX(order_date), MIN(order_date))) * 12 + 
    EXTRACT(MONTH FROM AGE(MAX(order_date), MIN(order_date))) AS order_range_months 
    FROM gold.fact_sales;


-- code for sql server
-- SELECT 
--     MIN(order_date) AS first_order_date,
--     MAX(order_date) AS last_order_date,
--     DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
--     FROM gold.fact_sales;

-- Find the youngest and oldest customer based on birthdate
-- code for postgres
SELECT
    MIN(birthdate) AS oldest_birthdate,
    DATE_PART('year', AGE(CURRENT_DATE, MIN(birthdate))) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    DATE_PART('year', AGE(CURRENT_DATE, MAX(birthdate))) AS youngest_age 
    FROM gold.dim_customers;


-- code for sql server
-- SELECT
--     MIN(birthdate) AS oldest_birthdate,
--     DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
--     MAX(birthdate) AS youngest_birthdate,
--     DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
--     FROM gold.dim_customers;
