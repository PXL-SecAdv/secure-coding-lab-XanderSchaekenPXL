create database pxldb;
\c pxldb

create user secadv with password 'ilovesecurity';
grant all privileges on database pxldb to secadv;
BEGIN;

create table users (id serial primary key, user_name text not null unique, password text not null);
grant all privileges on table users to secadv;

INSERT INTO users (user_name, password_hash) VALUES ('pxl-admin', crypt('insecureandlovinit', gen_salt('sha256')));
INSERT INTO users (user_name, password_hash) VALUES ('george', crypt('iwishihadbetteradmins', gen_salt('sha256')));

COMMIT;
