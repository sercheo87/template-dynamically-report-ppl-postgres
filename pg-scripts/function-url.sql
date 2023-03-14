CREATE OR REPLACE FUNCTION url_quote(url text)
    RETURNS TEXT
AS
$$
    from urllib.parse import quote
    return quote(url)

$$
    LANGUAGE plpython3u;


SELECT url_quote('https://www.postgresql.org/docs/12/plpython-data.html#id-1.8.11.11.3');
