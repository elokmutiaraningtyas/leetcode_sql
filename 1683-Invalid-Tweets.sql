--1683. Invalid Tweets
with cte as
(
SELECT tweet_id, content, LENGTH(content) as len
from Tweets
group by 1,2
)

select tweet_id
from cte
where len > 15
