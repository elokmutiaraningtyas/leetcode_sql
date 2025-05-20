-- 1581. Customer Who Visited but Did Not Make Any Transactions
/*
Descriptions:
Table 1: Visits
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
visit_id is the column with unique values for this table.
This table contains information about the customers who visited the mall.


Table 2: Transactions

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
transaction_id is column with unique values for this table.
This table contains information about the transactions made during the visit_id.
 

Challenge: Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Return the result table sorted in any order.

The result format is in the following example.


Example 1:

Input: 
Visits
+----------+-------------+
| visit_id | customer_id |
+----------+-------------+
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |
+----------+-------------+
Transactions
+----------------+----------+--------+
| transaction_id | visit_id | amount |
+----------------+----------+--------+
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |
+----------------+----------+--------+
Output: 
+-------------+----------------+
| customer_id | count_no_trans |
+-------------+----------------+
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |
+-------------+----------------+
Explanation: 
Customer with id = 23 visited the mall once and made one transaction during the visit with id = 12.
Customer with id = 9 visited the mall once and made one transaction during the visit with id = 13.
Customer with id = 30 visited the mall once and did not make any transactions.
Customer with id = 54 visited the mall three times. During 2 visits they did not make any transactions, and during one visit they made 3 transactions.
Customer with id = 96 visited the mall once and did not make any transactions.
As we can see, users with IDs 30 and 96 visited the mall one time without making any transactions. Also, user 54 visited the mall twice and did not make any transactions.
*/

-- code & explanations:

-- VER 1 : use NOT IN + subquery

select customer_id, COUNT(customer_id) AS count_no_trans -- select column name, & aggregations (count)
from Visits -- from table name 1
where visit_id NOT IN -- use criteria NOT IN, to show value that not contains in the column 2
( 
    SELECT visit_id FROM Transactions -- write column 2 in this subquery
)
group by 1 -- use group by because you add aggregations, group by the 1st column, you can write the column name, or just write 1 -- as the 1st column


-- VER 2 : use table JOIN and IS NULL on criteria
select customer_id, COUNT(customer_id) AS count_no_trans -- select column name + aggregrtions to count how much visit, since we not count unique value, you still can use either visit_id or customer_id
from Visits as a -- from Table name 1 as primary table, because we need to show all the customer_id in table 1 even though they are not making transactions in table 2
left join Transactions as b USING(visit_id) -- LEFT JOIN table 2, since we want to show all the value of customer_id in table 1, for the primary key, you can connect it with "USING(column_name)" or "ON table_1.(column_name) = table_2.(column_name)"
where b.visit_id IS NULL -- since we only want to show the customer_id that have no visit_id in table 2, so we have to write NULL result as a criteria
group by 1 -- group by 1st column, since the 2nd column is aggregation
