# Solutions

* Display the titles of all the 15 rated films

```sql
SELECT films.title, certificates.name AS Certificate from films
INNER JOIN certificates
ON films.certificate_id=certificates.id
WHERE certificates.name="15";
```

* Display all the 15 rated films that are less than 100 minutes in length

```sql
SELECT films.title, films.duration from films
INNER JOIN certificates
ON films.certificate_id=certificates.id
WHERE certificates.name="15" AND films.duration<100;
```

* Display a list of all films and their genres

```sql
SELECT films.title, genres.name from films
INNER JOIN film_genre
ON films.id=film_genre.film_id
INNER JOIN genres
ON film_genre.genre_id=genres.id;
```

* Display the genres associated with 'The Incredibles'

```sql
SELECT genres.name from films
INNER JOIN film_genre
ON films.id=film_genre.film_id
INNER JOIN genres
ON film_genre.genre_id=genres.id
WHERE films.title="The Incredibles";
```

* Display a list of all the comedy films

```sql
SELECT films.title, genres.name from films
INNER JOIN film_genre
ON films.id=film_genre.film_id
INNER JOIN genres
ON film_genre.genre_id=genres.id
WHERE genres.name="Comedy";
```

* Display a list of all films that are categorised as thriller or crime

```sql
SELECT films.title from films
INNER JOIN film_genre
ON films.id=film_genre.film_id
INNER JOIN genres
ON film_genre.genre_id=genres.id
WHERE genres.name IN ("Thriller", "Crime");
```

* Display the number of films classified under each certificate

```sql
SELECT certificates.name As Certificate, COUNT(certificates.name) AS 'No. films' from films
INNER JOIN certificates
ON films.certificate_id=certificates.id
GROUP BY certificates.name;
```

* Display the number of films for each genre

```sql
SELECT genres.name AS Genre, COUNT(genres.name) AS 'No. films' from films
INNER JOIN film_genre
ON films.id=film_genre.film_id
INNER JOIN genres
ON film_genre.genre_id=genres.id
GROUP BY genres.name
```

* Display the complete details - certificate genres etc. for 'Dangerous Minds'

```sql
SELECT * from films
INNER JOIN certificates
ON films.certificate_id = certificates.id
INNER JOIN film_genre
ON films.id=film_genre.film_id
INNER JOIN genres
ON film_genre.genre_id=genres.id
WHERE films.title="Dangerous Minds"
```

* Display all the 15 rated films that are categorised as comedies

```sql
SELECT films.title from films
INNER JOIN certificates
ON films.certificate_id = certificates.id
INNER JOIN film_genre
ON films.id=film_genre.film_id
INNER JOIN genres
ON film_genre.genre_id=genres.id
WHERE certificates.name="15" AND genres.name="Comedy"
```

* Display the average duration of the films classified under each certificate. Order this list by duration from longest to shortest.

```sql
SELECT certificates.name, AVG(films.duration) AS 'Average Duration' from films
INNER JOIN certificates
ON films.certificate_id=certificates.id
GROUP BY certificates.name
ORDER BY duration DESC;
```
