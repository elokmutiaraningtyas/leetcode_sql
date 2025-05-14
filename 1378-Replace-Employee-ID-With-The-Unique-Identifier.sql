--1378. Replace Employee ID With The Unique Identifier
select b.unique_id, a.name
from Employees as a
left join EmployeeUNI as b on b.id = a.id
