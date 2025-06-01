
CREATE INDEX UserID_index ON cleaned_people_data(user_id);
CREATE INDEX Sex_index ON cleaned_people_data(sex);
CREATE INDEX JobTitle_index ON cleaned_people_data(job_title);
CREATE VIEW AvgBirthYear AS
SELECT AVG(CAST(strftime('%Y', date_of_birth) AS INTEGER)) AS avg_birth_year FROM cleaned_people_data;

CREATE VIEW CountByGender AS
SELECT sex, COUNT(*) AS total FROM cleaned_people_data GROUP BY sex;
CREATE VIEW JobTitleStats AS
SELECT job_title, COUNT(*) AS count FROM cleaned_people_data GROUP BY job_title ORDER BY count DESC;
SELECT * FROM AvgBirthYear;
SELECT * FROM CountByGender;
SELECT * FROM JobTitleStats;

SELECT user_id, first_name, last_name, date_of_birth FROM cleaned_people_data
WHERE date_of_birth > '2000-01-01' ORDER BY date_of_birth DESC;

-- Subquery
SELECT user_id, first_name, last_name, date_of_birth
FROM cleaned_people_data
WHERE CAST(strftime('%Y', date_of_birth) AS INTEGER) < (
    SELECT AVG(CAST(strftime('%Y', date_of_birth) AS INTEGER)) FROM cleaned_people_data
);

-- Inner Join
SELECT a.user_id AS user1_id, b.user_id AS user2_id, a.job_title
FROM cleaned_people_data a
INNER JOIN cleaned_people_data b ON a.job_title = b.job_title AND a.user_id <> b.user_id
ORDER BY a.job_title LIMIT 10;

-- Left Join
SELECT a.user_id, a.first_name, b.user_id AS matched_user, b.sex
FROM cleaned_people_data a
LEFT JOIN cleaned_people_data b ON a.sex = b.sex AND a.user_id <> b.user_id
ORDER BY a.sex LIMIT 10;

-- Distinct 
SELECT DISTINCT job_title FROM cleaned_people_data ORDER BY job_title;
