SELECT * FROM hiring 

SELECT COUNT(*) AS COUNT FROM hiring;


/* hiring  % in each month */
SELECT MONTHNAME(STR_TO_DATE(`Interview_Taken_on`,'%m/%d/%y %k:%i')) AS MONTH, 
CONCAT(COUNT(*)*100/(SELECT COUNT(*) FROM hiring),'%')AS COUNT 
FROM hiring
GROUP  BY  MONTH
ORDER BY COUNT


/* male and female hired */

SELECT  event_name,COUNT(*) AS 'total' FROM hiring
WHERE STATUS='hired'
GROUP BY event_name;


/* male and female  interviewed */

SELECT  event_name,COUNT(*) FROM hiring
GROUP BY event_name;

/*hired in department */

SELECT department,COUNT(*) AS COUNT FROM hiring
WHERE STATUS='hired'
GROUP BY department
ORDER BY 2 DESC;


/* number of post for hired */
SELECT post_name,COUNT(*) AS 'number of hiring' FROM hiring
WHERE STATUS='hired'
GROUP BY post_name
ORDER BY 2 DESC;

/*offered salary */

SELECT MAX(offered_salary) AS 'max sal' ,
MIN(offered_salary) AS 'min sal',
AVG(offered_salary) AS 'avg sal' FROM hiring

UNION ALL

SELECT MAX(offered_salary) AS 'max sal' ,
MIN(offered_salary) AS 'min sal',
AVG(offered_salary) AS 'avg sal' FROM hiring
where status='hired'


/* number of positions in each department */

select department,count(distinct post_name) as 'position'
from hiring
group by 1
order by 2 desc

/* avg salary offered in each department */
SELECT department,round(avg(offered_salary),2) AS 'avg salary'
FROM hiring
GROUP BY 1
ORDER BY 2 DESC



/*count staus */

select status,concat(count(*)*100/(select count(*) from hiring),'%') as  'hired percentage' 
from hiring
group  by status;


/*male and female in each posts */
select post_name,event_name ,concat(count(*)*100/(select count(*) from hiring),'%') as count from hiring
group by 1,2
order by 3 desc












