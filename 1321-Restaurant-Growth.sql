/*
1321. Restaurant Growth
Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Customer table:
+-------------+--------------+--------------+-------------+
| customer_id | name         | visited_on   | amount      |
+-------------+--------------+--------------+-------------+
| 1           | Jhon         | 2019-01-01   | 100         |
| 2           | Daniel       | 2019-01-02   | 110         |
| 3           | Jade         | 2019-01-03   | 120         |
| 4           | Khaled       | 2019-01-04   | 130         |
| 5           | Winston      | 2019-01-05   | 110         | 
| 6           | Elvis        | 2019-01-06   | 140         | 
| 7           | Anna         | 2019-01-07   | 150         |
| 8           | Maria        | 2019-01-08   | 80          |
| 9           | Jaze         | 2019-01-09   | 110         | 
| 1           | Jhon         | 2019-01-10   | 130         | 
| 3           | Jade         | 2019-01-10   | 150         | 
+-------------+--------------+--------------+-------------+
Output: 
+--------------+--------------+----------------+
| visited_on   | amount       | average_amount |
+--------------+--------------+----------------+
| 2019-01-07   | 860          | 122.86         |
| 2019-01-08   | 840          | 120            |
| 2019-01-09   | 840          | 120            |
| 2019-01-10   | 1000         | 142.86         |
+--------------+--------------+----------------+
Explanation: 
1st moving average from 2019-01-01 to 2019-01-07 has an average_amount of (100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
2nd moving average from 2019-01-02 to 2019-01-08 has an average_amount of (110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
3rd moving average from 2019-01-03 to 2019-01-09 has an average_amount of (120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
4th moving average from 2019-01-04 to 2019-01-10 has an average_amount of (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86
*/

-- solution & explanation:

-- first, we have to grouping the amount by unique date

SELECT visited_on, sum(amount) as total
    FROM Customer
    GROUP BY 1
--it will resulting like this:
  /*
| visited_on | total |
| ---------- | ----- |
| 2019-01-01 | 100   |
| 2019-01-02 | 110   |
| 2019-01-03 | 120   |
| 2019-01-04 | 130   |
| 2019-01-05 | 110   |
| 2019-01-06 | 140   |
| 2019-01-07 | 150   |
| 2019-01-08 | 80    |
| 2019-01-09 | 110   |
| 2019-01-10 | 280   |
*/

-- second, we have to calculate the moving average. using the sum() over() for cumulative sum, and avg() over() for cummulative average. Limit only 6 row before untill the current row using "between x perceding and current row"
with cte as
(
    SELECT visited_on, sum(amount) as total
    FROM Customer
    GROUP BY 1
)

-- , moving_average as
-- (
    SELECT visited_on,
            SUM(total) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
            ROUND(AVG(total) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS average_amount,
    DATE_SUB(visited_on, INTERVAL 6 DAY) AS window_start
    FROM cte
    GROUP BY 1
-- )

-- it will be resulting like this:
--Output
/*
| visited_on | amount | average_amount | window_start |
| ---------- | ------ | -------------- | ------------ |
| 2019-01-01 | 100    | 100            | 2018-12-26   |
| 2019-01-02 | 210    | 105            | 2018-12-27   |
| 2019-01-03 | 330    | 110            | 2018-12-28   |
| 2019-01-04 | 460    | 115            | 2018-12-29   |
| 2019-01-05 | 570    | 114            | 2018-12-30   |
| 2019-01-06 | 710    | 118.33         | 2018-12-31   |
| 2019-01-07 | 860    | 122.86         | 2019-01-01   |
| 2019-01-08 | 840    | 120            | 2019-01-02   |
| 2019-01-09 | 840    | 120            | 2019-01-03   |
| 2019-01-10 | 1000   | 142.86         | 2019-01-04   |
*/

-- last, we only want to make the result only show dates with a full 7-day moving average, we need to exclude any date that doesn't have a complete 7-day window behind it.
-- the logic is filter using [window_start] dan only available in [visited_on] -- the last filter is in the last row

with cte as
(
    SELECT visited_on, sum(amount) as total
    FROM Customer
    GROUP BY 1
)

, moving_average as
(
    SELECT visited_on,
            SUM(total) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
            ROUND(AVG(total) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS average_amount,
    DATE_SUB(visited_on, INTERVAL 6 DAY) AS window_start
    FROM cte
    GROUP BY 1
)

SELECT visited_on, amount, average_amount
FROM moving_average
WHERE window_start IN (SELECT visited_on FROM moving_average)
