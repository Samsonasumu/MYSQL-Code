CREATE DATABASE  hr;

USE hr;

SELECT * FROM hrtable;

select * from hrtable where race = 'White';


-- alter the table--

ALTER TABLE hrtable
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

select last_name department from hrtable order by department

DESCRIBE hrtable;

SET sql_safe_updates = 0;

-- making the date similar --
UPDATE hrtable
SET birthdate = CASE
		WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
        WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
        ELSE NULL
		END;
	
ALTER TABLE hrtable
MODIFY COLUMN birthdate DATE;

select * from hrtable where location_state = "Ohio"

-- change the date format and datatpye of termdate column
UPDATE hrtable
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate !='';

select * from hrtable where termdate="";
-- the above line confirms that there are null values--
--- for that we need to clean---
UPDATE hrtable
SET termdate = NULL
WHERE termdate = '';


--  adding a  new  column
ALTER TABLE hrtable
ADD column age INT;

-- calculating age=---
UPDATE hrtable
SET age = timestampdiff(YEAR,birthdate,curdate())

SELECT count(age), max(age) FROM hrtable

-- 1. What is the gender breakdown of employees in the company

SELECT gender, COUNT(*) AS count 
FROM hrtable
WHERE termdate IS NULL
GROUP BY gender;

-- 2. What is the race breakdown of employees in the company
SELECT race , COUNT(*) AS count
FROm hrtable
WHERE termdate IS NULL
GROUP BY race




-- 3. What is the age distribution of employees in the company
SELECT 
	CASE
		WHEN age>=18 AND age<=24 THEN '18-24'
        WHEN age>=25 AND age<=34 THEN '25-34'
        WHEN age>=35 AND age<=44 THEN '35-44'
        WHEN age>=45 AND age<=54 THEN '45-54'
        WHEN age>=55 AND age<=64 THEN '55-64'
        ELSE '65+'
	END AS age_group,
    COUNT(*) AS count
    FROM hrtable
    WHERE termdate IS NULL
    GROUP BY age_group
    ORDER BY age_group;

-- 4. How many employees work at HQ vs remote
SELECT location,COUNT(*) AS count
FROm hrtable
WHERE termdate IS NULL
GROUP BY location;

-- 6. How does the gender distribution vary acorss dept. and job titles
SELECT *  FROM hrtable

SELECT department,jobtitle,gender,COUNT(*) AS count
FROM hrtable
WHERE termdate IS NOT NULL
GROUP BY department, jobtitle,gender
ORDER BY department, jobtitle,gender

SELECT gender,COUNT(*) AS count
FROM hrtable
WHERE termdate IS NOT NULL
GROUP BY department,gender
ORDER BY department,gender

-- 7. What is the distribution of jobtitles acorss the company
SELECT jobtitle, COUNT(*) AS count
FROm hrtable
WHERE termdate IS NULL
GROUP BY jobtitle

-- 9. What is the distribution of employees across location_state
SELECT location_state, COUNT(*) AS count
FROm hrtable
WHERE termdate IS NULL
GROUP BY location_state

SELECT location_city, COUNT(*) AS count
FROm hrtable
WHERE termdate IS NULL
GROUP BY location_city 

-- 10. How has the companys employee count changed over time based on hire and termination date.


-- 11. What is the tenure distribution for each dept.
SELECT department, round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hrtable
WHERE termdate IS NOT NULL AND termdate<= curdate()
GROUP BY department
