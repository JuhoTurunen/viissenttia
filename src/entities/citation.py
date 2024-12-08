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


class Book(CitationBase):
    def __init__(
        self,
        key,
        author,
        title,
        year,
        publisher,
        created_at=None,
        volume=None,
        series=None,
        address=None,
        edition=None,
        note=None,
    ):
        # Call CitationBase class __init__
        super().__init__(key=key, citation_type="book", created_at=created_at)

        # Initialize specific attributes for the Book class
        self.author = author
        self.title = title
        self.year = year
        self.publisher = publisher
        self.volume = volume
        self.series = series
        self.address = address
        self.edition = edition
        self.note = note

    def __str__(self):
        return (
            f"Book(key={self.key}, author={self.author}, title={self.title}, "
            f"year={self.year}, publisher={self.publisher}, volume={self.volume}, "
            f"series={self.series}, address={self.address}, edition={self.edition}, "
            f"note={self.note}, created_at={self.created_at})"
        )


class Inproceedings(CitationBase):
    def __init__(
        self,
        key,
        author,
        title,
        booktitle,
        year,
        editor=None,
        created_at=None,
        number=None,
        volume=None,
        series=None,
        pages=None,
        address=None,
        month=None,
        organization=None,
        publisher=None,
        note=None,
    ):
        # Call CitationBase class __init__
        super().__init__(key=key, citation_type="inproceedings", created_at=created_at)

        # Initialize specific attributes for the Inproceedings class
        self.author = author
        self.title = title
        self.booktitle=booktitle
        self.year = year
        self.editor=editor
        self.number=number
        self.volume = volume
        self.series = series
        self.pages=pages
        self.address = address
        self.month=month
        self.organization=organization
        self.publisher = publisher
        self.note = note

    def __str__(self):
        return (
            f"Inproceedings(key={self.key}, author={self.author}, title={self.title}, booktitle={self.booktitle}, "
            f"year={self.year}, editor={self.editor}, number={self.number}, "
            f"volume={self.volume}, series={self.series}, pages={self.pages}, "
            f"address={self.address}, month={self.month}, organization={self.organization}, "
            f"publisher={self.publisher} note={self.note}, created_at={self.created_at})"
        )

class Manual(CitationBase):
    def __init__(
        self,
        key,
        author,
        title,
        organization,
        year,
        created_at=None,
        address=None,
        edition=None,
        month=None,
        note=None,
        annote=None,
    ):
        super().__init__(key=key, citation_type="manual", created_at=created_at)

        self.author = author
        self.title = title
        self.organization = organization
        self.year = year
        self.address = address
        self.edition = edition
        self.month = month
        self.note = note
        self.annote = annote

    def __str__(self):
        return (
            f"Manual(key={self.key}, author={self.author}, title={self.title}, "
            f"organization={self.organization}, year={self.year}, address={self.address}, "
            f"edition={self.edition}, month={self.month}, note={self.note}, "
            f"annote={self.annote}, created_at={self.created_at})"
        )
    