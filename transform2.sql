/*
---------------------------- create a merged table with all raw data -----------------------
DO
$do$
    BEGIN
        ALTER TABLE pub
            RENAME COLUMN p TO pubp;
		ALTER TABLE pub
			RENAME COLUMN k TO pubk;
    EXCEPTION
        when undefined_column then raise notice 'pub.p already renamed to pub.pubp';
     END;
$do$;

create table if not exists merged as
	select * from field join pub on field.k = pub.pubk;
	
DO
$do$
begin
	ALTER sequence merged_id_seq RESTART WITH 1;
  	raise notice 'merged.id successfully restarted';
	EXCEPTION WHEN OTHERS THEN
		alter table merged
			add id
			serial primary key;
		raise notice 'merged.id successfully created';
end;
$do$;

create index if not exists merged_index
	on merged(id, k, p, v, pubp);
*/

/*	
----------------------------------populate author table--------------------------------------
-- create table with all authors who has a homepage
drop table if exists awithhomepage;
create table awithhomepage as
select distinct v1, v2 from (select distinct k as k1, v as v1 from merged where p = 'author') as temp1 join (select k as k2, v as v2 from merged where pubp = 'www' and p = 'url') as temp2
on temp1.k1 = temp2.k2;


-- create table with authors who don't have a homepage record

drop table if exists awithouthomepage;
create table awithouthomepage as
select distinct v from merged where p = 'author' except (select v1 from awithhomepage);



-- put into author table the authors with homepage
DO
$do$
declare aname text;
declare ahomepage text;
begin
	for aname in select distinct v1 from awithhomepage a1 loop
		
		select v2 into ahomepage from awithhomepage a1 where a1.v1 = aname limit 1;
		insert into author(name, homepage)
			values(aname, ahomepage);
		raise notice 'value: %', (aname, ahomepage);
	end loop;
end
$do$;

-- put into author table the authors without homepage
DO
$do$
declare aname text;
declare ahomepage text;
begin
	for aname in select distinct v from awithouthomepage a2 loop
		insert into author(name)
			values(aname);
		raise notice 'value: %', aname;
	end loop;
end
$do$;
*/



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


------------------------------- run this after having publication table--------------------------
------------------------------------- populate book table ---------------------------------------

drop table if exists book;
create table Book(
	pubid integer not null,
	publisher text,
	isbn text
);

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

insert into incollection
(select distinct pubid, a.v as booktitle, b.v as publisher, c.v as isbn from publication join pub on pub.pubk = publication.pubkey 
left join field a on a.k = publication.pubkey and a.p = 'booktitle'
left join field b on b.k = publication.pubkey and b.p = 'publisher'
left join field c on c.k = publication.pubkey and c.p = 'isbn'
where pub.pubp = 'incollection') ;

alter table incollection
add foreign key (pubid) references publication(pubid);




------------------------------------------ populate authored table ------------------------------------------
delete from authored;
insert into authored
select distinct id, pubid from
author, publication, field
where author.name = field.v and field.k = publication.pubkey;

------------------------------------------ remove all temporary tables ---------------------------------------
/*
drop table if exists merged;
drop table ir exists awithhomepage;
drop table if exists awithouthomepage;
*/










