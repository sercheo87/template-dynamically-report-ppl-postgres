CREATE OR REPLACE FUNCTION f_read_templates(id_template text)
    RETURNS TEXT
AS
$$
    import json

    with open('/template-configurations/template-configurations.json', 'r') as file:
        templates = json.load(file)

    for template in templates['templates']:
        if template['id'] == id_template and template['active']:
            return template

    return None

$$
    LANGUAGE plpython3u;


SELECT f_read_templates('001');
