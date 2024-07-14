SELECT * FROM absent

/*count  of total rows*/

SELECT COUNT(*) AS total_rows FROM absent;


/*absent and absenthours*/
SELECT gender,ROUND(SUM(absenthours),2) AS 'total hours' FROM absent
GROUP BY 1 
ORDER BY 2 DESC

/*age wise absenthours */

SELECT CEIL(age) age,  ROUND(SUM(absenthours),2) AS  'total hours' FROM absent
GROUP BY 1
ORDER  BY 2 DESC;

/*classify age groups */

SELECT  CASE 
 WHEN CEIL(age) >=1 AND CEIL(age) <20 THEN 'teenage'
 WHEN CEIL(age)>=20 AND CEIL(age)<35 THEN 'young age'
 WHEN CEIL(age) >=35 AND CEIL(age) <60 THEN 'middle age'
 ELSE 'old age'
END  AS 'age interval',
FORMAT(ROUND(SUM(absenthours),2),2) AS 'total',
FORMAT(ROUND(AVG(absenthours) ,2),2)AS 'avg hours'
FROM absent 
GROUP BY 1
ORDER BY 2 DESC;
              
/*min ,max and avg age group */

SELECT MIN(age) AS 'min age',MAX(age) AS 'max age',AVG(age) AS 'avg age' FROM absent;

SELECT absenthours FROM absent WHERE  CEIL(age)=(SELECT CEIL(MIN(age)) FROM absent WHERE age<>'N/A')


/*citywise  absenthours */

SELECT city,SUM(absenthours) AS SUM FROM absent
GROUP BY city
ORDER BY 2 DESC;


/*jobtitle  absenthours */

SELECT jobtitle ,SUM(absenthours) AS SUM FROM absent
GROUP BY jobtitle
ORDER BY 2 DESC;


/* departmentname */

SELECT departmentname,SUM(absenthours) 'total hours',AVG(absenthours)'avg absenthours'
FROM absent
GROUP BY 1
ORDER BY 2 DESC;



/*absent according to division */

SELECT division ,ROUND(SUM(absenthours),2) AS 'total hours',ROUND(AVG(absenthours),2) AS 'avg hours' FROM absent
GROUP BY 1 
ORDER BY 2 DESC;


/* absent according to  business  unit */

SELECT businessunit ,ROUND(SUM(absenthours),2) AS 'total hours',ROUND(AVG(absenthours),2) AS 'avg hours' FROM absent
GROUP BY 1 
ORDER BY 2 DESC;

/*lengthservice */

SELECT MIN(lengthservice) AS 'min lenghtservice',MAX(lengthservice) AS 'max length service' ,
AVG(lengthservice) AS  'avg lengthservice',
STDDEV(absenthours) AS 'standard deviation'
FROM absent

/* age in departmentname */
SELECT departmentname,ROUND(AVG(age),2) AS 'avg age' ,
ROUND(AVG(absenthours),2) AS 'avg absent hours',
ROUND(MAX(age),2) AS 'max age' 
,ROUND(MIN(age),2) AS 'min age' 
 FROM absent
GROUP BY 1 
order by 3 desc;


/*division  and age */

select division, round(avg(age),2) as 'avg age', round(avg(absenthours),2) 'avg absenthours',
round(max(age),2) 'max age',round(min(age),2) as 'min age'
from absent
group by 1
order by 3 desc;





