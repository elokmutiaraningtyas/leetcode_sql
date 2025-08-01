/*
180. Consecutive Numbers
Medium
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
*/


-- solution & explanation
Select distinct(num) as ConsecutiveNums
from(
    Select id, num,
    lag(num) over(order by id) as prev_num, -- use lag() to get the value of prev row
    lead(num) over(order by id) as next_num -- use lead() to get the value of next row
    from Logs
) a
where a.num = a.prev_num and a.prev_num = a.next_num -- the logic is, prev row = current row = next row
