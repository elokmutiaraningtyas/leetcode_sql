/*
1193. Monthly Transactions I

Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
*/

SELECT DATE_FORMAT(trans_date,'%Y-%m') as month, -- lets extract the date format become year-month format using DATE_FORMAT(value,'format')
        country, -- select the column that you want to show
        COUNT(id) as trans_count, -- count how much id on every country
        COUNT(CASE WHEN state = 'approved' then id end) as approved_count,  -- then count the 'approved' status using CASE WHEN 
        sum(amount) as trans_total_amount,  -- sum the amount
        coalesce(SUM(case when state = 'approved' then amount end),0) as approved_total_amount -- sum the amount with 'approved' criteria using CASE WHEN
FROM Transactions -- from table name
GROUP BY 1,2 -- group by the 1st and 2nd column since the next column is aggregated
