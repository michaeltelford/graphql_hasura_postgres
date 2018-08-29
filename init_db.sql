-- Create tables
CREATE TABLE IF NOT EXISTS author (
    user_id SERIAL PRIMARY KEY,
    username TEXT
);

CREATE TABLE IF NOT EXISTS article (
    id SERIAL PRIMARY KEY,
    author_id INT REFERENCES author(user_id),
    title TEXT,
    content TEXT,
    created_at TIMESTAMP default NOW()
);

CREATE TABLE IF NOT EXISTS upvote (
    user_id INT REFERENCES author(user_id),
    article_id INT REFERENCES article(id)
);

-- Create view
CREATE VIEW article_upvotes_count AS 
SELECT article_id, COUNT(user_id) AS total_upvotes
FROM upvote
GROUP BY article_id;

-- Insert sample data
INSERT INTO author(username) VALUES
    ('Michael Telford'),
    ('John Smith'),
    ('Joanna Smith');

INSERT INTO article(author_id, title, content) VALUES
    (1, 'Writing Tests', 'Do it!!!'),
    (1, 'Rapid Application Development', 'Super fast dev!'),
    (2, 'My first article', 'blah blah blah'),
    (2, 'My second article', 'blah 2nd blah'),
    (3, 'Environmentalism', 'Stop cutting down trees');

INSERT INTO upvote(user_id, article_id) VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (1, 2),
    (2, 5),
    (3, 5),
    (1, 5);
