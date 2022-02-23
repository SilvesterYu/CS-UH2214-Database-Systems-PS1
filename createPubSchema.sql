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
	
create table Authored(
	id integer,
	pubid integer
);

create table Article(
	pubid integer not null,
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
	pubkey text not null,
	booktitle text,
	publisher text,
	isbn text
);

create table Inproceedings(
	pubkey text not null,
	booktitle text,
	editor text
);





