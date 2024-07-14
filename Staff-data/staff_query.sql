SELECT COUNT(*) FROM company_divisions;

DELETE  FROM  staff WHERE  id=NULL;

SELECT STR_TO_DATE(start_date,'%m/%d/%Y') AS start_date FROM staff;

/*count of gender */
SELECT gender ,COUNT(*) AS COUNT FROM staff GROUP BY gender;
/*distinct departments */
SELECT DISTINCT(department)AS distinct_dept FROM staff ORDER BY distinct_dept;

/*max and min salary */
SELECT MAX(salary)AS 'max salary' , MIN(salary)AS 'min salary' FROM staff;

/* what about salary distribution by gender group? */
/* Data Interpretation: It seems like the average between male and female group is pretty close, 
with slighly higher average salary for Female group*/

SELECT gender, MIN(salary)  'min salary',MAX(salary) 'max salary', AVG(salary) 'average salary' 
FROM staff GROUP BY gender;


/* How much total salary company is spending each year? */

SELECT  SUM(salary) AS 'total salary' FROM staff

/* want to know distribution of min, max average salary by department */
/* Data Interpretation: It seems like Outdoors deparment has the highest average salary paid  and
 Jewelery department with lowest */ 
 
 SELECT department,
 FORMAT(MIN(salary),2) 'min salary',
 FORMAT(MAX(salary),2) 'max salary',
 FORMAT(AVG(salary),2) 'avg salary',
 FORMAT(VAR_POP(salary),2)'variance salary ',
 FORMAT(STDDEV_POP(salary),2) 'standard deviation salary',
 COUNT(*) 'total employee'
 FROM staff 
 GROUP BY department
 ORDER BY 4 DESC
 
 
 
 /* Let's see Health department salary */
 
 SELECT  department, salary FROM staff WHERE department LIKE  'Health';
 
/*creating  view  and bucket */
CREATE VIEW  outdoor_bucket
AS
SELECT department,
CASE 
  WHEN  salary >=100000 THEN 'higher earner '
  WHEN salary >=50000  AND  salary < 100000 THEN 'medium earner'
  ELSE 'lower earner'
  END AS income_status
FROM staff;
  
SELECT department , income_status,COUNT(*)AS COUNT  FROM outdoor_bucket
GROUP BY 2 ORDER BY 3 DESC


/*find department start with name B */
SELECT DISTINCT(department) FROM staff WHERE  department LIKE 'B%';

/* some important usecase */

SELECT DISTINCT job_title FROM staff WHERE job_title REGEXP '^[BSD]'

SELECT DISTINCT job_title FROM staff WHERE job_title LIKE '%Assistant I_'

SELECT department, ROUND(SALARY ,2) AS round_sal,ROUND(AVG(salary),2)AS avg_sal
FROM staff
GROUP BY department;


/*working with filters ,aggregations and joins */

SELECT s1.last_name  ,s1.salary,
   (
   SELECT ROUND(AVG(salary),2) FROM staff s2
   where s2.department=s1.department 
   )as department_average_salary
  
  from staff s1
   
  /* how many people are earning above/below the average salary of his/her department ? */
  
  create view sal_dept
  as
  select s1.last_name, s1.department ,
  ( s1.salary > ( select  round(avg(salary),2) from staff s2 
   where  s2.department=s1.department)
   )as higher_salary
   from staff s1
   
 select  department,higher_salary,count(*) as count  from sal_dept
 where  higher_salary <>0
   group by 1,2
   order by 3 desc
   
   
   
 
 /*who earns the most */
 select  department,round(avg(salary),2) as avg_sal  from staff
 where salary >=100000
 group by department
 order  by avg_sal desc;
 
 /* who earns the most in company */
 select last_name,department,salary 
 from staff where 
 salary = (select max(s2.salary) from staff s2)
 
select  last_name ,department,max(salary) from staff;


/* employees who earn most in their department */
select last_name,department,s1.salary from staff  s1
 where  s1.salary = (select  max(salary) from staff s2 
 where s1.salary=s2.salary)


/* full details info of employees with company division
Based on the results, we see that there are only 953 rows returns. We know that there are 1000 staffs.
*/
select count(*)as count from(
select last_name ,s1.department from staff s1
join company_divisions ds on ds.department = s1.department
 )as data
 



/*finding where company division is null */

select last_name , s1.department  from  staff s1
left join company_divisions  ds 
on  s1.department=ds.department
where ds.company_division  is null;




/* using  window   function */

select department,last_name,
salary,avg(salary) over (partition by department)
from staff;

select department ,last_name,salary ,max(salary) over (partition by department)
from staff;

SELECT department ,last_name,salary ,Min(salary) OVER (PARTITION BY department)
FROM staff;


/*--first value */
select department , salary,last_name,
first_value(salary) over(partition by department order by salary desc)
from staff;


/*using row number */

select last_name,department,salary 
,row_number() over(partition by department  order by salary desc)as part_data
from
staff  

/* finding  salary of person and next  lower salary of person */

select last_name,department,salary ,lag(salary)over(partition by department order by salary desc)as  'part_data'
from staff;


/* using lead functin */

select last_name,department,salary ,lead(salary) over(partition by department order by salary desc) as 'part data'
from staff

/* creating bins  */

select last_name,department,salary ,ntile(10) over(partition by department order by salary desc) as'part_data'
from staff;



















