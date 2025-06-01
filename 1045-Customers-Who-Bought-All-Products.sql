/*
1045. Customers Who Bought All Products
Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
 

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output: 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: 
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.
*/


-- solution & explanation
SELECT customer_id -- 2) select the column that you want to show
FROM (
    SELECT customer_id, COUNT(DISTINCT product_key) AS num_product
    FROM Customer
    GROUP BY customer_id
) AS a -- 1) create subquery to calculate num of product of each customer_id
WHERE num_product = ( -- count total product of each customer
    SELECT COUNT(DISTINCT product_key) FROM Product -- count total product
) -- filter only customer who buy all products, you can use subquery on where clause
