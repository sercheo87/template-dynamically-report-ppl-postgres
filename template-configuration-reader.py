import json
from dataclasses import dataclass
from typing import List


@dataclass
class Column:
    id: str
    name: str
    order: int
    filled: bool
    fill_character: str
    field_size: int
    mapping_sql_model: str
    field_format_lower: bool
    field_format_upper: bool
    field_format_trim: bool


@dataclass
class Template:
    id: str
    name: str
    enable: bool
    columns: List[Column]


@dataclass
class TemplateConfiguration:
    id: str
    columns_id: List[int]


@dataclass
class Client:
    id: str
    name: str
    template_configuration: TemplateConfiguration


if __name__ == '__main__':
    # Load the JSON from file
    with open('resources/template-configurations/data.json') as f:
        data = json.load(f)

    # Convert the JSON into data classes
    clients = []
    templates = []

    for client_json in data['clients']:
        template_config_json = client_json['templateConfiguration']
        template_config = TemplateConfiguration(
            id=template_config_json['id'],
            columns_id=template_config_json['columnsId']
        )
        client = Client(
            id=client_json['id'],
            name=client_json['name'],
            template_configuration=template_config
        )
        clients.append(client)

    for template_json in data['templates']:
        column_jsons = template_json['columns']
        columns = []
        for column_json in column_jsons:
            column = Column(
                id=column_json['id'],
                name=column_json['name'],
                order=column_json['order'],
                filled=column_json['filled'],
                fill_character=column_json['fillCharacter'],
                field_size=column_json['fieldSize'],
                mapping_sql_model=column_json['mappingSqlModel'],
                field_format_lower=column_json['fieldFormatLower'],
                field_format_upper=column_json['fieldFormatUpper'],
                field_format_trim=column_json['fieldFormatTrim']
            )
            columns.append(column)
        template = Template(
            id=template_json['id'],
            name=template_json['name'],
            enable=template_json['enable'],
            columns=columns
        )
        templates.append(template)

    # Print the data classes
    print('Clients:')
    for client in clients:
        print(client)
