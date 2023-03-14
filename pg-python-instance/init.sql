CREATE DATABASE dbtools;

CREATE USER myuser WITH PASSWORD 'mypassword';

GRANT ALL PRIVILEGES ON DATABASE dbtools TO myuser;

\c dbtools

-- Add extension support pl/python
CREATE EXTENSION IF NOT EXISTS plpython3u;
