/*
602. Friend Requests II: Who Has the Most Friends

Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.

The result format is in the following example.

 

Example 1:

Input: 
RequestAccepted table:
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
Output: 
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+
Explanation: 
The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.
*/

-- solution & explanation:
-- first of all, list all the requester and accepter using UNION ALL

-- with cte as
-- (
  SELECT requester_id as id FROM RequestAccepted
  UNION ALL
  SELECT accepter_id as id FROM RequestAccepted
-- )

-- it will resulting like this:
/*
| id |
| -- |
| 1  |
| 1  |
| 2  |
| 3  |
| 2  |
| 3  |
| 3  |
| 4  |
*/

-- second is, count each number, and only take the highest num as the id who have most friends using LIMIT 1
with cte as
(
    SELECT requester_id as id FROM RequestAccepted
UNION ALL
SELECT accepter_id as id FROM RequestAccepted
)

SELECT id, count(id) num
FROM cte
GROUP BY 1
ORDER BY count(id) desc
LIMIT 1
