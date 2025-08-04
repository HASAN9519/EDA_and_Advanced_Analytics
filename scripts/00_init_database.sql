/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'my_datawarehouse_analytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called gold
	
WARNING:
    Running this script will drop the entire 'my_datawarehouse_analytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- *********************************************************************************    code for postgres

-- run following code to execute the file:			\i E:/8_Data_Analysis/1_EDA_and_AdvancedAnalytics/scripts/00_init_database.sql

-- Drop and recreate the database (outside SQL, via CLI or admin tool)
-- Run in psql or manually connect to "postgres" first

DROP DATABASE IF EXISTS my_datawarehouse_analytics;
CREATE DATABASE my_datawarehouse_analytics;

-- Connect to the new database manually before running the following:
-- In psql: 
\c my_datawarehouse_analytics;

-- Create Schema
CREATE SCHEMA IF NOT EXISTS gold;

-- Create Tables
CREATE TABLE gold.dim_customers (
    customer_key     INT,
    customer_id      INT,
    customer_number  VARCHAR(50),
    first_name       VARCHAR(50),
    last_name        VARCHAR(50),
    country          VARCHAR(50),
    marital_status   VARCHAR(50),
    gender           VARCHAR(50),
    birthdate        DATE,
    create_date      DATE
);

CREATE TABLE gold.dim_products (
    product_key    INT,
    product_id     INT,
    product_number VARCHAR(50),
    product_name   VARCHAR(50),
    category_id    VARCHAR(50),
    category       VARCHAR(50),
    subcategory    VARCHAR(50),
    maintenance    VARCHAR(50),
    cost           INT,
    product_line   VARCHAR(50),
    start_date     DATE
);

CREATE TABLE gold.fact_sales (
    order_number   VARCHAR(50),
    product_key    INT,
    customer_key   INT,
    order_date     DATE,
    shipping_date  DATE,
    due_date       DATE,
    sales_amount   INT,
    quantity       SMALLINT,
    price          INT
);

-- Truncate Tables
TRUNCATE TABLE gold.dim_customers;
TRUNCATE TABLE gold.dim_products;
TRUNCATE TABLE gold.fact_sales;

-- Load CSV Data (Make sure paths are accessible to PostgreSQL server)
COPY gold.dim_customers
FROM 'E:/8_Data_Analysis/1_EDA_and_AdvancedAnalytics/datasets/gold.dim_customers.csv'
WITH (FORMAT csv, HEADER true);

COPY gold.dim_products
FROM 'E:/8_Data_Analysis/1_EDA_and_AdvancedAnalytics/datasets/gold.dim_products.csv'
WITH (FORMAT csv, HEADER true);

COPY gold.fact_sales
FROM 'E:/8_Data_Analysis/1_EDA_and_AdvancedAnalytics/datasets/gold.fact_sales.csv'
WITH (FORMAT csv, HEADER true);



-- *****************************************************         code for sql server

-- USE master;
-- GO

-- -- Drop and recreate the 'my_datawarehouse_analytics' database
-- IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'my_datawarehouse_analytics')
-- BEGIN
--     ALTER DATABASE my_datawarehouse_analytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--     DROP DATABASE my_datawarehouse_analytics;
-- END;
-- GO

-- -- Create the 'my_datawarehouse_analytics' database
-- CREATE DATABASE my_datawarehouse_analytics;
-- GO

-- USE my_datawarehouse_analytics;
-- GO

-- -- Create Schemas

-- CREATE SCHEMA gold;
-- GO

-- CREATE TABLE gold.dim_customers(
-- 	customer_key int,
-- 	customer_id int,
-- 	customer_number nvarchar(50),
-- 	first_name nvarchar(50),
-- 	last_name nvarchar(50),
-- 	country nvarchar(50),
-- 	marital_status nvarchar(50),
-- 	gender nvarchar(50),
-- 	birthdate date,
-- 	create_date date
-- );
-- GO

-- CREATE TABLE gold.dim_products(
-- 	product_key int ,
-- 	product_id int ,
-- 	product_number nvarchar(50) ,
-- 	product_name nvarchar(50) ,
-- 	category_id nvarchar(50) ,
-- 	category nvarchar(50) ,
-- 	subcategory nvarchar(50) ,
-- 	maintenance nvarchar(50) ,
-- 	cost int,
-- 	product_line nvarchar(50),
-- 	start_date date 
-- );
-- GO

-- CREATE TABLE gold.fact_sales(
-- 	order_number nvarchar(50),
-- 	product_key int,
-- 	customer_key int,
-- 	order_date date,
-- 	shipping_date date,
-- 	due_date date,
-- 	sales_amount int,
-- 	quantity tinyint,
-- 	price int 
-- );
-- GO

-- TRUNCATE TABLE gold.dim_customers;
-- GO

-- BULK INSERT gold.dim_customers
-- FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.dim_customers.csv'
-- WITH (
-- 	FIRSTROW = 2,
-- 	FIELDTERMINATOR = ',',
-- 	TABLOCK
-- );
-- GO

-- TRUNCATE TABLE gold.dim_products;
-- GO

-- BULK INSERT gold.dim_products
-- FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.dim_products.csv'
-- WITH (
-- 	FIRSTROW = 2,
-- 	FIELDTERMINATOR = ',',
-- 	TABLOCK
-- );
-- GO

-- TRUNCATE TABLE gold.fact_sales;
-- GO

-- BULK INSERT gold.fact_sales
-- FROM 'C:\sql\sql-data-analytics-project\datasets\csv-files\gold.fact_sales.csv'
-- WITH (
-- 	FIRSTROW = 2,
-- 	FIELDTERMINATOR = ',',
-- 	TABLOCK
-- );
-- GO
