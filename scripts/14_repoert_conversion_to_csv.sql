/*
===============================================================================
Report Conversion
===============================================================================
Purpose:
    - converting report to csv
===============================================================================
*/

-- run these on psql

\c my_datawarehouse_analytics;

\COPY (SELECT * FROM gold.report_customers) TO 'E:/8_Data_Analysis/1_EDA_and_AdvancedAnalytics/reports/gold.report_customers.csv' CSV HEADER;
\COPY (SELECT * FROM gold.report_products) TO 'E:/8_Data_Analysis/1_EDA_and_AdvancedAnalytics/reports/gold.report_products.csv' CSV HEADER;