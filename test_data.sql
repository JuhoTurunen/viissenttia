-- Create tables citation_base and articles
CREATE TABLE citation_base (
    id SERIAL PRIMARY KEY,
    key VARCHAR(30) NOT NULL,
    type VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE articles (
    citation_id INT PRIMARY KEY,
    authors TEXT NOT NULL,
    title TEXT NOT NULL,
    journal TEXT NOT NULL,
    year INT NOT NULL,
    volume INT,
    number INT,
    pages TEXT,
    month INT,
    note TEXT,
    CONSTRAINT fk_citation_base FOREIGN KEY (citation_id) REFERENCES citation_base(id)
);

-- Add test data: Articles (4)
INSERT INTO citation_base (key, type) VALUES ('Miller2024-1', 'article');
INSERT INTO articles (citation_id, authors, title, journal, year, volume, number, pages, month, note) 
VALUES (1, 'Emily Miller', 'Innovations in AI for Climate Modeling', 'Environmental Science Journal', 2024, 37, 2, '45--53', 6, 'Special issue on climate change technologies');

INSERT INTO citation_base (key, type) VALUES ('Smith2024-1', 'article');
INSERT INTO articles (citation_id, authors, title, journal, year, volume, number, pages, month, note) 
VALUES (2, 'John Smith', 'Advancements in Quantum Computing', 'Journal of Modern Physics', 2024, 56, 4, '123--130', 5, 'Special issue on quantum technology');

INSERT INTO citation_base (key, type) VALUES ('Jones2023-1', 'article');
INSERT INTO articles (citation_id, authors, title, journal, year, volume, number, pages, month, note) 
VALUES (3, 'Alice Jones', 'Machine Learning Algorithms for Health Data', 'Proceedings of the International Conference on AI', 2023, NULL, NULL, '200--205', 10, 'Best paper award');

INSERT INTO citation_base (key, type) VALUES ('Taylor2022-1', 'article');
INSERT INTO articles (citation_id, authors, title, journal, year, volume, number, pages, month, note) 
VALUES (4, 'David Taylor', 'Understanding Data Science: Principles and Applications', 'Data Science Press', 2022, NULL, NULL, '1--350', 8, 'Published in hardcover and e-book');
