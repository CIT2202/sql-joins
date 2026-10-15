DROP TABLE IF EXISTS film_genre;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS certificates;

CREATE TABLE certificates (
  id int UNSIGNED NOT NULL AUTO_INCREMENT,
  name varchar(30) NOT NULL,
  description text NOT NULL,
  image varchar(30) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE films (
  id int UNSIGNED NOT NULL AUTO_INCREMENT,
  title varchar(100) NOT NULL,
  year smallint(6) NOT NULL,
  duration smallint(6) NOT NULL,
  certificate_id int(10) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (certificate_id) REFERENCES certificates(id)
);

CREATE TABLE genres (
  id int UNSIGNED NOT NULL AUTO_INCREMENT,
  name varchar(30) NOT NULL,
  description text NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE film_genre (
  film_id int UNSIGNED NOT NULL,
  genre_id int UNSIGNED NOT NULL,
  PRIMARY KEY (film_id,genre_id),
  FOREIGN KEY (film_id) REFERENCES films(id) ON DELETE CASCADE,
  FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);


INSERT INTO certificates (id, name, description, image) VALUES
(NULL, 'U', 'Suitable for all', 'u-cert.png'),
(NULL, 'PG', 'Some scenes may be unsuitable for young children', 'pg-cert.png'),
(NULL, '12', 'Suitable for people aged 12 and over.', '12-cert.png'),
(NULL, '15', 'Suitable for people aged 15 and over.', '15-cert.png'),
(NULL, '18', 'Suitable for people aged 18 and over.', '18-cert.png');

INSERT INTO films (id, title, year, duration, certificate_id) VALUES
(NULL, 'Jaws', 1975, 124, 4),
(NULL, 'Winter\'s Bone', 2010, 100, 4),
(NULL, 'Do The Right Thing', 1989, 120, 4),
(NULL, 'The Incredibles', 2004, 115, 1),
(NULL, 'The Godfather', 1972, 177, 5),
(NULL, 'Dangerous Minds', 1995, 99, 4),
(NULL, 'Spirited Away', 2001, 124, 2),
(NULL, 'Moonlight', 2016, 111, 5),
(NULL, 'Life of PI', 2012, 127, 2),
(NULL, 'Gravity', 2013, 91, 3),
(NULL, 'Arrival', 2016, 116, 3),
(NULL, 'Wonder Woman', 2017, 141, 3),
(NULL, 'Mean Girls', 2004, 97, 4),
(NULL, 'Inception', 2010, 108, 3),
(NULL, 'Donnie Darko', 2001, 113, 4),
(NULL, 'Get Out', 2017, 103, 4);

INSERT INTO genres (id, name, description) VALUES
(1, 'Drama', 'Drama is a genre of narrative fiction (or semi-fiction) intended to be more serious than humorous in tone, focusing on in-depth development of realistic characters who must deal with realistic emotional struggles.'),
(2, 'Thriller', 'A Thriller is a story that is usually a mix of fear and excitement. It has traits from the suspense genre and often from the action, adventure or mystery genres, but the level of terror makes it borderline horror fiction at times as well. '),
(3, 'Comedy', 'Comedy is a story that tells about a series of funny or comical events, intended to make the audience laugh.'),
(4, 'Fantasy', 'A fantasy story is about magic or supernatural forces, rather than technology, though it often is made to include elements of other genres, such as science fiction elements, if it happens to take place in a modern or future era.'),
(5, 'Crime', 'A crime story is about a crime that is being committed or was committed. It can also be an account of a criminal\'s life. It often falls into the action or adventure genres.'),
(6, 'Horror', 'A horror story is told to deliberately scare or frighten the audience, through suspense, violence or shock.'),
(7, 'Science Fiction', 'Science fiction (often shortened to Sci-Fi or SF) is a genre of speculative fiction, typically dealing with imaginative concepts such as advanced science and technology, spaceflight, time travel, and extraterrestrial life. ');

INSERT INTO film_genre (film_id, genre_id) VALUES
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 3),
(4, 1),
(4, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 4),
(8, 1),
(9, 1),
(10, 7),
(11, 7),
(12, 4),
(13, 1),
(13, 3),
(14, 2),
(14, 7),
(15, 1),
(16, 6);

