from sqlalchemy import text
<<<<<<< HEAD
from config import db
=======
from sqlalchemy.exc import SQLAlchemyError
>>>>>>> cce215a (Improved exception handling)
from entities.citation import Article
from util import citation_data_to_class


def get_citations():
    citations = db.session.execute(
        text(
            """
            SELECT * FROM citation_base 
            INNER JOIN articles 
            ON citation_base.id = articles.citation_id
            """
        )
    ).mappings()
    return sorted(
        [citation_data_to_class(dict(c)) for c in citations],
        key=lambda x: x.created_at,
        reverse=True,
    )


def create_citation(citation_class):
    """
    Insert citation into database.
    :return: success message or raise error
    """
    try:
        # Insert to citation_base
        citation_base_sql = text(
            """
            INSERT INTO citation_base (key, type, created_at)
            VALUES (:key, :type, :created_at)
            RETURNING id
        """
        )
        result = db.session.execute(
            citation_base_sql,
            {
                "key": citation_class.key,
                "type": citation_class.type,
                "created_at": citation_class.created_at,
            },
        )
        citation_base_id = result.fetchone()[0]

        # Insert to articles
        if isinstance(citation_class, Article):
            article_sql = text(
                """
                INSERT INTO articles (citation_id, author, title, journal, year, volume, number, pages, month, note)
                VALUES (:citation_id, :author, :title, :journal, :year, :volume, :number, :pages, :month, :note)
                """
            )
            db.session.execute(
                article_sql,
                {
                    "citation_id": citation_base_id,
                    "author": citation_class.author,
                    "title": citation_class.title,
                    "journal": citation_class.journal,
                    "year": citation_class.year,
                    "volume": citation_class.volume if citation_class.volume else None,
                    "number": citation_class.number if citation_class.number else None,
                    "pages": citation_class.pages if citation_class.pages else None,
                    "month": citation_class.month if citation_class.month else None,
                    "note": citation_class.note if citation_class.note else None,
                },
            )

    except SQLAlchemyError as e:
        db.session.rollback()
        print(f"Error occurred: {e}")
        return False

    except Exception as e:
        db.session.rollback()
        print(f"Error occurred: {e}")
        return False
    
    db.session.commit()
    return True
