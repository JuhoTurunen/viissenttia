import json
from sqlalchemy import text
from sqlalchemy.exc import DataError, IntegrityError, SQLAlchemyError
from config import db
from util import citation_data_to_class, sql_insert_writer


def get_citations():
    """
    Get citations from database
    :return: list of citation objects
    """
    citations = db.session.execute(
        text(
            """
            SELECT * FROM citation_base 
            INNER JOIN article
            ON citation_base.id = article.citation_id
            """
        )
    ).mappings()

    citation_classes = [result for c in citations if (result := citation_data_to_class(dict(c)))]

    return sorted(
        citation_classes,
        key=lambda x: x.created_at,
        reverse=True,
    )


def create_citation(citation_class):
    """
    Insert citation into database.
    :return: True if successful, False if not
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

        citation_dict = vars(citation_class)
        citation_dict["citation_id"] = citation_base_id
        citation_dict["author"] = json.dumps(citation_class.author)

        sql_command = text(sql_insert_writer(citation_class.type, citation_dict))

        db.session.execute(
            sql_command,
            citation_dict,
        )

        db.session.commit()
        return True

    except DataError as e:  # Catches invalid values
        db.session.rollback()
        print(f"Data error: {e}")
        return False
    except IntegrityError as e:  # Catches missing keys and other constraint violations
        db.session.rollback()
        print(f"Integrity error: {e}")
        return False
    except SQLAlchemyError as e:  # Catches other database errors
        db.session.rollback()
        print(f"Database error: {e}")
        return False
    except Exception as e:
        db.session.rollback()
        print(f"Unexpected error: {e}")
        # Raise fatal error if some other exception is encountered
        raise
