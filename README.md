# viissenttia

The purpose of the application is reference management.


## Table of contents
- [Application functionality and features](#application-functionality-and-features)
- [Definition of done](#definition-of-done)
- [Backlogs](#backlogs)
- [Testing the application](#testing-the-application)


## Application functionality and features

The core functionality and features of the application are:

1. Adding references: Users can add references of varying types (e.g. article, book) 
2. Listing references: Users can list stored references
3. Exporting references: Users can export stored references in a BibTeX file that is compatible with LaTeX documents
4. Filtering references: Users can filter references based on criteria (e.g. author, year)
5. Categorising and tagging references: Users can associate references with categories or tags and use these as search criteria
6. Fetching online references: Users can fetch reference details by providing a link to the reference (e.g. in the ACM Digital Library) or the DOI 


## Definition of done

1. Functionality: All core features outlined in the previous section are implemented and functional
2. Testing: Automated tests using the Robot Framework are written for core features and all tests pass
3. Documentation: README.md contains instructions for setup and testing


## Backlogs

The product and sprint backlogs can be found [here](https://helsinkifi-my.sharepoint.com/:x:/g/personal/juzturun_ad_helsinki_fi/ETudBp6OxL5GlwRVfpZgC8cBuwzMSGh-2SWFHwJBbWLTJA?e=7TnnLh)


## CI (GitHub Actions)

[![GHA workflow badge](https://github.com/JuhoTurunen/viissenttia/actions/workflows/ci.yaml/badge.svg)](https://github.com/JuhoTurunen/viissenttia/actions)


## Testing the application

You can test the application by following these steps: 
1. Clone the repository and go to its root directory
2. Ensure you have poetry installed, then install dependencies with $ poetry install
3. Create a file .env into the root directory and add lines:
```
DATABASE_URL=<path-to-database>
SECRET_KEY=<your-secret-key>
```
4. Activate the virtual environment with $ poetry shell
5. Start the application with $ python3 src/index.py 
6. You can now use the application on your browser by navigating to: http://localhost:5001/
7. Run tests with $ robot src/tests/
