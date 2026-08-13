----- Data Exploratory -------

-- TOTAL Orders

SELECT COUNT(*) AS total_order
FROM orders;

-- Date range
SELECT MIN(order_purchase_timestamp), MAX( order_purchase_timestamp)
FROM orders;

-- Order by Status
SELECT
order_status,
COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- Order by Year
SELECT EXTRACT(YEAR FROM order_purchase_timestamp) AS order_year,
COUNT(*) total_orders
FROM orders
GROUP BY EXTRACT(YEAR FROM order_purchase_timestamp)
ORDER BY order_year;

-- Order by MONTH
SELECT EXTRACT(MONTH FROM order_purchase_timestamp)  AS order_month,
COUNT(*) AS total_orders
FROM orders
GROUP BY  EXTRACT(MONTH FROM order_purchase_timestamp) 
ORDER BY order_month;

-- Order by Day of Week
SELECT TO_CHAR(order_purchase_timestamp, 'DAY') AS order_day_of_week,
COUNT(*) AS total_orders
FROM orders
GROUP BY TO_CHAR(order_purchase_timestamp, 'DAY')
ORDER BY  order_day_of_week;

-- Unique Customer
SELECT COUNT(DISTINCT customer_id)
FROM orders;

-- Average Order per Customer
SELECT COUNT(*) / COUNT(DISTINCT customer_id) AS  avg_orders_per_customer
FROM orders;

SELECT
COUNT(*) * 1.0 / COUNT(DISTINCT customer_id) AS avg_orders_per_customer
FROM orders;

--- Total Customer
SELECT COUNT(*) AS total_customer
FROM customers ;

--  Customers by State
SELECT COUNT(customer_id)total_customer, customer_state
FROM customers
GROUP BY customer_state
ORDER BY total_customer DESC;

-- Customers by City
SELECT COUNT(customer_id) AS total_customer , customer_city
FROM customers 
GROUP BY customer_city
ORDER BY total_customer DESC;


-- Top 10 States
SELECT
customer_state,
COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 10;

-- Top 10 Cities
SELECT
customer_city,
COUNT(*) AS total_customers
FROM customers
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;


-- Total Products
SELECT count(*) AS total_products
FROM products
ORDER BY total_products DESC;

-- Categories
SELECT COUNT(DISTINCT product_category_name) AS product_category
FROM products;

-- Products per Category
SELECT product_category_name, COUNT(product_id) AS total_product
FROM products
GROUP BY product_category_name


-- Average Product Weight
SELECT  AVG(product_weight_g) AS avg_weight
FROM products;

-- Average Product Size

-- weight:
SELECT
AVG(product_weight_g) AS avg_weight,
MIN(product_weight_g) AS min_weight,
MAX(product_weight_g) AS max_weight
FROM products;

-- length
SELECT
AVG(product_length_cm) AS avg_length,
MIN(product_length_cm) AS min_length,
MAX(product_length_cm) AS max_length
FROM products;

--  height:
SELECT
AVG(product_height_cm) AS avg_height,
MIN(product_height_cm) AS min_height,
MAX(product_height_cm) AS max_height
FROM products;

-- width:
SELECT
AVG(product_width_cm) AS avg_width,
MIN(product_width_cm) AS min_width,
MAX(product_width_cm) AS max_width
FROM products;

-- Product Name Statistics
SELECT
AVG(product_name_length) AS avg_name_length,
MIN(product_name_length) AS shortest_name,
MAX(product_name_length) AS longest_name
FROM products;


-- Total Sellers
SELECT COUNT(*) AS total_seller
FROM sellers;

-- Sellers by State
SELECT seller_state, COUNT(seller_id) AS total_seller
FROM sellers
GROUP BY seller_state
ORDER BY total_seller DESC;


-- Sellers by City
SELECT seller_city, COUNT(seller_id) AS total_seller
FROM sellers
GROUP BY seller_city
ORDER BY total_seller DESC;


-- Top Seller States
SELECT seller_state, COUNT(seller_id) AS total_seller
FROM sellers
GROUP BY seller_state
ORDER BY total_seller DESC
LIMIT 10;



-- Payment Types
SELECT DISTINCT payment_type
FROM order_payments;

-- Payment Distributio
SELECT
payment_type,
COUNT(*) AS total_payments
FROM order_payments
GROUP BY payment_type
ORDER BY total_payments DESC;



-- Average Payment
SELECT AVG(payment_value) AS avg_value
FROM order_payments


-- Highest Payment
SELECT MAX(payment_value) AS max_value
FROM order_payments

-- Installments
SELECT
payment_installments,
COUNT(*) AS total_orders
FROM order_payments
GROUP BY payment_installments
ORDER BY payment_installments;


--  Average Review
SELECT avg(review_score) AS  avg_review_score
FROM olist_order_reviews;

--  Review Distribution
SELECT
review_score,
COUNT(*) AS total_reviews
FROM olist_order_reviews
GROUP BY review_score
ORDER BY review_score;


-- Reviews with Comments
SELECT   COUNT(review_comment_message) AS reviews_with_comments
FROM olist_order_reviews;

--Reviews without Comments
SELECT COUNT(*) AS reviews_without_comments
FROM olist_order_reviews
WHERE review_comment_message IS NULL;


SELECT
COUNT(*) AS total_reviews,
COUNT(review_comment_message) AS reviews_with_comments,
COUNT(*) - COUNT(review_comment_message) AS reviews_without_comments
FROM olist_order_reviews;




-- Business Analysis

-- Revenue Analysis

SELECT SUM(payment_value) AS total_revenue
FROM  order_payments;

SELECT AVG(payment_value) AS avg_payment
FROM order_payments;

SELECT payment_type, SUM(payment_value) AS highest_revenue
FROM order_payments
GROUP BY payment_type
ORDER BY highest_revenue DESC;

SELECT payment_type , COUNT(*)  AS total_orders
FROM order_payments
GROUP BY payment_type
ORDER BY total_orders DESC;

SELECT EXTRACT(MONTH FROM order_purchase_timestamp) AS monthly_trend, 
       EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
        SUM(op.payment_value) AS total_revenue
FROM orders o
INNER JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY monthly_trend, Year
ORDER BY  Year, monthly_trend;

SELECT EXTRACT(YEAR FROM order_purchase_timestamp) AS YEAR ,
        SUM(op.payment_value) AS total_revenue
FROM orders o
INNER JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY YEAR
ORDER BY  total_revenue DESC;

SELECT EXTRACT(MONTH FROM order_purchase_timestamp) AS MONTH ,
       SUM(op.payment_value) AS total_revenue
FROM orders o  
INNER JOIN order_payments op  
ON o.order_id = op.order_id
GROUP BY MONTH 
ORDER BY total_revenue DESC;

SELECT TO_CHAR(order_purchase_timestamp, 'DAY') AS  order_day_of_week,
               SUM(op.payment_value) AS total_revenue
FROM orders o  
INNER JOIN order_payments op  
ON o.order_id = op.order_id
GROUP BY order_day_of_week
ORDER BY total_revenue DESC;


-- Customer Analysis

SELECT 
    c.customer_unique_id,
    SUM(op.payment_value) AS total_spent
FROM customers c 
INNER JOIN orders o  
    ON c.customer_id = o.customer_id
INNER JOIN order_payments op   
    ON o.order_id = op.order_id
GROUP BY c.customer_unique_id 
ORDER BY total_spent DESC
LIMIT 1;

SELECT c.customer_unique_id,
        SUM(op.payment_value) AS total_spend
FROM customers c
INNER JOIN orders o 
ON c.customer_id = o.customer_id
INNER JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY c.customer_unique_id
ORDER BY total_spend DESC
LIMIT 10;

SELECT c.customer_state, 
        SUM(op.payment_value)  AS  state_highest_revenue
FROM customers c    
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_payments op   
ON o.order_id = op.order_id
GROUP BY customer_state
ORDER BY state_highest_revenue DESC;


SELECT c.customer_city, 
        SUM(op.payment_value) AS city_highest_revenue
FROM customers c    
INNER JOIN  orders o  
ON  c.customer_id = o.customer_id
INNER JOIN order_payments op    
ON o.order_id = op.order_id
GROUP BY customer_city
ORDER BY  city_highest_revenue DESC;



SELECT c.customer_unique_id,
        SUM(op.payment_value) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_payments op
ON o.order_id  = op.order_id
GROUP BY customer_unique_id
ORDER BY total_spent DESC 
LIMIT 1;

SELECT c.customer_unique_id ,
        AVG(op.payment_value) AS avg_spending_customer
FROM customers c    
INNER JOIN orders o   
ON c.customer_id = o.customer_id
INNER JOIN order_payments op   
ON o.order_id = op.order_id
GROUP BY customer_unique_id
ORDER BY avg_spending_customer DESC
LIMIT 1;

SELECT c.customer_unique_id , 
     SUM(op.payment_value) / COUNT (DISTINCT o.order_id) AS  highest_avg_order_value
FROM customers c   
INNER JOIN orders o
ON c.customer_id = o.customer_id
INNER JOIN order_payments  op    
ON o.order_id = op.order_id 
GROUP BY c.customer_unique_id
ORDER BY highest_avg_order_value DESC
LIMIT 1;



-- Product Analysis

SELECT p.product_category_name ,
        SUM(oi.price) AS product_highest_revenue
FROM orders o
INNER JOIN order_items oi           
    ON o.order_id = oi.order_id
INNER JOIN order_payments op          
    ON oi.order_id = op.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id 
GROUP BY product_category_name
ORDER BY  product_highest_revenue DESC
LIMIT 1;

SELECT p.product_category_name,
      COUNT(*) AS  total_products_sold
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY product_category_name 
ORDER BY  total_products_sold DESC
LIMIT 1;

SELECT
    p.product_category_name,
    COUNT(*) AS total_sold
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_sold DESC
LIMIT 10;


SELECT p.product_category_name,
        ROUND(AVG(oi.price), 2) AS avg_selling 
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY product_category_name
ORDER BY avg_selling DESC
LIMIT 1;

SELECT p.product_category_name,
        SUM(oi.freight_value) AS total_freight_cost
FROM products p
INNER JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY product_category_name
ORDER BY total_freight_cost DESC;

SELECT p.product_category_name,
        ROUND(AVG(oor.review_score), 0) AS avg_review_score
FROM olist_order_reviews oor   
INNER JOIN orders o   
ON oor.order_id = o.order_id
INNER JOIN order_items oi   
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name 
ORDER BY avg_review_score DESC;


-- sales
-- 
 SELECT SUM(payment_value) AS total_revenue
 FROM order_payments;

 SELECT COUNT(*)
 FROM orders;

 SELECT COUNT(DISTINCT customer_unique_id)
 FROM customers;

SELECT SUM(op.payment_value) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM order_payments op
LEFT JOIN orders o
ON op.order_id = o.order_id;

SELECT  EXTRACT(MONTH  FROM order_purchase_timestamp) AS MONTH,
        EXTRACT(YEAR  FROM order_purchase_timestamp) AS YEAR,
        SUM(op.payment_value) total_revenue
    FROM orders o
LEFT JOIN order_payments op
ON o.order_id = op.order_id
GROUP BY Year, MONTH
ORDER BY Year, MONTH;


SELECT
    p.product_category_name,
    SUM(oi.price) AS total_revenue
FROM products p
INNER JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;


--- Customer Analysis

SELECT c.customer_unique_id , 
      SUM(op.payment_value) AS customer_total_revenue
FROM customers c
INNER JOIN orders o                                   
ON c.customer_id = o.customer_id
INNER JOIN order_payments op             
ON o.order_id = op.order_id 
GROUP BY C.customer_unique_id
ORDER BY customer_total_revenue DESC
LIMIT 10;

SELECT COUNT(DISTINCT customer_state)
FROM customers;

SELECT c.customer_state,
        SUM(oi.payment_value) AS total_revenue
FROM customers c
INNER JOIN orders o                                   
ON c.customer_id = o.customer_id
INNER JOIN order_payments oi               
ON o.order_id = oi.order_id 
GROUP BY c.customer_state
ORDER BY total_revenue DESC
LIMIT 10;


--- Product  Analysis
SELECT p.product_category_name,
    COUNT(*) AS product_sold
FROM order_items oi    
INNER JOIN products p    
ON oi.product_id = p.product_id
GROUP BY p.product_category_name 
ORDER BY product_sold DESC   ;


SELECT p.product_id,
    SUM(oi.price) AS selling_product
FROM order_items oi    
INNER JOIN products p    
ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY selling_product DESC 
LIMIT 10;


--- Seller Analysis

SELECT COUNT(DISTINCT seller_state)
FROM sellers;

SELECT
    seller_id,
    SUM(price) AS total_revenue
FROM olist_order_items_dataset
GROUP BY seller_id
ORDER BY total_revenue DESC
LIMIT 10;

-- Payment Analysis
SELECT DISTINCT payment_type
FROM order_payments;

SELECT payment_type, 
        COUNT(*) AS total_payment
FROM order_payments
GROUP BY payment_type
ORDER BY total_payment DESC;


SELECT payment_type,
        SUM(payment_value) AS highest_revenue
FROM order_payments
GROUP BY payment_type
ORDER BY highest_revenue DESC;


---Review Analysis

SELECT 
      ROUND( AVG(review_score), 2 ) AS avg_review_score
FROM olist_order_reviews;

SELECT review_score,
    COUNT(*) AS total_score
FROM olist_order_reviews
GROUP BY review_score
ORDER BY total_score DESC;


SELECT
    p.product_category_name,
    ROUND(AVG(oor.review_score)) AS avg_review_score
FROM olist_order_reviews oor
INNER JOIN orders o
    ON oor.order_id = o.order_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_review_score DESC;
