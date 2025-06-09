/*
1164. Product Price at a Given Date
Solved
Medium
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+
*/

-- explanation & solution
select distinct a.product_id, coalesce(b.new_price, 10) as price  -- use coalesce() to set / change null value to a spesific default number
from Products as a
left join -- why left join, bcs not all product_id included in certain date (before 16 Aug) so no matter the value is null or not null, we still have to show all product_id
(
    select product_id, rank() over(partition by product_id order by change_date DESC) as xrank, new_price -- only take the latest price before 16 Aug using rank() over() -- sort change_date by descending
    from Products
    where change_date <= '2019-08-16') as b on a.product_id = b.product_id and b.xrank = 1 -- insert date filter
order by 2 DESC -- order by the highest value
