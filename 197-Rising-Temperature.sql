-- 197. Rising Temperature
/*
Descriptions:
Table: Weather
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 
Challenge:
Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.


Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).
*/

-- code & explanations:

with cte as -- since we want to show previous data, we have to use window function, it cant be used in where clause, hence we need to create subquery or CTE to create new column
(
    select id, recordDate, temperature, -- select column name
        lag(temperature, 1) over (order by recordDate) as prev_temperature, -- use LAG(column_name) to show previous data or use LEAD(column_name) to show next data. you still can use lag(column_name) to show next data, but in the order by (... over (order by RecordDate) you should use descending
        lag(recordDate, 1) over (order by recordDate) as prev_recorddate
    from Weather -- from table name
)
  
select id -- final query, select column name
from cte -- from cte name
where temperature > prev_temperature -- where temperature of the lead data is greater than temperature on the prev date
and recordDate = date_add(prev_recorddate, interval 1 day) -- and the interval date between the lead data and previous data is 1 day. use date_add to calculate it
