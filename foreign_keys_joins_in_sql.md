# Foreign Keys and Joins in SQL

## Inserting Data
When inserting data we have to make sure that the foreign key value exists.

**countries**

| id | name    | population |
|----|---------|------------|
| 1  | England | 55000000   |
| 2  | France  | 67000000   |
| 3  | Germany | 82000000   |


**cities**

| id | name       | latitude |longitude|country_id|
|----|------------|----------|---------|:--------:|
| 1  | Cologne    | 50.973   |6.9603   |3         |
| 2  | Leon       | 42.5987  |5.5671   |2         |
| 3  | Manchester | 53.4808  |2.2426   |1         |
| 4  | Berlin     | 52.52    |13.405   |3         |

If we try and add a new row for a Spanish city in the *cities* table e.g.

```sql
INSERT INTO cities (id, name, latitude, longitude, country_id) VALUES
(NULL, 'Madrid', 40.4168, 3.7038, 4);
```

We would get an error *'Cannot add or update a child row: a foreign key constraint fails'*. This is because there isn't a country with an id of 4 in the *countries* table. We would have to make sure that we added Spain to the *countries* table before attempting to add cities for Spain in the *cities* table.

## Joins

> These examples all demonstrate the use of INNER joins. There are other types of join in SQL e.g. LEFT, FULL but these are used less often and we won't need to use them in this module.

To select data from multiple tables we use a join. Here's an example:

**countries**

| id | name    | population |
|----|---------|------------|
| 1  | England | 55000000   |
| 2  | France  | 67000000   |
| 3  | Germany | 82000000   |


**cities**

| id | name       | latitude |longitude|country_id|
|----|------------|----------|---------|:--------:|
| 1  | Cologne    | 50.973   |6.9603   |3         |
| 2  | Leon       | 42.5987  |5.5671   |2         |
| 3  | Manchester | 53.4808  |2.2426   |1         |
| 4  | Berlin     | 52.52    |13.405   |3         |

```sql
SELECT cities.name AS city, countries.name AS country FROM cities
INNER JOIN countries ON cities.country_id = countries.id;
```
Would give us the following result:

| city       | country |
|------------|----------|
| Cologne    | Germany  |
| Leon       | France  |
| Manchester | England  |
| Berlin     | Germany  |

Have a good look at the SQL statement and the result it returns. A couple of things are worth pointing out:

* We use a 'dot notation' e.g. *cities.name* to specify which table a column comes from.
* We can use aliases e.g. *countries.name AS Country*  to make the results more readable. There are *name* columns in both tables so renaming them in the results avoids confusion.

## Using a WHERE clause
All the features of SQL that work for a single table work when we do joins e.g. we can use a WHERE clause.

```sql
SELECT cities.name AS city, countries.name AS country FROM cities
INNER JOIN countries ON cities.country_id = countries.id
WHERE countries.name='Germany';
```

| city       | country |
|------------|----------|
| Cologne    | Germany  |
| Berlin     | Germany  |

## Using aggregate functions
All the features of SQL that work for a single table work when we do joins e.g. we can use an aggregate function such as COUNT.

```sql
SELECT countries.name AS country, COUNT(cities.name) AS 'no. cities' FROM cities
INNER JOIN countries ON cities.country_id = countries.id
GROUP BY countries.name;
```

| country    | no. cities |
|------------|------------|
| England    | 1          |
| France     | 1          |
| Germany    | 2          |


## Table Aliases
We can also alias table names. In this example I need to join to the *teams* table twice (for the home and away teams). I can use aliases to identify each join.


**teams**

| id | name              |
|----|-------------------|
| 1  | Huddersfield Town |
| 2  | Manchester Untied |
| 3  | Liverpool         |

**fixtures**

| id | home_id | away_id |date      |
|----|---------|---------|----------|
| 1  | 1       | 2       |1963-02-03|
| 2  | 1       | 3       |1963-03-10|
| 3  | 3       | 2       |1971-12-21|
| 4  | 2       | 1       |1980-08-17|

```sql
SELECT home.name AS home, away.name AS away, date FROM fixtures
JOIN teams AS home ON fixtures.home_id = home.id
JOIN teams AS away ON fixtures.away_id = away.id
```
| home              | away              |date      |
|-------------------|-------------------|----------|
| Huddersfield Town | Manchester United |1963-02-03|
| Huddersfield Town | Liverpool         |1963-03-10|
| Liverpool         | Manchester United |1971-12-21|
| Manchester United | Huddersfield Town |1980-08-17|

Again, if this is the first time you seen this, you will probably have to look carefully to really understand how this is working.

## Many-to-many relationships

For many-to-many relationships we need to join three tables e.g.

**musicians**

| id | first_name | last_name |
|----|------------|-----------|
| 1  | Jane       | Compton   |
| 2  | Jane       | Atherton  |
| 3  | Kate       | Hutton    |
| 4  | Sunil      | Laxman    |

**instruments**

| id | name      |
|----|-----------|
| 1  | Banjo     |
| 2  | Saxophone |
| 3  | Guitar    |
| 4  | Drums     |

**instrument_musician**

| instrument_id  | musician_id |
|----------------|-------------|
| 4              | 1           |
| 2              | 3           |
| 4              | 4           |
| 1              | 1           |
| 3              | 1           |
| 3              | 2           |
| 2              | 4           |

```sql
SELECT instruments.name AS instrument, musicians.last_name FROM instruments
INNER JOIN instrument_musician
ON instruments.id=instrument_musician.instrument_id
INNER JOIN musicians
ON musicians.id=instrument_musician.musician_id
```

| instrument     | last_name   |
|----------------|-------------|
| Drums          | Compton     |
| Saxophone      | Hutton      |
| Drums          | Laxman      |
| Banjo          | Compton     |
| Guitar         | Compton     |
| Guitar         | Atherton    |
| Saxophone      | Laxman      |

Again, if this is the first time you have seen this, you have to look carefully to really understand how this is working.

## Deleting Data
Foreign keys create dependencies between tables e.g. consider the *countries* and *cities* example.

**countries**

| id | name    | population |
|----|---------|------------|
| 1  | England | 55000000   |
| 2  | France  | 67000000   |
| 3  | Germany | 82000000   |


**cities**

| id | name       | latitude |longitude|country_id|
|----|------------|----------|---------|:--------:|
| 1  | Cologne    | 50.973   |6.9603   |3         |
| 2  | Leon       | 42.5987  |5.5671   |2         |
| 3  | Manchester | 53.4808  |2.2426   |1         |
| 4  | Berlin     | 52.52    |13.405   |3         |

If we try and delete the third row from the *countries* table (Germany)

```sql
DELETE FROM countries WHERE id=3;
```

We will get an error message *'Cannot delete or update a parent row: a foreign key constraint fails'*. This is because there are rows in the *cities* table that reference this row. If we wanted to delete the Germany row, we would have to delete the first and fourth rows of the *cities* table before attempting this.
