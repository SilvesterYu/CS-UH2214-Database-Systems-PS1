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
/*
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
left join field a on a.k = pubkey 
left join field b on b.k = pubkey 
where pub.pubp = 'book' and a.p = 'publisher' and b.p = 'isbn';

insert into book (pubid)
(select distinct pubid from book3);

update book set (publisher, isbn) = 
(select publisher, isbn from book3 where book.pubid = book3.pubid limit 1);

alter table book
add constraint book_unique_pubid unique(pubid);

alter table book
add primary key (pubid);
*/

------------------------------------- populate article table ---------------------------------------
/*
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
alter table article
drop constraint if exists article_pkey;

drop table if exists article3;
create table article3 as
select distinct pubid, a.v as journal, b.v as month, c.v as volume, d.v as number from publication join pub on pub.pubk = publication.pubkey 
left join field a on a.k = publication.pubkey 
left join field b on b.k = publication.pubkey 
left join field c on c.k = publication.pubkey 
left join field d on d.k = publication.pubkey 
where pub.pubp = 'article' and a.p = 'journal' and b.p = 'month' and c.p = 'volume' and d.p = 'number';

Do
$do$
begin
raise notice 'done creating article3';
insert into article (pubid, journal, month, volume, number)
(select pubid, journal, month, volume, number from article3);
raise notice 'inserted into article';

alter table article
add constraint article_unique_pubid unique(pubid);

alter table article
add primary key (pubid);
end;
$do$;
*/
















