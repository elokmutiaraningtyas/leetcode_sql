--1581. Customer Who Visited but Did Not Make Any Transactions
with cte as
(
select a.customer_id, a.visit_id, b.transaction_id, b.amount
from Visits as a
left join Transactions as b on b.visit_id = a.visit_id
)

select distinct customer_id, count(distinct case when transaction_id is null then visit_id end) as count_no_trans
from cte
where transaction_id is null
group by 1
