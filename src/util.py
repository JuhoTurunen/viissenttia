from entities.citation import Article

class UserInputError(Exception):
    pass


def citation_data_to_class(form):
    result = None
    if form.get("type") == "article":
        result = Article(
            key=form.get("key"), # Required
            author=form.get("author"), # Required
            title=form.get("title"), # Required
            journal=form.get("journal"), # Required
            year=form.get("year"), # Required
            volume=form.get("volume"),
            number=form.get("number"),
            pages=form.get("pages"),
            month=form.get("month"),
            note=form.get("note")
        )

    return result