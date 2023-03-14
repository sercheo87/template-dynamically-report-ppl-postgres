.PHONY: up-server build-functions

up-server:
	echo "Starting server"
	cd pg-python-instance && docker-compose up -d

build-functions:
	echo "Building functions"
	docker-compose exec postgres psql -U postgres -d my123password -c "CREATE EXTENSION IF NOT EXISTS plpython3u;" && \
    docker-compose exec postgres psql -U postgres -d my123password -f /pg-scripts/function-template-by-client.sql && \
    docker-compose exec postgres psql -U postgres -d my123password -f /pg-scripts/function-read-client.sql && \
    docker-compose exec postgres psql -U postgres -d my123password -f /pg-scripts/function-template-by-client.sql && \
    docker-compose exec postgres psql -U postgres -d my123password -f /pg-scripts/function_generate_report.sql
