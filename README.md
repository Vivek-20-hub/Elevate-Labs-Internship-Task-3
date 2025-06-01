
# Elevate-Labs-Internship-Task-3

**Dataset:** `cleaned_people_data.csv`  
**Data Cleaning and Preprocessing:** `Elevate-Labs-Internship-Task-1`  
**Cleaned Dataset:** `cleaned_people_data.csv`

---

## 🔧 Overview of SQL Data Analysis Process

1. Using the DB Browser for SQLite, create a new database.
2. Import the `cleaned_people_data.csv` into the database as a table.
3. Perform SQL queries on the table.
4. Observe and note the output.
5. Save the queries in a SQL file.

---

## 🧾 SQL Queries and Output

### 📌 CREATE Indexes:

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

**2. Count By Gender**
```sql
CREATE VIEW CountByGender AS
SELECT sex, COUNT(*) AS total FROM cleaned_people_data GROUP BY sex;
```

**3. Job Title Stats**
```sql
CREATE VIEW JobTitleStats AS
SELECT job_title, COUNT(*) AS count FROM cleaned_people_data GROUP BY job_title ORDER BY count DESC;
```

---

### 🔍 Output Views

```sql
SELECT * FROM AvgBirthYear;
SELECT * FROM CountByGender;
SELECT * FROM JobTitleStats;
```

---

### 👶 People Born After 2000

```sql
SELECT user_id, first_name, last_name, date_of_birth
FROM cleaned_people_data
WHERE date_of_birth > '2000-01-01'
ORDER BY date_of_birth DESC;
```

---

### 🧓 People Older Than Average (Subquery)

```sql
SELECT user_id, first_name, last_name, date_of_birth
FROM cleaned_people_data
WHERE CAST(strftime('%Y', date_of_birth) AS INTEGER) < (
    SELECT AVG(CAST(strftime('%Y', date_of_birth) AS INTEGER)) FROM cleaned_people_data
);
```

---

### 🤝 Inner Join: People with Same Job Title

```sql
SELECT a.user_id AS user1_id, b.user_id AS user2_id, a.job_title
FROM cleaned_people_data a
JOIN cleaned_people_data b ON a.job_title = b.job_title
WHERE a.user_id <> b.user_id;
```

---

### 🧬 Left Join: Same Gender Users

```sql
SELECT a.user_id, a.first_name, b.user_id AS matched_user, a.sex
FROM cleaned_people_data a
LEFT JOIN cleaned_people_data b ON a.sex = b.sex
WHERE a.user_id <> b.user_id;
```

---

### 🏷️ Top 5 Unique Job Titles

```sql
SELECT DISTINCT job_title
FROM cleaned_people_data
ORDER BY job_title ASC
LIMIT 5;
```

---

> 📁 Outputs of all queries are shown in the Word document with SQL-style tables.

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
