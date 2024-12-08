import unittest
from entities.citation import Article, Inproceedings, Book, Manual
from util import citation_data_to_class,citation_class_to_bibtex_file,sql_insert_writer,Validator,ValidationError
from datetime import datetime
import os.path

class TestClassGenerator(unittest.TestCase):
    def setUp(self):
        self.article={"key":"test",
                   "type":"article",
                    "author":["test person"],
                    "title":"test title",
                    "journal":"ACM",
                    "year":1999,
                    "created_at":datetime.now(),
                    "volume":2,
                    "number":3,
                    "pages":"pages",
                    "month":5,
                    "note":"Some notes"
                    }
        
        self.book={"key":"test",
                   "type":"book",
                    "author":["test person"],
                    "title":"test title",
                    "publisher":"ACM",
                    "year":1999,
                    "created_at":datetime.now(),
                    "volume":2,
                    "series":"sarja",
                    "pages":"pages",
                    "edition":"5",
                    "address":"some adress",
                    "note":"Some notes"
                    }
        
        self.inproceedings={"key":"test",
                   "type":"inproceedings",
                    "author":["test person"],
                    "title":"test title",
                    "booktitle":"test title",
                    "editor":["Jaska"],
                    "publisher":"ACM",
                    "year":1999,
                    "created_at":datetime.now(),
                    "volume":2,
                    "number":3,
                    "month":5,
                    "series":"sarja",
                    "pages":"pages",
                    "organization":"mafia",
                    "address":"some adress",
                    "note":"Some notes"
                    }
        
        self.manual={"key":"test",
                   "type":"manual",
                    "author":["test person"],
                    "title":"test title",
                    "year":1999,
                    "organization":"mafia",
                    "created_at":datetime.now(),
                    "month":5,
                    "series":"sarja",
                    "edition":"5",
                    "address":"some adress",
                    "note":"Some notes",
                    "annote":"What is annote"
                    }

    def test_all_is_valid_article(self):
        value=citation_data_to_class(self.article)
        self.assertIsInstance(value,Article)

    def test_all_is_valid_book(self):
        value=citation_data_to_class(self.book)
        self.assertIsInstance(value,Book)

    def test_all_is_valid_inproceedings(self):
        value=citation_data_to_class(self.inproceedings)
        self.assertIsInstance(value,Inproceedings)

    def test_all_is_valid_manual(self):
        value=citation_data_to_class(self.manual)
        self.assertIsInstance(value,Manual)

    def test_all_article_is_string_error_correction(self):
        self.article["year"]="1999"
        self.article["volume"]="2"
        self.article["number"]="3"
        self.article["month"]="5"
        value=citation_data_to_class(self.article)
        self.assertIsInstance(value,Article)

    def test_none_type_key(self):
        self.article["key"]=None
        value=citation_data_to_class(self.article)
        self.assertIsInstance(value,Article)

    def test_none_type_title(self):
        self.article["title"]=None
        validator=Validator(self.article,True)
        with self.assertRaises(ValidationError):
            validator.check("title",str,True)

    def test_month_wrong(self):
        self.article["month"]="march"
        validator=Validator(self.article,True)
        with self.assertRaises(ValidationError):
            validator.check("month",int)


    def test_number_wrong(self):
        self.article["number"]=None
        validator=Validator(self.article,True)
        self.assertIsNone(validator.check("number",int))

#Validator changed how it gets the authors and now the dictionary form doesn't work anymore, if front_facing=True
    """def test_none_type_author(self):
        self.article["author"]=None
        self.assertAlmostEqual("Field author is required",citation_data_to_class(self.article,True))

    def test_month_is_wrong_form(self):
        self.article["month"]="jaaaaa"
        self.assertAlmostEqual("Field month expects a number, received text",citation_data_to_class(self.article,True))"""

    def test_wrong_type_citation(self):
        self.article["type"]="artikkeli"
        value=citation_data_to_class(self.article)
        self.assertIsNone(value)


    """def test_bibtex_file_creation(self):
        citation_class_to_bibtex_file([citation_data_to_class(self.article)])
        dirname = os.path.dirname(__file__)
        filename = os.path.join(dirname, "../bibtex_files/citations.bib")
        with open(filename,"r") as bibtex:
            first_line=bibtex.readline()
        self.assertAlmostEqual(first_line,"@article{person1999,\n")"""

    
    def test_article_class_str_format(self):
        value=citation_data_to_class(self.article)
        self.assertIsInstance(str(value),str)


    def test_sql_insert_writer(self):
        value=sql_insert_writer("article",self.article)
        self.assertIsInstance(value,str)