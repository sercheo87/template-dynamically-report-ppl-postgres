CREATE OR REPLACE FUNCTION f_read_client(id_client text)
    RETURNS TEXT
AS
$$
    import json

    with open('/template-configurations/client-configurations.json', 'r') as file:
        clients = json.load(file)

    for client in clients['clients']:
        if client['id'] == id_client and client['active']:
            return client

    return None

$$
    LANGUAGE plpython3u;


SELECT f_read_client('001');

SELECT f_read_client('666');
