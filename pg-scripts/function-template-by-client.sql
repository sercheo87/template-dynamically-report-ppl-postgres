CREATE
OR REPLACE FUNCTION f_template_by_client(id_client text)
    RETURNS TEXT
AS
$$
    import json

    plan_client = plpy.prepare("SELECT f_read_client($1)", ["text"])
    rows_client = plan_client.execute([id_client], 1)

    if rows_client is None:
        plpy.notice("Client not found")
        return None

    client_data = json.loads(rows_client[0]['f_read_client'].replace("'", "\""))

    plan_template = plpy.prepare("SELECT f_read_templates($1)", ["text"])
    rows_template = plan_template.execute([client_data['templateConfiguration']['id']], 1)

    if rows_template is None:
        plpy.notice("Template not found")
        return None

    template_data = json.loads(rows_template[0]['f_read_templates'].replace("'", "\""))

    plpy.notice(client_data)
    plpy.notice(template_data)

    filtered_columns = []
    for columnId in client_data['templateConfiguration']['columnsId']:
        for column_template in template_data['columns']:
            if columnId == column_template['id']:
                filtered_columns.append(column_template)

    filtered_columns = sorted(filtered_columns, key=lambda k: k['order'])

    client_data['templateConfiguration'] = filtered_columns

    return json.dumps(client_data)

$$
    LANGUAGE plpython3u;


SELECT f_template_by_client('001');
