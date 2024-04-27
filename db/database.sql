create database pxldb;
\c pxldb

create user secadv with password 'ilovesecurity';
grant all privileges on database pxldb to secadv;
BEGIN;

create table users (id serial primary key, user_name text not null unique, password_hash text not null);
grant all privileges on table users to secadv;

insert into users (user_name, password_hash) values ('pxl-admin', 'insecureandlovinit') ;
insert into users (user_name, password_hash) values ('george', 'iwishihadbetteradmins') ;

COMMIT;
