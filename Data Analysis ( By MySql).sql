
use project;

#What is the gender breakdown of employees in the company?

SELECT gender, COUNT(*) AS count
FROM hr
WHERE age >= 18 and termdate is null
GROUP BY gender;

#What is the race/ethnicity breakdown of employees in the company?
SELECT 
    race, COUNT(*) AS count
FROM
    hr
WHERE
    age >= 18 AND termdate IS NULL
GROUP BY race
ORDER BY count DESC;

 #What is the age distribution of employees in the company?
SELECT 
  MIN(age) AS youngest,
  MAX(age) AS oldest
FROM hr
WHERE age >= 18 and termdate is null;
SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group, 
  COUNT(*) AS count
FROM 
  hr
WHERE 
  age >= 18 and termdate is null
GROUP BY age_group
ORDER BY age_group;

SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    WHEN age >= 55 AND age <= 64 THEN '55-64'
    ELSE '65+' 
  END AS age_group, gender,
  COUNT(*) AS count
FROM 
  hr
WHERE 
  age >= 18 and termdate is null
GROUP BY age_group, gender
ORDER BY age_group, gender;

 # How many employees work at headquarters versus remote locations?
SELECT location, COUNT(*) as count
FROM hr
WHERE age >= 18 and termdate is null
GROUP BY location;

#What is the average length of employment for employees who have been terminated?
SELECT ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0) AS avg_length_of_employment
FROM hr
WHERE termdate is not null  AND termdate <= CURDATE() AND age >= 18;

 #How does the gender distribution vary across departments?
 SELECT department, gender, COUNT(*) as count
FROM hr
WHERE age >= 18 and termdate is null
GROUP BY department, gender
ORDER BY department;

 #What is the distribution of job titles across the company?
 SELECT jobtitle, COUNT(*) as count
FROM hr
WHERE age >= 18 and termdate is null
GROUP BY jobtitle
ORDER BY jobtitle DESC;

#Which department has the highest turnover rate?
select department, total_count,
terminated_count,
terminated_count/total_count as termination_rate
from (
     select department,
     count(*)as total_count,
     sum(case when termdate is not null and termdate<=curdate() then 1 else 0 end) as terminated_count
     from hr
	  where age>=18
      group by department
      ) as subquery
order by termination_rate desc;

#What is the distribution of employees across locations by state?
SELECT location_state, COUNT(*) as count
FROM hr
WHERE age >= 18 and termdate is null
GROUP BY location_state
ORDER BY count DESC;

#How has the company's employee count changed over time based on hire and term dates?
SELECT 
    year, 
    hires, 
    terminations, 
    (hires - terminations) AS net_change,
    ROUND(((hires - terminations) / hires * 100), 2) AS net_change_percent
FROM (
    SELECT 
        YEAR(hire_date) AS year, 
        COUNT(*) AS hires, 
        SUM(CASE WHEN termdate is not null AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
    FROM 
        hr
    WHERE age >= 18
    GROUP BY 
        YEAR(hire_date)
) subquery
ORDER BY year ASC;

 #What is the tenure distribution for each department?
 SELECT department, ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as avg_tenure
FROM hr
WHERE termdate <= CURDATE() AND termdate is not null AND age >= 18
GROUP BY department;