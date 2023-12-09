/* there are tables like employee, dept_emp, department,manager_emp,salaries,title_emp */


/* list employees joined in 1984  */
SELECT  CONCAT(first_name," ",last_name)
AS NAME,YEAR(hire_date)AS joining_year FROM employee WHERE hire_date BETWEEN
'1986-01-01' AND '1986-12-30'

/*  list the name ,department name */

SELECT first_name,dept_name  FROM employee  e
JOIN dept_emp d1 ON e.emp_no=d1.emp_no
JOIN  departments d2 ON d1.dept_no=d2.dept_no

/* List first name, last name, and sex for employees whose 
first name is "Hercules" 
and last names begin with "B." */

SELECT  first_name  ,last_name ,sex FROM employee 
WHERE first_name='Hercules'  AND lasst_name LIKE 'B%'


/* List all employees in the Sales and Development department, 
including their employee number, last name, first name, 
and department name  */

SELECT  CONCAT(first_name," ",last_name)AS NAME , dept_name
dept_name FROM employee e1 JOIN dept_emp AS ed
ON e1.emp_no=ed.emp_no 
JOIN departments d1 ON ed.dept_no=d1.dept_no
WHERE dept_name='Sales' OR dept_name='Development'
 


 /*  In descending order, list the frequency count of employee last names, i.e., 
 how many employees share each last name.*/
 
 SELECT last_name, COUNT(last_name)AS common_last_name 
 FROM employee GROUP BY last_name ORDER BY last_name DESC;
 


/* finding manager in each department */

SELECT  CONCAT(first_name," ",last_name)AS NAME ,dept_name  FROM  employee e1 
JOIN manager_emp me ON e1.emp_no=me.emp_no
JOIN departments ds ON me.dept_no=ds.dept_no


/* finding max_salary  and average salary*/

SELECT CONCAT('$',MAX(salary)) AS max_sal,CONCAT('$',ROUND(AVG(salary),2))AS avg_sal FROM employee e1 JOIN salaries s1 
ON e1.emp_no=s1.emp_no


/* finding max salary in each department */

SELECT  CONCAT(first_name,' ',last_name) AS NAME,dept_name,MAX(salary)AS max_salary  FROM employee e1 
JOIN salaries sr ON e1.emp_no  = sr.emp_no
JOIN dept_emp de 
ON sr.emp_no=de.emp_no  
JOIN  departments ds ON de.dept_no=ds.dept_no
GROUP BY ds.dept_no ORDER BY salary DESC;
