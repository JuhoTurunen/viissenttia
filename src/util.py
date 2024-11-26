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
            bibtex.write(f"@{citation_type}")
            bibtex.write(curly_brace_open)
            bibtex.write(f"{citation_key},\n")
            for key, value in citation_dict.items():
                if key not in banned_keys and value:
                    bibtex.write(f"{tab}{key} = {{{value}}},\n")
            bibtex.write(curly_brace_close + "\n")
