import os.path
from entities.citation import Article


class UserInputError(Exception):
    pass


def citation_data_to_class(form):
    result = None
    if form.get("type") == "article":
        result = Article(
            key=form.get("key"),  # Required
            author=form.get("author"),  # Required
            title=form.get("title"),  # Required
            journal=form.get("journal"),  # Required
            year=form.get("year"),  # Required
            created_at=form.get("created_at"),
            volume=form.get("volume"),
            number=form.get("number"),
            pages=form.get("pages"),
            month=form.get("month"),
            note=form.get("note"),
        )

    return result


def citation_class_to_bibtex_file(list):
    curly_brace_open = "{"
    curly_brace_close = "}"
    banned_keys = {"created_at", "type", "key"}
    file_path = os.path.join(f"{os.path.dirname(__file__)}/bibtex_files/", "citations.bib")
    with open(file_path, "w", encoding="utf-8") as bibtex:
        for form_as_class in list:
            form = vars(form_as_class)
            type = form.get("type")
            formkey = form.get("key")
            tab = "\t"
            bibtex.write(f"@{type}")
            bibtex.write(curly_brace_open)
            bibtex.write(f"{formkey},\n")
            for key, value in form.items():
                if key not in banned_keys and value:
                    bibtex.write(f"{tab}{key} = {{{value}}},\n")
            bibtex.write(curly_brace_close + "\n")
