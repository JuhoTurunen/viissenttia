-- Create tables citation_base, article, book, manual
CREATE TABLE citation_base (
    id SERIAL PRIMARY KEY,
    key VARCHAR(30) NOT NULL,
    type VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE article (
    citation_id INT PRIMARY KEY,
    author JSONB NOT NULL,
    title TEXT NOT NULL,
    journal TEXT NOT NULL,
    year INT NOT NULL,
    volume INT,
    number INT,
    pages TEXT,
    month INT,
    note TEXT,
    CONSTRAINT fk_citation_base FOREIGN KEY (citation_id) REFERENCES citation_base(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE book (
    citation_id INT PRIMARY KEY,
    author JSONB NOT NULL,
    title TEXT NOT NULL,
    year INT NOT NULL,
    publisher TEXT NOT NULL,
    volume INT,
    series TEXT,
    address TEXT,
    edition TEXT,
    note TEXT,
    CONSTRAINT fk_citation_base FOREIGN KEY (citation_id) REFERENCES citation_base(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE inproceedings (
    citation_id INT PRIMARY KEY,
    author JSONB NOT NULL,
    title TEXT NOT NULL,
    booktitle TEXT NOT NULL,
    year INT NOT NULL,
    editor JSONB,
    volume INT,
    number INT,
    month INT,
    series TEXT,
    pages TEXT,
    address TEXT,
    organization TEXT,
    publisher TEXT NOT NULL,
    note TEXT,
    CONSTRAINT fk_citation_base FOREIGN KEY (citation_id) REFERENCES citation_base(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE manual (
    citation_id INT PRIMARY KEY,
    author JSONB NOT NULL,
    title TEXT NOT NULL,
    organization TEXT NOT NULL,
    year INT NOT NULL,
    address TEXT,
    edition TEXT,
    month TEXT,
    note TEXT,
    annote TEXT,
    CONSTRAINT fk_citation_base FOREIGN KEY (citation_id) REFERENCES citation_base(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Add test data: Articles (4)
INSERT INTO citation_base (key, type) VALUES ('Miller2024-1', 'article');
INSERT INTO article (citation_id, author, title, journal, year, volume, number, pages, month, note) 
VALUES (1, 'Emily Miller', 'Innovations in AI for Climate Modeling', 'Environmental Science Journal', 2024, 37, 2, '45--53', 6, 'Special issue on climate change technologies');

INSERT INTO citation_base (key, type) VALUES ('Smith2024-1', 'article');
INSERT INTO article (citation_id, author, title, journal, year, volume, number, pages, month, note) 
VALUES (2, 'John Smith', 'Advancements in Quantum Computing', 'Journal of Modern Physics', 2024, 56, 4, '123--130', 5, 'Special issue on quantum technology');

INSERT INTO citation_base (key, type) VALUES ('Jones2023-1', 'article');
INSERT INTO article (citation_id, author, title, journal, year, volume, number, pages, month) 
VALUES (3, 'Alice Jones', 'Machine Learning Algorithms for Health Data', 'Proceedings of the International Conference on AI', 2023, NULL, NULL, '200--205', 10);

INSERT INTO citation_base (key, type) VALUES ('Taylor2022-1', 'article');
INSERT INTO article (citation_id, author, title, journal, year, volume, number, pages, month, note) 
VALUES (4, 'David Taylor', 'Understanding Data Science: Principles and Applications', 'Data Science Press', 2022, NULL, NULL, '1--350', 8, 'Published in hardcover and e-book');

-- Add test data: Books (2)
INSERT INTO citation_base (key, type) VALUES ('Fisher1995-1', 'book');
INSERT INTO book (citation_id, author, title, year, publisher, address) 
VALUES (5, 'Yuval Fisher', 'Fractal Image Comression: Theory and Application', 1995, 'Springer Verlag', 'New York');

INSERT INTO citation_base (key, type) VALUES ('Knuth1973-1', 'book');
INSERT INTO book (citation_id, author, title, year, publisher, address, edition, note) 
VALUES (6, 'Donald E. Knuth', 'The art of computer programming', 1973, 'Addison-Wesley', 'Reading, Massachusetts', '3', 'the book is still incomplete');

-- Add test data: Manual (1)
INSERT INTO citation_base (key, type) VALUES ('Thorlabs2015-1', 'manual');
INSERT INTO manual (citation_id, author, title, organization, year) 
VALUES (7, 'Thorlabs', 'Position Sensing Detector User Guide', 'Thorlabs', 2015);

-- Add test data: Inproceedings (1)
INSERT INTO citation_base (key, type) VALUES ('Okuya2022-1', 'inproceedings');
INSERT INTO manual (citation_id, author, title, booktitle, year) 
VALUES (8, 'Yujiro Okuya', 'Distributed Architecture for Remote Collaborative Modification of Parametric CAD Data', '2022 International Conference on 6G Commun', 2022);
