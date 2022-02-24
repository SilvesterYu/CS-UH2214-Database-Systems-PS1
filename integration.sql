-- !!to view results from each one, please comment out the rest of the questions!!

-- Question 1:
drop table if exists journal_ranking;
create table journal_ranking(
	jkey text not null,
	title text,
	rank text,
	dblp text
);

drop table if exists conference_ranking;
create table conference_ranking(
	ckey text not null,
	title text,
	rank text,
	dblp text
);

-- Question 2:
-- !!!!!!! change the absolute path here before running !!!!!!!
COPY conference_ranking
FROM 'D:\1_Database_Systems\DatabasePS1\conference_ranking.csv'
DELIMITER ',' CSV HEADER;

-- !!!!!!! change the absolute path here before running !!!!!!!
COPY journal_ranking
FROM 'D:\1_Database_Systems\DatabasePS1\journal_ranking.csv'
DELIMITER ',' CSV HEADER;

alter table conference_ranking
add primary key (ckey);
alter table journal_ranking
add primary key (jkey);


-- Question 3:
-- for conferences
drop table if exists pubkey_rank;
create table pubkey_rank as
select distinct pubkey, rank from inproceedings join publication on inproceedings.pubid = publication.pubid, conference_ranking
where pubkey like concat(ckey, '%');
-- remove invalid ranks
delete from pubkey_rank where rank = 'unranked:NEW' or rank = 'Unranked: NEW' or rank = 'Unranked' or rank = 'NEW' or rank = 'Journal Published' or rank = 'journal published' or rank = 'Journal published'; 
-- the table for conference percentage
drop table if exists conference_distribution;
create table conference_distribution as
select rank, count(*) as  number_of_publications, concat(cast((cast(count(*) as decimal)/(select count(*) from publication as total)*100)as text), '%') as percentage from pubkey_rank group by rank;
select * from conference_distribution;

-- for journals
drop table if exists pubkey_rank2;
create table pubkey_rank2 as
select distinct pubkey, rank from article join publication on article.pubid = publication.pubid, journal_ranking
where pubkey like concat(jkey, '%');
-- remove invalid ranks
--delete from pubkey_rank2 where rank = 'not primarily CS' or rank = 'Not primarily CS' or rank = 'Not ranked'   or rank = 'Survey review' or rank = 'survey/review' or rank = 'Survey/review' or rank = 'survey/review journal' or rank = 'Survey/review journal';       
-- the table for journal percentage
drop table if exists journal_distribution;
create table journal_distribution as
select rank, count(*) as  number_of_publications, concat(cast((cast(count(*) as decimal)/(select count(*) from publication as total)*100)as text), '%') as percentage from pubkey_rank2 group by rank;
select * from journal_distribution;


-- Question 4:
drop table if exists top_author_pub;
create table top_author_pub as
select id, publication.pubkey from authored, publication join inproceedings on inproceedings.pubid = inproceedings.pubid
where id in (select id from authored group by id order by count(*) limit 100)
and authored.pubid = publication.pubid;

-- select only [conference] papers for the top 100 authors
drop table if exists top_author_conference_paper;
create table top_author_conference_paper as
select distinct pubkey from top_author_pub where pubkey in 
(select distinct pubkey from inproceedings, publication where publication.pubid = inproceedings.pubid);

drop table if exists top_conf_rank;
create table top_conf_rank as
select distinct pubkey, rank from top_author_conference_paper, conference_ranking
where pubkey like concat(ckey, '%');

drop table if exists top_distribution;
create table top_distribution as
select rank, count(*) as  number_of_publications, concat(cast((cast(count(*) as decimal)/(select count(distinct pubkey) from top_author_conference_paper as total)*100)as text), '%') as percentage from top_conf_rank group by rank;
select * from top_distribution;

-- drop table if exists top_author_pub;
-- drop table if exists top_pubkey_rank




