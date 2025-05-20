-- 620. Not Boring Movies
/*
Description:
Table: Cinema

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
id is the primary key (column with unique values) for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]
 

Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".

Return the result table ordered by rating in descending order.

The result format is in the following example.

 

Example 1:

Input: 
Cinema table:
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 1  | War        | great 3D    | 8.9    |
| 2  | Science    | fiction     | 8.5    |
| 3  | irish      | boring      | 6.2    |
| 4  | Ice song   | Fantacy     | 8.6    |
| 5  | House card | Interesting | 9.1    |
+----+------------+-------------+--------+
Output: 
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 5  | House card | Interesting | 9.1    |
| 1  | War        | great 3D    | 8.9    |
+----+------------+-------------+--------+
Explanation: 
We have three movies with odd-numbered IDs: 1, 3, and 5. The movie with ID = 3 is boring so we do not include it in the answer.

*/


-- solution & explanations:
SELECT * -- select all the column, all = *
FROM Cinema -- from table name
WHERE mod(id,2) <> 0 AND description <> 'boring' -- criteria: to show odd number you can use mod(value,2) <> 0 or value % 2 <> 0. mod can also replace by "%". Remember that to show "even number", the logic is "value % 2 = 0"; and for the "odd number" the logic is "value % 2 <> 0". "AND" the 2nd criteria is movie not rated as "boring"
order by rating desc -- order by the highest value in "rating" field

-- hope you can understand, if you need more explanations, contact me : elokmutiaraningtyas@gmail.com or by other channel i attached on the profile
