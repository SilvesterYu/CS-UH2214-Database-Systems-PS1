drop table if exists author cascade;
drop table if exists authored cascade;
drop table if exists publication cascade;
drop table if exists book;
drop table if exists inproceedings;
drop table if exists incollection;
drop table if exists article;

create table Author(
	id serial not null primary key,
	name text unique,
	homepage text
	);
	
create table Publication(
	pubid serial primary key,
	pubkey text,
	title text,
	year text
	);
/*	
create table Authored(
	id integer,
	pubid integer,
	constraint author_pub
	primary key (id, pubid),
	constraint pk_author
	foreign key (id) references Author(id),
	constraint pk_pubid
	foreign key (pubid) references Publication(pubid)
);
*/

create table Authored(
	id integer,
	pubid integer
);

create table Article(
	pubid integer not null primary key,
	journal text,
	month text,
	volume text,
	number text
);

create table Book(
	pubid integer not null,
	publisher text,
	isbn text
);

create table Incollection(
	pubkey text not null primary key,
	booktitle text,
	publisher text,
	isbn text
);

create table Inproceedings(
	pubkey text not null primary key,
	booktitle text,
	editor text
);





