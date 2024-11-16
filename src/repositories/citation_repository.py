from config import db
from sqlalchemy import text

from entities.citation import Article

def get_citations():
    """ result = db.session.execute(text("SELECT id, content, done FROM todos"))
    todos = result.fetchall()
    return [Todo(todo[0], todo[1], todo[2]) for todo in todos]  """
    return None # I left the boilerplate commented for copy pasting but return a list of citation objects

def create_citation(citation_class):
    """
    Insert citation into database.
    :return: success message or raise error
    """
    try:
        # Insert to CitationBase
        citation_base_sql = text("""
            INSERT INTO CitationBase (key, type, created_at)
            VALUES (:key, :type, :created_at)
            RETURNING id
        """)
        result = db.session.execute(citation_base_sql, {
            "key": citation_class.key,
            "type": citation_class.type,
            "created_at": citation_class.created_at
        })
        citation_base_id = result.fetchone()[0]

        # Insert to Articles
        if isinstance(citation_class, Article):
            article_sql = text("""
                INSERT INTO Articles (citation_id, author, title, journal, year, volume, number, pages, month, note)
                VALUES (:citation_id, :author, :title, :journal, :year, :volume, :number, :pages, :month, :note)
            """)
            db.session.execute(article_sql, {
                "citation_id": citation_base_id, 
                "author": citation_class.author,
                "title": citation_class.title,
                "journal": citation_class.journal,
                "year": citation_class.year,
                "volume": citation_class.volume,
                "number": citation_class.number,
                "pages": citation_class.pages,
                "month": citation_class.month,
                "note": citation_class.note
                })
            
        db.session.commit() 

    except Exception as e:
        db.session.rollback
        print(e)
        return None

    return "success"

