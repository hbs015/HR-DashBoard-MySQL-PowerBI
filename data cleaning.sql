						

create database project; 
use project;
desc hr;
 ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

UPDATE hr
SET birthdate = CASE
  WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%y'), '%Y-%m-%d')
  ELSE NULL
END;

select birthdate from hr;

ALTER TABLE hr MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
  WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
  WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%y'), '%Y-%m-%d')
  ELSE NULL
END;

select hire_date from hr;

 ALTER TABLE hr MODIFY COLUMN hire_date DATE;
 
 UPDATE hr
SET termdate = date(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

select termdate from hr;

UPDATE hr
SET termdate = null
WHERE termdate = "";

select termdate from hr;

 ALTER TABLE hr MODIFY COLUMN termdate DATE;
 
 desc hr;
 
 select * from hr;
 
 ALTER TABLE hr ADD COLUMN age INT;
UPDATE hr SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

select age from hr;

SELECT COUNT(*)
FROM hr
WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM hr
WHERE termdate is null;

select* from hr;