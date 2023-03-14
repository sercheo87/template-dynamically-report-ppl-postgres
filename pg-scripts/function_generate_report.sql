CREATE OR REPLACE FUNCTION f_generate_report(lot_id numeric)
    RETURNS VOID
AS
$$
    import json
    import datetime

    def concat_fields_query(_fields):
        query = ''
        for field in _fields:
            query += field['mappingSqlModel'] + ', '
        return query[:-2]

    def get_template_by_client(client_id):
        query = plpy.prepare("SELECT f_template_by_client($1)", ["text"])
        data = query.execute([client_id])
        return json.loads(data[0]['f_template_by_client'].replace("'", "\""))

    def get_column_template(_column_name, _template_data):
        for _column in _template_data['templateConfiguration']:
            if _column['name'] == _column_name:
                return _column
        return None

    def apply_format_data(_raw_data, _column_template):
        if _column_template['fieldFormatTrim'] == 'left':
            _raw_data = _raw_data.lstrip()

        if _column_template['fieldFormatTrim'] == 'right':
            _raw_data = _raw_data.rstrip()

        if _column_template['fieldFormatTrim'] == 'all':
            _raw_data = _raw_data.strip()

        if _column_template['fieldFormatCase'] == 'lower':
            _raw_data = _raw_data.lower()

        if _column_template['fieldFormatCase'] == 'upper':
            _raw_data = _raw_data.upper()

        if column_template['format'] is None or len(column_template['format']) == 0:
            return _raw_data

        return column_template['format'].format(raw_data)

    def generate_file_report(_report_data):
        now = datetime.datetime.now()

        filename = "{}/report-data-{}-{}-{}-{}-{}.txt".format('/reports-generated', now.year, now.month, now.day, now.hour, now.minute)

        with open(filename, "w") as file:
            file.writelines(_report_data)

    # Get template by client
    template_data = get_template_by_client('001')
    plpy.notice("Template: " + str(template_data))

    # Get fields to report
    fields = concat_fields_query(template_data['templateConfiguration'])
    plpy.notice("Fields: " + fields)

    # Get data to report
    rows = plpy.execute("SELECT " + str(fields) + " FROM MOCK_DATA t LIMIT 10")

    # Get columns name
    column_names = rows.colnames()
    plpy.notice(column_names)

    # Get data and apply format to each column
    report_data = []
    for row in rows:
        line_report = ''
        for column in column_names:
            column_template = get_column_template(column, template_data)
            raw_data = str(row[column])
            line_report += apply_format_data(raw_data, column_template)

        line_report = line_report[:-2] + '\n'
        plpy.notice("Line: " + line_report)
        report_data.append(line_report)

    # Generate file report
    generate_file_report(report_data)

$$
    LANGUAGE plpython3u;


SELECT f_generate_report(1009);

SELECT t.id, t.first_name, t.card
FROM MOCK_DATA t
LIMIT 10;
