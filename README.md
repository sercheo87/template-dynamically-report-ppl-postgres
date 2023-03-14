# template-dynamically-report-ppl-postgres

## Description

This project is used to generate a report of a client by custom configuration inside **Postgres SQL** using [Python Procedural Language](https://www.postgresql.org/docs/14/plpython.html).

## Characteristics

- The report is generated dynamically by the configuration of the client.
- The configuration is stored in file ***Json*** in server database.
- The configuration client is stored in file ***Json*** in server database.
- All utility used are **functions** in **Postgres SQL** with **Python 3 Language**.

## Requirements

- Instance of **Postgres SQL v14**.
- Install **Python 3** in server.

## Installation

### Automatic Installation

```bash
make up-server
make build-functions
```

### Manual

Up the instance of **Postgres SQL v14**.

```bash
cd ./pg-python-instance
docker-compose up -d
``` 

Connect to server with:

- Host: **localhost**
- Port: **5432**
- User: **postgres**
- Password: **my123password**

Install **Python 3 Extension** in server.

```bash
docker-compose exec postgres psql -U postgres -d my123password -c "CREATE EXTENSION IF NOT EXISTS plpython3u;"
```

Create function base of templates configuration.

```bash
docker-compose exec postgres psql -U postgres -d my123password -f /pg-scripts/function-template-by-client.sql
```

Create function base of client configuration.

```bash
docker-compose exec postgres psql -U postgres -d my123password -f /pg-scripts/function-read-client.sql
```

Create function for get configuration by client.

```bash
docker-compose exec postgres psql -U postgres -d my123password -f /pg-scripts/function-template-by-client.sql
```

Create function for generate report.

```bash
docker-compose exec postgres psql -U postgres -d my123password -f /pg-scripts/function_generate_report.sql
```
