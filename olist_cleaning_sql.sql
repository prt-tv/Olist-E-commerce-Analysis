
-- Data Cleaning & Validation

* Checked the dataset for duplicate records.
* Validated date formats and identified potential date-format inconsistencies.
* Checked for incorrect or invalid values that could affect the analysis.
* Validated the data before performing the analysis.

SELECT *FROM customers;

SELECT customer_id
FROM customers;

SELECT DISTINCT customer_id
FROM customers;

SELECT *,
ROW_NUMBER () OVER(PARTITION BY customer_id,customer_unique_id,customer_zip_code_prefix,customer_city, customer_state)
FROM customers;

WITH duplicate_cte AS (
    SELECT *,
ROW_NUMBER () OVER(PARTITION BY customer_id,customer_unique_id,customer_zip_code_prefix,customer_city, customer_state) AS row_num
FROM customers
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT *
FROM customers
WHERE customer_city IS NULL OR  customer_city = ' '  ;

SELECT DISTINCT customer_id 
FROM customers
WHERE customer_id IS NULL OR customer_id  = '';

SELECT customer_unique_id
FROM customers
WHERE customer_unique_id IS NULL OR customer_unique_id = '';

SELECT customer_zip_code_prefix
FROM customers
WHERE customer_zip_code_prefix IS NULL ;

SELECT customer_city
FROM customers
WHERE customer_city = '';
 

SELECT DISTINCT customer_city
FROM customers;

SELECT DISTINCT customer_state
FROM customers;

SELECT
COUNT(*) total_rows,
COUNT(geolocation_city) ,
COUNT(geolocation_lat),
COUNT(geolocation_lng),
COUNT(geolocation_zip_code_prefix),
COUNT(geolocation_state)
FROM olist_geolocation;

SELECT  DISTINCT geolocation_city, TRIM(geolocation_city)
FROM olist_geolocation
WHERE geolocation_city  = '.';

SELECT  *
FROM olist_geolocation
WHERE geolocation_state IS NULL OR geolocation_state = '';

SELECT COUNT(*),
COUNT(review_comment_title) AS title,
COUNT(review_comment_message) AS message,
COUNT(review_creation_date) AS date,
COUNT(review_answer_timestamp) AS timestame,
COUNT(review_id) AS id,
COUNT(review_score) AS score
FROM olist_order_reviews; 

SELECT COUNT(*)
FROM olist_order_reviews
WHERE review_comment_message IS NULL;

SELECT
    review_score,
    COUNT(*) AS total_reviews,
    COUNT(review_comment_message) AS reviews_with_comments
FROM olist_order_reviews
GROUP BY review_score
ORDER BY review_score;

SELECT DISTINCT review_comment_message, TRIM (review_comment_message)
FROM olist_order_reviews;

SELECT review_comment_title
FROM olist_order_reviews
WHERE review_comment_title IS NULL OR review_comment_title = '';

SELECT review_comment_title
FROM olist_order_reviews
WHERE review_comment_message IS NULL OR review_comment_message = '';

SELECT review_id
FROM olist_order_reviews
WHERE review_id IS NULL OR review_id = '';

SELECT review_score
FROM olist_order_reviews
WHERE review_score < 1
OR review_score > 5 
OR review_score IS NULL;

SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM olist_order_reviews
GROUP BY review_score
ORDER BY review_score;

SELECT DISTINCT review_score
FROM olist_order_reviews

SELECT COUNT(*),
COUNT(order_id) AS order_id,
COUNT(order_item_id) AS item_id,
COUNT(product_id) AS product_id,
COUNT(seller_id) AS seller_id,
COUNT(shipping_limit_date) AS date,
COUNT(price) AS price,
COUNT(freight_value) AS values
FROM order_items;

SELECT *
FROM order_items
WHERE order_id IS NULL OR order_id = '';

SELECT order_item_id
FROM order_items
WHERE order_item_id IS NULL  OR order_item_id < 1 OR order_item_id > 15
ORDER BY order_item_id ASC;

SELECT  *
FROM order_items;

SELECT product_id
FROM order_items
WHERE product_id IS NULL OR product_id = '';

SELECT product_id, TRIM(product_id)
FROM order_items;

SELECT seller_id
FROM order_items
WHERE seller_id IS NULL OR seller_id = '';

SELECT seller_id , TRIM(seller_id)
FROM order_items;

SELECT shipping_limit_date
FROM order_items;

SELECT MAX(price) , MIN(price)
FROM order_items

SELECT price, freight_value
FROM order_items
WHERE price < 1
   OR freight_value < 1;

SELECT COUNT(*) AS free_shipping_orders
FROM order_items
WHERE freight_value =0;SELECT
    CASE
        WHEN freight_value = 0 THEN 'Free Shipping'
        ELSE 'Paid Shipping'
    END AS shipping_type,
    COUNT(*) AS total_orders
FROM order_items
GROUP BY shipping_type;


   
SELECT COUNT(*),
COUNT(order_id) AS order_id,
COUNT(payment_sequential),
COUNT(payment_type) ,
COUNT(payment_installments) ,
COUNT(payment_value)
FROM order_payments;

SELECT *
FROM order_payments;

SELECT  payment_sequential
FROM order_payments
WHERE payment_sequential IS NULL 
AND payment_sequential < 1 OR payment_sequential > 5;

SELECT payment_type
FROM order_payments
WHERE payment_type IS NULL OR payment_type = '';

SELECT DISTINCT payment_type
FROM order_payments;

SELECT payment_installments
FROM order_payments
WHERE payment_installments IS NULL AND payment_installments < 1 OR payment_installments > 5;


SELECT COUNT(*),
COUNT(customer_id) AS customer_id,
COUNT(order_id) AS order_id,
COUNT(order_status) AS status ,
COUNT(order_purchase_timestamp)AS timestamp ,
COUNT(order_approved_at) AS order_approved,
COUNT(order_delivered_carrier_date) AS delivered_date,
COUNT(order_delivered_customer_date) AS deliver_customer_date,
COUNT(order_estimated_delivery_date) AS estimate_delivery_date
FROM orders;

SELECT order_id
FROM orders
WHERE order_id IS NULL OR order_id = ' ';

SELECT customer_id
FROM orders
WHERE customer_id IS NULL OR customer_id = ' ';

SELECT order_purchase_timestamp
FROM orders
WHERE order_purchase_timestamp IS NULL ;

SELECT order_delivered_carrier_date
FROM orders
WHERE order_delivered_carrier_date IS NULL ;

SELECT *
FROM orders
WHERE order_delivered_carrier_date IS NULL;

SELECT
    order_status,
    COUNT(*) AS total_orders,
    COUNT(order_delivered_carrier_date) AS carrier_date_present
FROM orders
GROUP BY order_status
ORDER BY order_status;

SELECT
    order_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_carrier_date,
    order_delivered_customer_date
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_carrier_date IS NULL;

SELECT order_estimated_delivery_date
FROM orders
WHERE order_estimated_delivery_date IS NULL;

SELECT COUNT(*),
COUNT(product_category_name) AS name,
COUNT(product_category_name_english) AS name_english
FROM product_category_name_translation;


SELECT *
FROM product_category_name_translation
WHERE product_category_name IS NULL OR product_category_name = '';

SELECT *
FROM product_category_name_translation
WHERE product_category_name_english IS NULL OR product_category_name_english = '';

SELECT COUNT(*),
COUNT(product_id) AS id,
COUNT(product_category_name) AS name ,
COUNT(product_name_length) AS name_length,
COUNT(product_description_length) AS discription_length ,
COUNT(product_photos_qty) AS photos,
COUNT(product_weight_g)AS weight,
COUNT(product_length_cm) AS length_cm ,
COUNT(product_height_cm) AS height_cm,
COUNT(product_width_cm) AS width_cm
FROM products;

SELECT *
FROM products;

SELECT *
FROM products
WHERE product_id IS NULL OR product_id = ''
UNION 
SELECT *
FROM products
WHERE product_category_name IS NULL OR product_category_name = '';

SELECT
COALESCE(product_category_name, 'Unknown') AS category,
COUNT(*) AS total_products
FROM products
GROUP BY COALESCE(product_category_name, 'Unknown');

SELECT product_category_name , TRIM(product_category_name)
FROM products;

SELECT DISTINCT product_category_name , TRIM(product_category_name)
FROM products;

SELECT *
FROM products
WHERE product_weight_g <= 0
   OR product_length_cm <= 0
   OR product_height_cm <= 0
   OR product_width_cm <= 0;

SELECT *
FROM products
WHERE product_name_length <= 0
   OR product_description_length <= 0;





SELECT COUNT(*),
COUNT(seller_id) AS id,
COUNT(seller_city)  AS city,
COUNT(seller_state)  AS state,
COUNT(seller_zip_code_prefix) AS zip_code
FROM sellers;

SELECT *
FROM sellers
WHERE seller_id IS NULL OR seller_id = ''
UNION 
SELECT *
FROM sellers
WHERE seller_city IS NULL OR seller_city = ''
UNION
SELECT *
FROM sellers
WHERE seller_state IS NULL OR seller_state = '';

SELECT seller_zip_code_prefix
FROM sellers
WHERE seller_zip_code_prefix < 1;