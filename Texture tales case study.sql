CREATE DATABASE CASET;
USE CASET;

##1

SELECT 
	details.product_name,
	SUM(sales.qty) AS sale_counts
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY details.product_name
ORDER BY sale_counts DESC;


           #### the below code is implicit cross join doesn't provide accurate results so we use inner join only
SELECT product_name, SUM(qty) as total_quantity
FROM product_details,sales
WHERE product_details.price=sales.price
group by product_name
ORDER BY total_quantity DESC;

## 2

SELECT SUM(price * qty) AS total_revenue
FROM sales;

## 3

SELECT SUM(price * qty * discount)/100 AS total_discount
FROM sales;

## 4

SELECT COUNT(DISTINCT txn_id) AS unique_txn
FROM sales;

## 5

WITH cte_transaction_products AS (
	SELECT
		txn_id,
		COUNT(DISTINCT prod_id) AS product_count
	FROM sales
	GROUP BY txn_id
)
SELECT
	ROUND(AVG(product_count)) AS avg_unique_products
FROM cte_transaction_products;


## 6

WITH cte_transaction_discounts AS (
	SELECT
		txn_id,
		SUM(price * qty * discount)/100 AS discount_value
	FROM sales 
	GROUP BY txn_id
)
SELECT
	ROUND(AVG(discount_value)) AS avg_discount_value
FROM cte_transaction_discounts;

## 7

WITH cte_member_revenue AS (SELECT member,txn_id,SUM(price * qty) AS revenue
FROM sales
GROUP BY member,txn_id
)
SELECT member,ROUND(AVG(revenue), 2) AS avg_revenue
FROM cte_member_revenue
GROUP BY member;

## 8

select product_details.product_name,sum(sales.qty*sales.price) as total_rev
from sales
inner join product_details on product_details.price=sales.price
group by product_details.product_name
order by total_rev desc
limit 3;

## 9

SELECT 
	details.segment_id,
	details.segment_name,
	SUM(sales.qty) AS total_quantity,
	SUM(sales.qty * sales.price) AS total_revenue,
	SUM(sales.qty * sales.price * sales.discount)/100 AS total_discount
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY 
	details.segment_id,
	details.segment_name
ORDER BY total_revenue DESC;

## 10 

SELECT 
	details.segment_name,
	details.product_name,
	SUM(sales.qty) AS product_quantity
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY
	details.segment_name,
	details.product_name
ORDER BY product_quantity DESC
LIMIT 5;


##Q11

SELECT 
	details.category_name,
	SUM(sales.qty) AS total_quantity,
	SUM(sales.qty * sales.price) AS total_revenue,
	SUM(sales.qty * sales.price * sales.discount)/100 AS total_discount
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY 
	details.category_name
ORDER BY total_revenue DESC;


##Q12

SELECT 
	details.category_name,
	details.product_name,
	SUM(sales.qty) AS product_quantity
FROM sales AS sales
INNER JOIN product_details AS details
	ON sales.prod_id = details.product_id
GROUP BY
details.category_name,
details.product_name
ORDER BY product_quantity DESC
LIMIT 5;




    

