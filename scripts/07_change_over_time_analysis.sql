/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions for sql server: DATEPART(), DATETRUNC(), FORMAT()
    - Date Functions for postgres: EXTRACT(), DATE_TRUNC(), TO_CHAR()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions

SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity 
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
    ORDER BY order_year, order_month;

-- code for sql server
-- SELECT
--     YEAR(order_date) AS order_year,
--     MONTH(order_date) AS order_month,
--     SUM(sales_amount) AS total_sales,
--     COUNT(DISTINCT customer_key) AS total_customers,
--     SUM(quantity) AS total_quantity
--     FROM gold.fact_sales
--     WHERE order_date IS NOT NULL
--     GROUP BY YEAR(order_date), MONTH(order_date)
--     ORDER BY YEAR(order_date), MONTH(order_date);

-- DATE_TRUNC()
SELECT
    DATE_TRUNC('month', order_date) AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity 
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATE_TRUNC('month', order_date)
    ORDER BY DATE_TRUNC('month', order_date);

-- code for sql server
-- DATETRUNC()
-- SELECT
--     DATETRUNC(month, order_date) AS order_date,
--     SUM(sales_amount) AS total_sales,
--     COUNT(DISTINCT customer_key) AS total_customers,
--     SUM(quantity) AS total_quantity
--     FROM gold.fact_sales
--     WHERE order_date IS NOT NULL
--     GROUP BY DATETRUNC(month, order_date)
--     ORDER BY DATETRUNC(month, order_date);

-- TO_CHAR()
SELECT
    TO_CHAR(order_date, 'YYYY-Mon') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY TO_CHAR(order_date, 'YYYY-Mon')
    ORDER BY TO_CHAR(order_date, 'YYYY-Mon');

SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY TO_CHAR(order_date, 'YYYY-MM')
    ORDER BY TO_CHAR(order_date, 'YYYY-MM');

-- code for sql server
-- FORMAT()
-- SELECT
--     FORMAT(order_date, 'yyyy-MMM') AS order_date,
--     SUM(sales_amount) AS total_sales,
--     COUNT(DISTINCT customer_key) AS total_customers,
--     SUM(quantity) AS total_quantity
--     FROM gold.fact_sales
--     WHERE order_date IS NOT NULL
--     GROUP BY FORMAT(order_date, 'yyyy-MMM')
--     ORDER BY FORMAT(order_date, 'yyyy-MMM');
