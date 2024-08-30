-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT 
    gender, 
    COUNT(gender)
FROM human_resources
WHERE termdate IS NULL
GROUP BY gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT 
    race, 
    COUNT(*) AS COUNT
FROM human_resources
WHERE termdate IS NULL
GROUP BY race
ORDER BY COUNT DESC;

-- 3. What is the age distribution of employees in the company?
SELECT MIN(age) AS YOUNG,
       MAX(age) AS OLD
FROM human_resources
WHERE termdate IS NULL;

SELECT 
     CASE
        WHEN AGE BETWEEN 18 AND 30 THEN '18-30'
        WHEN AGE BETWEEN 31 AND 40 THEN '31-40'
        WHEN AGE BETWEEN 41 AND 50 THEN '41-49'
        ELSE '50+'
     END AS age_group, gender,
COUNT(age) AS COUNT
FROM human_resources
WHERE termdate IS NULL
GROUP BY age_group, gender
ORDER BY age_group, gender;

-- 4. How many employees work at headquarters versus remote locations?
SELECT 
    location, 
    COUNT(*) AS COUNT
FROM human_resources
WHERE termdate IS NULL
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT 
    ROUND(AVG(DATEDIFF(termdate, hire_date)) / 365,2) AS AVG_EMP_LENGHT
FROM human_resources
WHERE termdate <= CURRENT_DATE()
AND termdate IS NOT NULL;


-- 6. How does the gender distribution vary across departments and job titles?
SELECT 
    gender, 
    COUNT(gender) AS COUNT, 
    department
FROM human_resources
WHERE termdate IS NULL
GROUP BY gender , department
ORDER BY department;


-- 7. What is the distribution of job titles across the company?
SELECT 
    jobtitle, 
    COUNT(jobtitle) AS COUNT
FROM human_resources
WHERE termdate IS NULL
GROUP BY jobtitle
ORDER BY COUNT DESC;

-- 8. Which department has the highest turnover rate?
SELECT 
    department,
    total_count,
    terminated_count,
    terminated_count / total_count AS terminated_rate
FROM (SELECT department,
     COUNT(*) AS total_count,
    SUM(CASE
        WHEN termdate IS NOT NULL AND termdate <= CURRENT_DATE() THEN 1
        ELSE 0
    END) AS terminated_count
FROM human_resources
GROUP BY department) AS SUBQUERY
ORDER BY terminated_rate DESC;


-- 9. What is the distribution of employees across locations by city and state?
SELECT 
    location_state, 
    COUNT(*)
FROM human_resources
WHERE termdate IS NULL
GROUP BY location_state
ORDER BY location_state;


-- 10. What is the tenure distribution for each department?
SELECT 
    department,
    ROUND(AVG(DATEDIFF(termdate, hire_date)) / 365,2) AS AVG_TENURE
FROM human_resources
WHERE termdate IS NOT NULL
GROUP BY department;
