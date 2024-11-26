import unittest
from unittest.mock import Mock, ANY
from entities.citation import Article
from util import citation_data_to_class,citation_class_to_bibtex_file,Validator,ValidationError
from datetime import datetime
import os.path

class TestClassGenerator(unittest.TestCase):
    def setUp(self):
        self.data={"key":"test",
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
                    "note":"Some notes"}

    def test_all_is_valid(self):
        value=citation_data_to_class(self.data)
        self.assertIsInstance(value,Article)

    def test_all_data_is_string_error_correction(self):
        self.data["year"]="1999"
        self.data["volume"]="2"
        self.data["number"]="3"
        self.data["month"]="5"
        value=citation_data_to_class(self.data)
        self.assertIsInstance(value,Article)

    def test_none_type_key(self):
        self.data["key"]=None
        value=citation_data_to_class(self.data)
        self.assertIsInstance(value,Article)

    def test_none_type_title(self):
        self.data["title"]=None
        validator=Validator(self.data,True)
        with self.assertRaises(ValidationError):
            validator.check("title",str,True)

    def test_month_wrong(self):
        self.data["month"]="march"
        validator=Validator(self.data,True)
        with self.assertRaises(ValidationError):
            validator.check("month",int)


    def test_number_wrong(self):
        self.data["number"]=None
        validator=Validator(self.data,True)
        self.assertIsNone(validator.check("number",int))

#Validator changed how it gets the authors and now the dictionary form doesn't work anymore, if front_facing=True
    """def test_none_type_author(self):
        self.data["author"]=None
        self.assertAlmostEqual("Field author is required",citation_data_to_class(self.data,True))

    def test_month_is_wrong_form(self):
        self.data["month"]="jaaaaa"
        self.assertAlmostEqual("Field month expects a number, received text",citation_data_to_class(self.data,True))"""

    def test_wrong_type_citation(self):
        self.data["type"]="artikkeli"
        value=citation_data_to_class(self.data)
        self.assertIsNone(value)



    def test_bibtex_file_creation(self):
        citation_class_to_bibtex_file([citation_data_to_class(self.data)])
        dirname = os.path.dirname(__file__)
        filename = os.path.join(dirname, "../bibtex_files/citations.bib")
        with open(filename,"r") as bibtex:
            first_line=bibtex.readline()
        self.assertAlmostEqual(first_line,"@article{person1999,\n")

    
    def test_article_class_str_format(self):
        value=citation_data_to_class(self.data)
        self.assertIsInstance(str(value),str)
