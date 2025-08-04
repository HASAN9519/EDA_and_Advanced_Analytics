/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time

-- by year, ::date used to truncate timestamp from DATE_TRUNC() output
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	ROUND(AVG(avg_price) OVER (ORDER BY order_date), 2) AS moving_average_price
    FROM
    (
        SELECT 
            DATE_TRUNC('year', order_date)::date AS order_date,
            SUM(sales_amount) AS total_sales,
            AVG(price) AS avg_price
        FROM gold.fact_sales
        WHERE order_date IS NOT NULL
        GROUP BY DATE_TRUNC('year', order_date)::date
    ) AS cumulative_result;

-- by month
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	ROUND(AVG(avg_price) OVER (ORDER BY order_date), 2) AS moving_average_price
    FROM
    (
        SELECT 
            DATE_TRUNC('month', order_date)::date AS order_date,
            SUM(sales_amount) AS total_sales,
            AVG(price) AS avg_price
        FROM gold.fact_sales
        WHERE order_date IS NOT NULL
        GROUP BY DATE_TRUNC('month', order_date)::date
    ) AS cumulative_result;

-- using TO_CHAR() as DATE_TRUNC() gives timestamp output along with year and month
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	ROUND(AVG(avg_price) OVER (ORDER BY order_date), 2) AS moving_average_price
    FROM
    (
        SELECT 
            TO_CHAR(order_date, 'YYYY-MM') AS order_date,
            SUM(sales_amount) AS total_sales,
            AVG(price) AS avg_price
        FROM gold.fact_sales
        WHERE order_date IS NOT NULL
        GROUP BY TO_CHAR(order_date, 'YYYY-MM')
    ) AS cumulative_result;

SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	ROUND(AVG(avg_price) OVER (ORDER BY order_date), 2) AS moving_average_price
    FROM
    (
        SELECT 
            TO_CHAR(order_date, 'YYYY') AS order_date,
            SUM(sales_amount) AS total_sales,
            AVG(price) AS avg_price
        FROM gold.fact_sales
        WHERE order_date IS NOT NULL
        GROUP BY TO_CHAR(order_date, 'YYYY')
    ) AS cumulative_result;

-- using PARTITION

SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (PARTITION BY EXTRACT(YEAR FROM order_date) ORDER BY order_date) AS running_total_sales,
    ROUND(AVG(avg_price) OVER (PARTITION BY EXTRACT(YEAR FROM order_date) ORDER BY order_date), 2) AS moving_average_price
    FROM
    (
        SELECT 
            DATE_TRUNC('month', order_date)::date AS order_date,
            SUM(sales_amount) AS total_sales,
            AVG(price) AS avg_price
        FROM gold.fact_sales
        WHERE order_date IS NOT NULL
        GROUP BY DATE_TRUNC('month', order_date)::date
    ) AS cumulative_result;



-- for understanding moving averages
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (PARTITION BY EXTRACT(YEAR FROM order_date) ORDER BY order_date) AS running_total_sales,
    total_orders,
    total_price,
    ROUND(AVG(avg_price) OVER (PARTITION BY EXTRACT(YEAR FROM order_date) ORDER BY order_date), 2) AS moving_average_price
    FROM
    (
        SELECT 
            DATE_TRUNC('month', order_date)::date AS order_date,
            COUNT(order_date) AS total_orders,
            SUM(sales_amount) AS total_sales,
            SUM(price) AS total_price,
            AVG(price) AS avg_price
        FROM gold.fact_sales
        WHERE order_date IS NOT NULL
        GROUP BY DATE_TRUNC('month', order_date)::date
    ) AS cumulative_result;




-- code for sql server
-- SELECT
-- 	order_date,
-- 	total_sales,
-- 	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
-- 	AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
--     FROM
--     (
--         SELECT 
--             DATETRUNC(year, order_date) AS order_date,
--             SUM(sales_amount) AS total_sales,
--             AVG(price) AS avg_price
--         FROM gold.fact_sales
--         WHERE order_date IS NOT NULL
--         GROUP BY DATETRUNC(year, order_date)
--     ) t;
