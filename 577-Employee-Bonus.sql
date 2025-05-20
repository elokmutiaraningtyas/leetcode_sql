-- 577. Employee Bonus
/*
Description:
Table 1: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| empId       | int     |
| name        | varchar |
| supervisor  | int     |
| salary      | int     |
+-------------+---------+
empId is the column with unique values for this table.
Each row of this table indicates the name and the ID of an employee in addition to their salary and the id of their manager.
 

Table 2: Bonus

+-------------+------+
| Column Name | Type |
+-------------+------+
| empId       | int  |
| bonus       | int  |
+-------------+------+
empId is the column of unique values for this table.
empId is a foreign key (reference column) to empId from the Employee table.
Each row of this table contains the id of an employee and their respective bonus.
 
Challenge:
Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.

Return the result table in any order.

The result format is in the following example.


Example 1:

Input: 
Employee table:
+-------+--------+------------+--------+
| empId | name   | supervisor | salary |
+-------+--------+------------+--------+
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |
+-------+--------+------------+--------+
Bonus table:
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
Output: 
+------+-------+
| name | bonus |
+------+-------+
| Brad | null  |
| John | null  |
| Dan  | 500   |
+------+-------+
*/


-- code & solutions:

SELECT name, bonus -- select column
FROM Employee -- from table 1 as the primary table, because we want to show all the value no matter there is no result in table 2
LEFT JOIN Bonus USING (empId) -- LEFT JOIN Table 2 since we just want to show all the value on table 1, connecting key is employee ID (empId), since the similar column in table 1 & 2 only 1,  no need to use table alias
where bonus < 1000 or bonus is null -- with criteria, having bonus less than 1000, and no matter if the result in table 2 is NULL, we still want to show all the employee name from table 1, so add IS NULL in the criteria as well
