# MySQL - Relationships, Foreign Keys and Joins
This practical follows on from the previous practical. We will work with multiple tables using joins.

## Deleting the existing films table
We need to work with a different version of the films table, so first we need to delete the table we created in the last practical.
* In phpMyAdmin select the films table.
* From the navigation bar select operations.
* Scroll down and select 'Delete the table (DROP)'.

## Setting up the tables
Now we need to run SQL statements that will set up four tables, *films*, *certificates*,  *genres* and *film_genre*.

* In phpMyAdmin from the navigation bar at the top select 'SQL'
* From GitHub select the file [films.sql](films.sql). This file contains SQL commands to create the four database tables and populate them with data.
    * Click 'raw' and copy the entire contents of this file.
* Back in phpMyAdmin paste these SQL statements into the textbox labelled *'Run SQL query'*.
* Click 'Go'.
* Now if you select the database again you should see you have four tables.

## Getting data out using a join
* Select the SQL tab.
* Run the following SQL statement

```sql
SELECT films.title, certificates.name from films
INNER JOIN certificates
ON films.certificate_id=certificates.id;
```
You should get a list of all the films and their certificates.

Now have a go writing SELECT statements that will do the following:
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

## Inserting data
* Have a go at writing an SQL statement (or series of statements) that will add a new film to the database. Make sure you also associate the film with at least one genre.
* Write an SQL SELECT statement to test this has worked successfully.

## Deleting data
* Have a go at writing an SQL statement (or series of statements) that will delete a film from the database.
