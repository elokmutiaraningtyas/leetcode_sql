--1148. Article Views I
with cte as
(
select DISTINCT CASE WHEN author_id = viewer_id THEN author_id END as id
from Views
)

select id
from cte
where id is not null
order by id
