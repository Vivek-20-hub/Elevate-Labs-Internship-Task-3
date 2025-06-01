# Elevate-Labs-Internship-Task-3

Dataset: Cleaned_people_data.csv
Data cleaning and preprocessing: Elevate-Labs-Internship-Task-1
Cleaned Dataset: cleaned_sales_data.csv

Here is a brief overview of the SQL for data analysis process:

Using the DB Browser for SQLite, create a new database.
Import the cleaned_sales_data.csv into the database as a table.
Perform SQL queries on the table.
Observe and note the output.
Save the queries in a SQL file
 CREATE Indexes:
 Index of user_id:
CREATE INDEX UserID_index ON cleaned_people_data(user_id);
Index of Sex:
CREATE INDEX Sex_index ON cleaned_people_data(sex);
Index of Job_title:
CREATE INDEX JobTitle_index ON cleaned_people_data(job_title);

Created Views:

view Average Birth Year,Gender,Jobtitles

CREATE VIEW AvgBirthYear AS
SELECT AVG(CAST(strftime('%Y', date_of_birth) AS INTEGER)) AS avg_birth_year FROM cleaned_people_data;

![p1](https://github.com/user-attachments/assets/58d2c4bd-d903-4f90-8f06-2526db1c02c7)

CREATE VIEW CountByGender AS
SELECT sex, COUNT(*) AS total FROM cleaned_people_data GROUP BY sex;

![p2](https://github.com/user-attachments/assets/daa64aa2-2474-4696-a872-a70ecfa67467)

CREATE VIEW JobTitleStats AS
SELECT job_title, COUNT(*) AS count FROM cleaned_people_data GROUP BY job_title ORDER BY count DESC;

![p3](https://github.com/user-attachments/assets/4ea846c3-5b04-494f-a117-d7b9d7993809)

Output views

SELECT * FROM AvgBirthYear;
SELECT * FROM CountByGender;
SELECT * FROM JobTitleStats;

People born after 2000:

SELECT user_id, first_name, last_name, date_of_birth FROM cleaned_people_data
WHERE date_of_birth > '2000-01-01' ORDER BY date_of_birth DESC;

![p4](https://github.com/user-attachments/assets/1113de0d-e1eb-49be-a55e-7112910b0a3a)

Subquery: People older than average 

SELECT user_id, first_name, last_name, date_of_birth
FROM cleaned_people_data
WHERE CAST(strftime('%Y', date_of_birth) AS INTEGER) < (
    SELECT AVG(CAST(strftime('%Y', date_of_birth) AS INTEGER)) FROM cleaned_people_data
);

![p5](https://github.com/user-attachments/assets/4eebaa28-15ed-40f1-b04e-fa1e4664a08c)

Inner Join: Matching people with same job title

SELECT a.user_id AS user1_id, b.user_id AS user2_id, a.job_title
FROM cleaned_people_data a
INNER JOIN cleaned_people_data b ON a.job_title = b.job_title AND a.user_id <> b.user_id
ORDER BY a.job_title LIMIT 10;

![p6](https://github.com/user-attachments/assets/2a4023d2-f317-4320-b1b7-863403a0d7cb)

 Left Join: Show all people with or without matching gendered pair 
 Top 5
SELECT a.user_id, a.first_name, b.user_id AS matched_user, b.sex
FROM cleaned_people_data a
LEFT JOIN cleaned_people_data b ON a.sex = b.sex AND a.user_id <> b.user_id
ORDER BY a.sex LIMIT 10;

![p7](https://github.com/user-attachments/assets/141345c2-e313-4503-8558-73d5dc80160b)

Distinct job titles

SELECT DISTINCT job_title FROM cleaned_people_data ORDER BY job_title;
![p8](https://github.com/user-attachments/assets/d97992f5-65ba-4411-ad37-5294fb84e995)
