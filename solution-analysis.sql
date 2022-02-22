-- query 1
select author.name from author,
(select id, count(*) from authored
group by id order by count(*) desc limit 20) as temp1
where author.id = temp1.id