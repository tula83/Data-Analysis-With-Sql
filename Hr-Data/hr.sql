/* hr table */
SELECT * FROM hr;

/* count total rows */
SELECT COUNT(*) 'total rows' FROM hr;


/* atrition  rate */

SELECT  gender,COUNT(attrition)AS COUNT,
AVG(job_satisfaction) AS 'avg job satisfaction'
FROM hr 
WHERE attrition='Yes'
GROUP BY gender 


UNION ALL

SELECT  gender,COUNT(attrition)AS COUNT,
AVG(job_satisfaction) AS 'avg job satisfaction'
FROM hr 
WHERE attrition='no'
GROUP BY gender 
ORDER BY 2 DESC;



/*count active employee*/
SELECT COUNT(*) AS 'active employee' FROM hr
WHERE `attrition_label` ='Current Employees'

/* attrition count */
SELECT `attrition_label`,CONCAT(COUNT(*)*100/(SELECT COUNT(*) FROM hr) ,'%')AS 'active percentage' FROM  hr
GROUP BY 1 


/*average age */

SELECT AVG(age) AS 'avg age',MIN(age) AS 'min age',MAX(age) AS 'max age' FROM hr ;


/* artition  according to department */

SELECT department,COUNT(*) AS COUNT FROM hr
WHERE attrition='Yes'
GROUP BY department
ORDER BY 2 DESC


/*job satisfaction according to job roles */

SELECT job_role, job_satisfaction,COUNT(*)AS COUNT,SUM(`job_satisfaction`) AS 'total'
FROM hr  

GROUP BY 1 ,job_satisfaction
ORDER BY 1 DESC;


/* education attrition */
SELECT education_field,COUNT(*) AS 'total' 
FROM hr
WHERE attrition='Yes'
GROUP BY 1 
ORDER BY 2 DESC;

/*attrition rate according to age group */
SELECT 
CASE WHEN age<25 THEN 'under 25'
 WHEN age >=25 AND age <=34 THEN '25-34'
  WHEN age >34 AND age <=44 THEN '35-44'
  WHEN age >44 AND age <=54 THEN '45-54'
ELSE 'over 55'
END AS 'age group'
,COUNT(*) AS 'total'
FROM hr 
GROUP BY 1
ORDER BY 2 DESC;
