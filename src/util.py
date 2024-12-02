import os.path
from entities.citation import CitationBase, Article


class ValidationError(Exception):
    pass


def convert_type(type_class):
    types = {"a number": int, "text": str, "a list": list}
    return next((k for k, v in types.items() if v is type_class), str(type_class))


class Validator:
    def __init__(self, form, front_facing):
        self.form = form
        self.front_facing = front_facing

    def check(self, key, expected, required=False):
        if self.front_facing and expected is list:
            value = self.form.getlist(key) or None
        else:
            value = self.form.get(key) or None
        if required and value is None:
            raise ValidationError(f"Field {key} is required")
        try:
            if value is not None:
                expected(value)
        except Exception as e:
            raise ValidationError(
                f"Field {key} expects {convert_type(expected)}, received {convert_type(type(value))}"
            ) from e
        return value


def citation_data_to_class(form, front_facing=False):
    result = None
    validator = Validator(form, front_facing)

    try:
        if form.get("type") == "article":
            article_authors = validator.check("author", list, True)
            year = validator.check("year", int, True)
            result = Article(
                author=article_authors,
                title=validator.check("title", str, True),
                journal=validator.check("journal", str, True),
                year=year,
                key=f"{article_authors[0].split()[-1]}{year}",
                created_at=validator.check("created_at", str),
                volume=validator.check("volume", int),
                number=validator.check("number", int),
                pages=validator.check("pages", str),
                month=validator.check("month", int),
                note=validator.check("note", str),
            )
    except ValidationError as e:
        print(e.args[0])
        return e.args[0] if front_facing else result

    return result


def get_citation_types():
    return [citation_type.__name__.lower() for citation_type in CitationBase.__subclasses__()]

def citation_class_to_bibtex_file(citation_list):
    curly_brace_open = "{"
    curly_brace_close = "}"
    banned_keys = {"created_at", "type", "key"}
    file_path = os.path.join(f"{os.path.dirname(__file__)}/bibtex_files/", "citations.bib")
    with open(file_path, "w", encoding="utf-8") as bibtex:
        for citation_class in citation_list:
            citation_dict = vars(citation_class)
            citation_type = citation_dict.get("type")
            citation_key = citation_dict.get("key")
            tab = "\t"
            authors=""
            bibtex.write(f"@{citation_type}")
            bibtex.write(curly_brace_open)
            bibtex.write(f"{citation_key},\n")
            for key, value in citation_dict.items():
                if key == "author":
                    for author in value:
                        if author:
                            authors += author + " and "
                    authors=authors[:-5]
                    value=authors
                if key not in banned_keys and value:
                    bibtex.write(f"{tab}{key} = {{{value}}},\n")
            bibtex.write(curly_brace_close + "\n")


def sql_insert_writer(type,citation_dictionary):
    tables={"article":"articles","book":"books","inproceedings":"inproceedings"}
    table=tables[type]
    banned_keys={"created_at", "type", "key"}
    keys=""
    values=""
    for key in citation_dictionary:
        if key not in banned_keys:
            keys+=f"{key}, "
            values+=f":{key}, "
    keys=keys[:-2]
    values=values[:-2]
    insert_command=f"INSERT INTO {table} ({keys}) VALUES ({values})"
    return insert_command
