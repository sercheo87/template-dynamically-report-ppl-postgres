import psycopg2 as psycopg2


def execute_query(connection, query):
    cursor = connection.cursor()
    cursor.execute(query)

    rows = cursor.fetchall()
    for row in rows:
        print(row)

    connection.commit()
    cursor.close()


if __name__ == '__main__':
    # Connect to the database postgresql
    connection = psycopg2.connect(
        host='localhost',
        database='dbtools',
        user='postgres',
        password='my123password')

    execute_query(connection, "select url_quote('http://www.google.com')")
