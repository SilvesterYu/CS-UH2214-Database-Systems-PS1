-- Question1
select pub.p, count(*)
from pub
group by pub.p;
-- (article, 2783058) (book, 19254) (incollection, 67674) (inproceedings, 2984445)

-- Question2
select fp from
(select distinct field.p as fp, pub.p as pp from field, pub where field.k = pub.k) as temp1
group by fp
having count(*) >= (select count(distinct p) from pub as num);
-- "author", "ee", "note", "title", "year"

-- Question 3:
create index pub_idx on pub (k, p);
create index field_idx on field(k, p, i, v);
