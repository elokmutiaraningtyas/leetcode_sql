--197. Rising Temperature
with cte as
(
    select
        id,
        recordDate,
        temperature, 
        lag(temperature, 1) over (order by recordDate) as prev_temperature,
        lag(recordDate, 1) over (order by recordDate) as prev_recorddate
    from
        Weather
)
  
select id 
from cte
where temperature > prev_temperature
AND recordDate = date_add(prev_recorddate, interval 1 day)
