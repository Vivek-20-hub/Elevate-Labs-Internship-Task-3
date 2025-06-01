![p6](https://github.com/user-attachments/assets/8a1f46c0-93ad-47d5-bd60-ff7f619efe1e)
# Elevate-Labs-Internship-Task-3

**Dataset:** `cleaned_people_data.csv`  
**Data Cleaning and Preprocessing:** `Elevate-Labs-Internship-Task-1`  
**Cleaned Dataset:** `cleaned_people_data.csv`

---

## Overview of SQL Data Analysis Process

1. Using the DB Browser for SQLite, create a new database.
2. Import the `cleaned_people_data.csv` into the database as a table.
3. Perform SQL queries on the table.
4. Observe and note the output.
5. Save the queries in a SQL file.

---

##  SQL Queries and Output

###  CREATE Indexes:

**Index of user_id:**
```sql
CREATE INDEX UserID_index ON cleaned_people_data(user_id);
```

**Index of sex:**
```sql
CREATE INDEX Sex_index ON cleaned_people_data(sex);
```

**Index of job_title:**
```sql
CREATE INDEX JobTitle_index ON cleaned_people_data(job_title);
```

---

### 📊 Created Views:

**1. Average Birth Year**
```sql
CREATE VIEW AvgBirthYear AS
SELECT AVG(CAST(strftime('%Y', date_of_birth) AS INTEGER)) AS avg_birth_year FROM cleaned_people_data;
```

![p1](https://github.com/user-attachments/assets/e8ba3d12-d663-42d8-abbe-0344390fd399)

**2. Count By Gender**
```sql
CREATE VIEW CountByGender AS
SELECT sex, COUNT(*) AS total FROM cleaned_people_data GROUP BY sex;
```
![p2](https://github.com/user-attachments/assets/1eea81ac-1724-48cb-9274-e91146702a72)


**3. Job Title Stats**
```sql
CREATE VIEW JobTitleStats AS
SELECT job_title, COUNT(*) AS count FROM cleaned_people_data GROUP BY job_title ORDER BY count DESC;
```

![p3](https://github.com/user-attachments/assets/0d96d220-5d24-47fd-9218-5ca426cb5573)

---

###  Output Views

```sql
SELECT * FROM AvgBirthYear;
SELECT * FROM CountByGender;
SELECT * FROM JobTitleStats;
```

---

###  People Born After 2000

```sql
SELECT user_id, first_name, last_name, date_of_birth
FROM cleaned_people_data
WHERE date_of_birth > '2000-01-01'
ORDER BY date_of_birth DESC;
```

![p4](https://github.com/user-attachments/assets/a61ec6e5-f156-4a7e-a9b7-42464010a72c)

---

###  People Older Than Average (Subquery)

```sql
SELECT user_id, first_name, last_name, date_of_birth
FROM cleaned_people_data
WHERE CAST(strftime('%Y', date_of_birth) AS INTEGER) < (
    SELECT AVG(CAST(strftime('%Y', date_of_birth) AS INTEGER)) FROM cleaned_people_data
);
```

![p5](https://github.com/user-attachments/assets/a8747152-4985-4fac-b94a-3bc4be564ea2)

---

###  Inner Join: People with Same Job Title

```sql
SELECT a.user_id AS user1_id, b.user_id AS user2_id, a.job_title
FROM cleaned_people_data a
JOIN cleaned_people_data b ON a.job_title = b.job_title
WHERE a.user_id <> b.user_id;
```
![p6](https://github.com/user-attachments/assets/2a4023d2-f317-4320-b1b7-863403a0d7cb)
---

###  Left Join: Same Gender Users

```sql
SELECT a.user_id, a.first_name, b.user_id AS matched_user, a.sex
FROM cleaned_people_data a
LEFT JOIN cleaned_people_data b ON a.sex = b.sex
WHERE a.user_id <> b.user_id;
```
![p7](https://github.com/user-attachments/assets/af31e0c3-3b38-4404-b28d-471c89c20e7d)

---

###  Top 5 Unique Job Titles

```sql
SELECT DISTINCT job_title
FROM cleaned_people_data
ORDER BY job_title ASC
LIMIT 5;
```

![p8](https://github.com/user-attachments/assets/8347d74c-60b1-49cb-9d82-077a5ccabcd9)

---



