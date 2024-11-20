from datetime import datetime

class CitationBase:
    def __init__(self, key, citation_type, created_at=None):
        self.key = key
        self.type = citation_type
        self.created_at = created_at or datetime.now()


class Article(CitationBase):
    def __init__(
        self,
        key,
        author,
        title,
        journal,
        year,
        created_at=None,
        volume=None,
        number=None,
        pages=None,
        month=None,
        note=None,
    ):
        # Call CitationBase class __init__
        super().__init__(key=key, citation_type="article", created_at=created_at)

        # Initialize specific attributes for the Article class
        self.author = author
        self.title = title
        self.journal = journal
        self.year = year
        self.volume = volume
        self.number = number
        self.pages = pages
        self.month = month
        self.note = note

    def __str__(self):
        return (
            f"Article(key={self.key}, author={self.author}, title={self.title}, "
            f"journal={self.journal}, year={self.year}, volume={self.volume}, "
            f"number={self.number}, pages={self.pages}, month={self.month}, "
            f"note={self.note}, created_at={self.created_at})"
        )