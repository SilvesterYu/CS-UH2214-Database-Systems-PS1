-------------------------run this after merged table has index column-------------------------
--------------------- delete homepage entries before populating publication-----------
/*
delete from merged where
merged.k in (select distinct k from merged where merged.v = 'Home Page');


------------------------------- populate publication3 table --------------------------
drop if exists table publication3;

create table publication3 as
select distinct a.k as pubkey, b.v as title, c.v as year, a.pubp as pubtype from merged a
left join merged b on a.k = b.k and b.p = 'title'
left join merged c on a.k = c.k and c.p = 'year';

--------------------------------- populate publication table -----------------------

drop table if exists publication;
create table Publication(
	pubid serial primary key,
	pubkey text,
	title text,
	year text
	);
	
delete from publication;
alter table publication
drop constraint if exists unique_pubkey;
ALTER sequence publication_pubid_seq RESTART WITH 1;
insert into publication (pubkey, title, year)
(select pubkey, title, year from publication3);

----- delete cuplicate pubkey and keep last
delete from publication where pubid in(
select pubid from (select * from publication where pubkey in
				  (select pubkey from publication
group by pubkey
having count(pubkey) > 1)
				  ) as temp1 limit 1);

alter table publication
add constraint unique_pubkey unique (pubkey);
*/
------------------------------------- populate book table ---------------------------------------

drop table if exists book;
create table Book(
	pubid integer not null,
	publisher text,
	isbn text
);

delete from book;
alter table book
drop constraint if exists book_unique_pubid;

drop table if exists book3;
create table book3 as
select distinct pubid, a.v as publisher, b.v as isbn from publication join pub on pub.pubk = pubkey 
left join field a on a.k = pubkey and a.p = 'publisher'
left join field b on b.k = pubkey and b.p = 'isbn'
where pub.pubp = 'book';

insert into book (pubid)
(select distinct pubid from book3);

update book set (publisher, isbn) = 
(select publisher, isbn from book3 where book.pubid = book3.pubid limit 1);


alter table book
add primary key (pubid);

------------------------------------- populate article table ---------------------------------------

drop table if exists article;
create table Article(
	pubid integer not null primary key,
	journal text,
	month text,
	volume text,
	number text
);

delete from article;
alter table article
drop constraint if exists article_unique_pubid;

drop table if exists article3;
create table article3 as
select distinct pubid, a.v as journal, b.v as month, c.v as volume, d.v as number from publication join pub on pub.pubk = pubkey 
left join field a on a.k = pubkey and a.p = 'journal'
left join field b on b.k = pubkey and b.p = 'month'
left join field c on c.k = pubkey and c.p = 'volume'
left join field d on d.k = pubkey and d.p = 'number'
where pub.pubp = 'article';

insert into article (pubid, journal, month, volume, number)
(select pubid, publisher, isbn from book3);

-- remove duplicate pubid
delete from book where exists(
	select * from book where pubid in(
select pubid from book
group by pubid
having count(pubid) > 1));

alter table book
add primary key (pubid);













