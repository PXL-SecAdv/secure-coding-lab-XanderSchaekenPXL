CREATE DATABASE pxldb;
\c pxldb;

CREATE EXTENSION IF NOT EXISTS pgcrypto; 

CREATE USER secadv WITH PASSWORD 'ilovesecurity';
GRANT ALL PRIVILEGES ON DATABASE pxldb TO secadv;

BEGIN;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_name TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
);

GRANT ALL PRIVILEGES ON TABLE users TO secadv;

INSERT INTO users (user_name, password) VALUES ('pxl-admin', crypt('insecureandlovinit', gen_salt('bf')));
INSERT INTO users (user_name, password) VALUES ('george', crypt('iwishihadbetteradmins', gen_salt('bf')));

COMMIT;

