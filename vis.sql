-- query 1
-- table with author id's and their collaborator id's
create table author_collab as
select distinct author.id, temp1.collabid from
author left join (select x.id as authorid, x.pubid, y.id as collabid from authored x left join authored y on y.pubid = x.pubid and y.id != x.id) as temp1
on author.id = temp1.authorid;

-- here the count of collaborators are >= 1
create table a_with_collab as
select id, count(*) as collabcount from author_collab where collabid is not null
group by id;

/* --- this part is abandoned for histogram, but can be kept for scatter plot---
-- get collaborator count statistics
drop table if exists vis1;
create table vis1 as
select collabcount, count(*) as authorcount from a_with_collab
group by collabcount;
*/

COPY (select * from a_with_collab) TO 'D:/1_Database_Systems/DatabasePS1/vis1.csv' DELIMITER ',' CSV HEADER;


-- query 2
-- a table with author id's and their publication id's
create table author_pub as
select distinct author.id, pubid from author left join authored on author.id = authored.id;

-- all authors with publication count >= 0
create table a_with_pub as
select id, count(*) as pubcount from author_pub where pubid is not null
group by id;


COPY (select * from a_with_pub) TO 'D:/1_Database_Systems/DatabasePS1/vis2.csv' DELIMITER ',' CSV HEADER;

/*--- this part is abandoned for histogram, but can be kept for scatter plot---
-- get publication count statistics
drop table if exists vis2;
create table vis2 as
select pubcount, count(*) as authorcount from a_with_pub
group by pubcount;
*/

/*--- this part is abandoned for histogram, but can be kept for scatter plot---
--COPY (select * from vis1) TO 'D:/1_Database_Systems/DatabasePS1/vis1.csv' DELIMITER ',' CSV HEADER;
--COPY (select * from vis2) TO 'D:/1_Database_Systems/DatabasePS1/vis2.csv' DELIMITER ',' CSV HEADER;
--drop table if exists a_with_pub;
--drop table if exists a_with_collab;
*/