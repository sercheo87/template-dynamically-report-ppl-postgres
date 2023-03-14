FROM postgres:14

RUN apt update && apt install python3 python3-pip postgresql-plpython3-${PG_MAJOR} -y

ENV POSTGRES_PASSWORD mysecretpassword

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432
