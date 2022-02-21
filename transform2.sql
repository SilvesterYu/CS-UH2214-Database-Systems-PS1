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

-------------------------------- run this after having ublication table--------------------------
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

insert into book 
(select distinct pubid, a.v as publisher, b.v as isbn from publication join pub on pub.pubk = pubkey 
left join field a on a.k = pubkey and a.p = 'publisher'
left join field b on b.k = pubkey and b.p = 'isbn'
where pub.pubp = 'book') ;

alter table book
add foreign key (pubid) references publication(pubid);


------------------------------------- populate article table ---------------------------------------

drop table if exists article;
create table Article(
	pubid integer not null,
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

insert into article
(select distinct pubid, a.v as journal, b.v as month, c.v as volume, d.v as number from publication join pub on pub.pubk = publication.pubkey 
left join field a on a.k = publication.pubkey and a.p = 'journal' 
left join field b on b.k = publication.pubkey and b.p = 'month'
left join field c on c.k = publication.pubkey and c.p = 'volume'
left join field d on d.k = publication.pubkey and d.p = 'number'
where pub.pubp = 'article');

alter table article
add foreign key (pubid) references publication(pubid);


------------------------------------- populate inproceedings table ---------------------------------------

drop table if exists inproceedings;
create table Inproceedings(
	pubid integer not null,
	booktitle text,
	editor text
);

delete from inproceedings;
alter table inproceedings
drop constraint if exists inproceedings_unique_pubid;
alter table inproceedings
drop constraint if exists inproceedings_pkey;

insert into inproceedings
(select distinct pubid, a.v as booktitle, b.v as editor from publication join pub on pub.pubk = publication.pubkey 
left join field a on a.k = publication.pubkey and a.p = 'booktitle'
left join field b on b.k = publication.pubkey and b.p = 'editor'
where pub.pubp = 'inproceedings') ;

alter table inproceedings
add foreign key (pubid) references publication(pubid);

------------------------------------- populate incollection table ---------------------------------------

drop table if exists incollection;
create table incollection(
	pubid integer not null,
	booktitle text,
	publisher text,
	isbn text
);

delete from incollection;
alter table incollection
drop constraint if exists incollection_unique_pubid;
alter table incollection
drop constraint if exists incollection_pkey;

insert into incollection
(select distinct pubid, a.v as booktitle, b.v as publisher, c.v as isbn from publication join pub on pub.pubk = publication.pubkey 
left join field a on a.k = publication.pubkey and a.p = 'booktitle'
left join field b on b.k = publication.pubkey and b.p = 'publisher'
left join field c on c.k = publication.pubkey and c.p = 'isbn'
where pub.pubp = 'incollection') ;

alter table incollection
add foreign key (pubid) references publication(pubid);













