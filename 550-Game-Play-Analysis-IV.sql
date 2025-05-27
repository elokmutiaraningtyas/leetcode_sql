/*
550. Game Play Analysis IV
Solved
Medium
Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation: 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33
*/


-- solution & explanation
-- the calculation we need is the total user that logged again 1 day after the first logged (player_id 1) then divided by total player
-- so first, we should make the calculation to get 1 player that logged again one day after

-- 1st calculation -- get the total of player_id who logged again 1 day after
(
select count(distinct a.player_id)
from Activity a
inner join
  --- only take player_id who logged again the day after the first logged, you can use inner join, then on the connection use datediff, between the date and the first logged, the different day is 1
(select player_id, min(event_date) as first_logged
from Activity
group by 1) as b
on a.player_id = b.player_id and datediff(a.event_date,b.first_logged) = 1
)

-- then divided it with total player to get (1/3)

(
select count(distinct a.player_id)
from Activity a
inner join
(select player_id, min(event_date) as first_logged
from Activity
group by 1) as b
on a.player_id = b.player_id and datediff(a.event_date,b.first_logged) = 1
)

/

(
select count(distinct player_id)
from Activity
)

-- then round it to the 2 decimal places
-- also the final query, named the column as "fraction"

select round(
(
select count(distinct a.player_id)
from Activity a
inner join
(select player_id, min(event_date) as first_logged
from Activity
group by 1) as b
on a.player_id = b.player_id and datediff(a.event_date,b.first_logged) = 1
)

/

(
select count(distinct player_id)
from Activity
)
,2) as fraction

