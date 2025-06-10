/*
626. Exchange Seats
Solved
Medium
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
The ID sequence always starts from 1 and increments continuously.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last one's seat.
*/

-- solution & explanation

-- the simplify the logic of this challenge is : if the id is odd, modify id using "(id) - 1" to change it to the id of prev row
-- after that, to make the previous row become next row, use the logic if the value is even, then modify id using = (id) + 1
-- what if the last value doesnt have pair? use this logic --> if the modified id not in the original table, then keep id as it is
-- you can use [value % 2 = 0] or mod(value,2) = 0 to make modulation operator criteria

---- part 1: table explanation

select *, if(id%2=0,"odd","even") as category, -- or you can also use mod(value,2) = 0 [to flag it as odd], and mod(value,2) = 1 [to flag it as even]
case when id%2=0 then coalesce(lag(id) over(order by id),id) -- then, when its odd, change the id using the prev id with lag()
    when id%2=1 then coalesce(lead(id) over(order by id),id) -- when its even, change the id using the next id with lead()
  -- coalesce used to make NULL result become spesific value as default, in this case, id = 5 will be resulting NULL bcs it is the last row, if we use coalesce, we can keep it as it is
    end as new_id
from seat
order by id

-- the table will be resulting like this
/*
| id | student | category | new_id |
| -- | ------- | -------- | ------ |
| 1  | Abbot   | even     | 2      |
| 2  | Doris   | odd      | 1      |
| 3  | Emerson | even     | 4      |
| 4  | Green   | odd      | 3      |
| 5  | Jeames  | even     | 5      |


-- part 2: if you already got the base logic, then we create the real solution
-- notes : only keep the new_id and student
*/
  
select case when id%2=0 then coalesce(lag(id) over(order by id),id)
    when id%2=1 then coalesce(lead(id) over(order by id),id)
    end as id, student
from seat
order by id
