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
-- select * from publication where pubkey like 'conf/acml%'