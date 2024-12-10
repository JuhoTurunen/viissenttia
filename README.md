# viissenttia

The purpose of the application is citation management.


## Table of contents
- [Application functionality and features](#application-functionality-and-features)
- [Definition of done](#definition-of-done)
- [Backlogs](#backlogs)
- [Testing the application](#testing-the-application)


## Application functionality and features

The core functionality and features of the application are:

1. Adding citations: Users can add citations of varying types (e.g. article, book) 
2. Listing citations: Users can list stored citations
3. Exporting citations: Users can export stored citations in a BibTeX file that is compatible with LaTeX documents
4. Filtering citations: Users can filter citations based on criteria (e.g. author, year)
5. Categorising and tagging citations: Users can associate citations with categories or tags and use these as search criteria
6. Fetching online citations: Users can fetch reference details by providing a link to the reference (e.g. in the ACM Digital Library) or the DOI 


## Definition of done

1. Functionality: All core features outlined in the previous section are implemented and functional
2. Testing: Automated tests using the Robot Framework are written for core features and all tests pass
3. Code quality: Code adheres to the project's coding standards and is verified with Pylint (minimum acceptable score 8.00/10)
4. Documentation: README.md contains instructions for setup and testing


## Backlogs

The product and sprint backlogs can be found [here](https://helsinkifi-my.sharepoint.com/:x:/g/personal/juzturun_ad_helsinki_fi/ETudBp6OxL5GlwRVfpZgC8cBuwzMSGh-2SWFHwJBbWLTJA?e=7TnnLh)


## CI (GitHub Actions)

[![GHA workflow badge](https://github.com/JuhoTurunen/viissenttia/actions/workflows/main.yaml/badge.svg)](https://github.com/JuhoTurunen/viissenttia/actions)


## Test coverage

[![codecov](https://codecov.io/gh/JuhoTurunen/viissenttia/graph/badge.svg?token=UU1SYQDT8W)](https://codecov.io/gh/JuhoTurunen/viissenttia)


## Setup and testing

You can set-up and test the application by following these steps: 
1. Ensure you have PostgreSQL installed. Installation instructions for variuous systems can be found [here](https://www.postgresql.org/download/)
2. Clone the repository with $ git clone https://github.com/JuhoTurunen/viissenttia.git
3. Go to the root directory
3. Ensure you have poetry installed, then install dependencies with $ poetry install
4. Set up the database
    - Run PostgreSQL
    - Create a test database with $ createdb <db_name>
    - Load the schema and test data with $ psql -d <db_name> -f test_data.sql
    - Exit PostgreSQL with $ \q
5. To configure environment variables, create a file .env into the root directory and add lines:
```
DATABASE_URL=<path-to-database>
SECRET_KEY=<your-secret-key>
```
6. Activate the virtual environment with $ poetry shell
7. Start the application with $ python3 src/index.py 
8. You can now use the application on your browser by navigating to: http://localhost:5001/
9. Run Robot tests in a separate terminal window with $ robot src/tests/
10. Stop the application with *ctrl + c* and exit poetry shell with $ exit

