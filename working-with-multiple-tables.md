# Foreign Keys and Relationships

## Foreign Keys
Consider the following database that is made up of two tables *countries* and *cities*.

**countries**

| id | name    | population |
|----|---------|------------|
| 1  | England | 55000000   |
| 2  | France  | 67000000   |
| 3  | Germany | 82000000   |


**cities**

| id | name       | latitude |longitude|
|----|------------|----------|---------|
| 1  | Cologne    | 50.973   |6.9603   |
| 2  | Leon       | 42.5987  |5.5671   |
| 3  | Manchester | 53.4808  |2.2426   |
| 4  | Berlin     | 52.52    |13.405   |


It would be nice if we could store information about which country each city is located within. We can do this with a foreign key.

> A foreign key is a column that references the primary key of a different table.

We can add a foreign key column (the column *country_id*) to the *cities* table i.e.

| id | name       | latitude |longitude|country_id|
|----|------------|----------|---------|:--------:|
| 1  | Cologne    | 50.973   |6.9603   |3         |
| 2  | Leon       | 42.5987  |5.5671   |2         |
| 3  | Manchester | 53.4808  |2.2426   |1         |
| 4  | Berlin     | 52.52    |13.405   |3         |

We can then look at the record for Manchester and see that the *country_id* is 1. We can then look in the *countries* table and see that country 1 is England, Manchester is located in England.

We say that the table containing the foreign key is the **child table** (*cities*) and the table being referenced is the **parent table** (*countries*).

We say that there is a **one-to-many** relationship between countries and cities. *one* country has *many* cities.

## Tables can multiple foreign keys
Have a look at the following tables

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

If we look in the *fixtures* table (the second row) we can see that Huddersfield Town played Liverpool on the 10th of March 1963.

There are two foreign keys that both link to the *teams* table. One tells us the home team and the other the away team.

## Many-to-many relationships
Have a look at the following tables.

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


We say there is a **many-to-many** relationship between *musician* and *instrument*. A musician can play many instruments e.g. Jane Compton can play the Banjo, Guitar and Drums. An instrument can be played by many different musicians e.g. Jane Compton and Sunil Laxman both play the drums.

So we don't really have a child and parent relationship. To implement a many-to-many relationship we use a **junction** table e.g.

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

 A junction table exists simply to link records in the **instruments** and **musicians** tables. e.g. if we look in *instrument_musician* we can see that Jane Atherton and Jane Compton both play the guitar. We can also see that Sunil Laxman plays the drum and the saxophone.

> You might think we could just add an instrument_id column to the musicians table. We can't do this because each field can only hold a single value and musicians play multiple instruments.

The primary key in a junction table like this is always a *composite* primary key, the combination of *instrument_id* and *musician_id* uniquely identifies the row.
