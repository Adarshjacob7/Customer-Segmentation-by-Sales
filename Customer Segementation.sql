create database customer;
use customer;


-- Creating 3 tables- Customers, Products and Orders
-- Importing the 3 data sets into the respective tables

create table customers 
(
customer_id int primary key,
customer_name varchar(100),
email varchar (100),
join_date date
);

create table products 
(
product_id int primary key,
product_name varchar(100),
category varchar(50),
price decimal (10,2)
);

create table orders
(
order_id int,
customer_id int,
product_id int,
order_date date, 
quantity int,
order_amount decimal (10,2) 
);


-- Imports

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Data/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from customers;


LOAD DATA INFILE 'C:/mysql_exports/products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from products;

LOAD DATA INFILE 'C:/mysql_exports/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from orders;

-- CLEANING THE DATASET

-- Check top rows
SELECT * FROM customers LIMIT 5;

-- Check for missing customer IDs in orders
SELECT COUNT(*) FROM orders WHERE customer_id IS NULL;

-- Check negative or zero order amounts
SELECT COUNT(*) FROM orders WHERE order_amount <= 0;


-- COMPUTING THE RFM METRICS USING SQL
-- RFM (Recency, Frequency, Monetary)

-- A Recency (days since last purchase)

WITH last_purchase AS (
    SELECT
        customer_id,
        MAX(order_date) AS last_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    DATEDIFF(CURDATE(), lp.last_order_date) AS recency_days
FROM last_purchase lp
JOIN customers c ON lp.customer_id = c.customer_id;

-- B Frequency (number of orders per customer)

SELECT
    customer_id,
    COUNT(order_id) AS frequency
FROM orders
GROUP BY customer_id;

-- C Monetary (total spent per customer)

SELECT
    customer_id,
    SUM(order_amount) AS monetary
FROM orders
GROUP BY customer_id;

-- D Combine R, F, M into one table

WITH recency AS (
    SELECT
        customer_id,
        DATEDIFF(CURDATE(), MAX(order_date)) AS recency_days
    FROM orders
    GROUP BY customer_id
),
frequency AS (
    SELECT
        customer_id,
        COUNT(order_id) AS frequency
    FROM orders
    GROUP BY customer_id
),
monetary AS (
    SELECT
        customer_id,
        SUM(order_amount) AS monetary
    FROM orders
    GROUP BY customer_id
)
SELECT
    r.customer_id,
    r.recency_days,
    f.frequency,
    m.monetary
FROM recency r
JOIN frequency f ON r.customer_id = f.customer_id
JOIN monetary m ON r.customer_id = m.customer_id;


-- CREATING AND SAVING THE RFM TABLE

CREATE TABLE rfm_table AS
WITH recency AS (
    SELECT
        customer_id,
        DATEDIFF(CURDATE(), MAX(order_date)) AS recency_days
    FROM orders
    GROUP BY customer_id
),
frequency AS (
    SELECT
        customer_id,
        COUNT(order_id) AS frequency
    FROM orders
    GROUP BY customer_id
),
monetary AS (
    SELECT
        customer_id,
        SUM(order_amount) AS monetary
    FROM orders
    GROUP BY customer_id
)
SELECT
    r.customer_id,
    r.recency_days,
    f.frequency,
    m.monetary
FROM recency r
JOIN frequency f ON r.customer_id = f.customer_id
JOIN monetary m ON r.customer_id = m.customer_id;

select * from rfm_table;

SELECT * FROM rfm_table LIMIT 10;

-- ADDING 3 NEW COLUMNS TO TH RFM TABLE NAMELY
-- recency_score, frequency_score, monetary_score

-- Create a New Scored RFM Table

CREATE TABLE rfm_scored AS
WITH r AS (
    SELECT 
        customer_id,
        recency_days,
        frequency,
        monetary,

        -- Recency score (lower is better)
        NTILE(5) OVER (ORDER BY recency_days ASC) AS recency_score,

        -- Frequency score (higher is better)
        NTILE(5) OVER (ORDER BY frequency DESC) AS frequency_score,

        -- Monetary score (higher is better)
        NTILE(5) OVER (ORDER BY monetary DESC) AS monetary_score
    FROM rfm_table
)
SELECT
    *,
    CONCAT(recency_score, frequency_score, monetary_score) AS rfm_score
FROM r;

SELECT * FROM rfm_scored LIMIT 20;


-- CREATING A SEGMENTED RFM TABLE

CREATE TABLE rfm_segmented AS
SELECT 
    customer_id,
    recency_days,
    frequency,
    monetary,
    recency_score,
    frequency_score,
    monetary_score,
    rfm_score,

    CASE
        WHEN recency_score >= 4 AND frequency_score >= 4 AND monetary_score >= 4
            THEN 'Champions'

        WHEN frequency_score >= 4 AND monetary_score >= 3
            THEN 'Loyal Customers'

        WHEN monetary_score = 5
            THEN 'Big Spenders'

        WHEN recency_score = 1 AND frequency_score >= 3
            THEN 'At Risk'

        WHEN recency_score = 1 AND frequency_score <= 2
            THEN 'Hibernating'

        WHEN recency_score = 1 AND frequency_score = 1
            THEN 'Lost Customers'

        WHEN recency_score >= 4 AND frequency_score = 3
            THEN 'Potential Loyalists'

        WHEN recency_score = 5 AND frequency_score = 1
            THEN 'New Customers'

        WHEN recency_score = 3 AND frequency_score BETWEEN 2 AND 3
            THEN 'Need Attention'

        ELSE 'Others'
    END AS customer_segment
FROM rfm_scored;



-- EXPORT THE TABLE

SELECT 'customer_id','recency_days','frequency','monetary','recency_score','frequency_score','monetary_score','rfm_score','customer_segment'
UNION ALL
SELECT customer_id,recency_days,frequency,monetary,recency_score,frequency_score,monetary_score,rfm_score,customer_segment
FROM rfm_segmented
INTO OUTFILE 'C:/mysql_exports/rfm_segmented.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
