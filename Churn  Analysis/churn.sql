/* count of churn customer */
SELECT COUNT(*)  FROM  churn 
WHERE churn='Yes'

/*count of distinct customerid */

SELECT  COUNT(DISTINCT  customerID) AS COUNT  FROM   churn;


/* churn  by gender */

SELECT gender, COUNT(*)*100/(SELECT COUNT(*) FROM churn) AS 'churn percentage' FROM  churn 
GROUP BY churn 


/* churn by seniorcitizen */

SELECT 'senior citizen' AS 'people category' ,CONCAT(COUNT(*)*100/(SELECT COUNT(*) FROM churn),'%') AS 'percentage' FROM churn  WHERE `SeniorCitizen` = 1
UNION ALL
SELECT 'partner' AS 'people category' , CONCAT(COUNT(*)*100/(SELECT COUNT(*) FROM churn),'%') AS 'percentage' FROM churn  WHERE `partner` = 'Yes'
UNION ALL
SELECT 'dependents' AS 'people category' ,CONCAT(COUNT(*)*100/(SELECT COUNT(*) FROM churn),'%') AS 'percentage' FROM churn  WHERE `dependents` = 'Yes'


/*churn by payment sevice */

SELECT `PaymentMethod`,COUNT(*) AS COUNT  FROM  churn
WHERE churn='Yes'
GROUP BY `PaymentMethod`
ORDER BY 2 DESC;

/* churn  by tenure */

SELECT tenure,COUNT(*) AS COUNT FROM churn
where churn = 'Yes'
group by tenure
order by 2  desc limit 10


/* churn by contract */
select  contract,count(*) as count from  churn 
where churn='Yes'
group by contract 
order by 2 desc

/*churn by phone service */

select phoneservice, count(*) as  count from churn 
where churn='Yes'
group by 1

/* churn by multiple services */

SELECT multiplelines, COUNT(*) AS  COUNT FROM churn 
WHERE churn='Yes'
GROUP BY 1

/* internet serivce */
SELECT internetservice, COUNT(*) AS  COUNT FROM churn 
WHERE churn='Yes'
GROUP BY 1

/* online security */
SELECT onlinesecurity, COUNT(*) AS  COUNT FROM churn 
WHERE churn='Yes'
GROUP BY 1


/*online backup */
SELECT onlinebackup, COUNT(*) AS  COUNT FROM churn 
WHERE churn='Yes'
GROUP BY 1

/*device protection */

select deviceprotection,count(*) as count from  churn
where churn='Yes'
group by 1


/*tech support */
SELECT techsupport, COUNT(*) AS  COUNT FROM churn 
WHERE churn='Yes'
GROUP BY 1

/* streaming tv */

SELECT `StreamingTV`, COUNT(*) AS  COUNT FROM churn 
WHERE churn='Yes'
GROUP BY 1

/* streaming movies */
SELECT streamingMovies, COUNT(*) AS  COUNT FROM churn 
WHERE churn='Yes'
GROUP BY 1


/* contract count */
select contract,count(*) as count from churn
group by 1 ;
/* when churn is yes */
SELECT contract,COUNT(*) AS COUNT FROM churn
where churn='Yes'
GROUP BY 1 ;


/* monthly charges */
select max(monthlycharges) as 'max charge',min(`MonthlyCharges`)
as 'min charge'
,round(avg(`MonthlyCharges`),2)  as 'avg charge'
from churn;

/* select total charges and monthly charges */

SELECT customerId, sum(totalcharges) as 'total charges',
avg(monthlycharges) as 'avg monthly charges'
FROM churn where churn='Yes'
group by customerId
order by 2 desc limit 20


/*num tech tickets*/

select sum(`numTechTickets`) as 'sum of techtickets' ,sum(`numAdminTickets`) 
as 'admin tickets'
from churn where churn='Yes'
group by  customerId;


/* paperless billing */
select count(*) 'count paperless billing'
from churn where `PaperlessBilling`='Yes'


/*streaming tv*/
select streamingtv ,count(*) as count from  churn 
where churn='Yes'
group by 1 

/*checking  total charges due to streaming tv*/

select streamingtv,round(sum(monthlycharges),2) 'total monthly charges' 
from churn 
where churn='Yes'
group by 1
order by 2 desc

SELECT  streamingtv,ROUND(SUM(monthlycharges),2) 'total monthly charges' 
FROM churn 
WHERE churn='No'
GROUP BY 1
order by 2  desc

/* churn yes and streaming tv*/

select streamingtv,count(churn) 'number of churn'
from churn 
where churn='Yes' 
group by 1
order by 2 desc;

--there is no streaming tv and count of churn exceeds  than  having it


/*exploring contract */

select distinct contract 'contract'  from churn;

select contract ,count(*) as count 
from churn
where churn ='Yes'
group by 1 
order by 2 desc



SELECT contract ,round(avg(monthlycharges),2) 'avg monthly charges'
FROM churn
WHERE churn ='Yes'
GROUP BY 1 
ORDER BY 2 DESC

select min(monthlycharges) 'min charge',max(monthlycharges) 'max charge'
,avg(monthlycharges) 'avg charge'
from churn 

/* what was charge where churn happens */
select 'churn yes' as 'condition', avg(monthlycharges) 'avg monthly charge' from churn 
where  churn='Yes'
union all
SELECT 'churn no' as 'condition', AVG(monthlycharges) 'avg monthly charge' FROM churn 
WHERE  churn='No'

/* device protection*/
select 'churn  yes' as 'condition', deviceprotection,count(*) as count  
from churn
where churn='Yes'
group by 2
union all
SELECT 'Churn no' AS 'condition' ,deviceprotection,COUNT(*) AS COUNT  FROM churn
WHERE churn='No'
GROUP BY 2 
order by 3


select deviceprotection ,count(*) as count 
from churn 


/* row number */
select customerid,totalcharges,row_number() over(order by totalcharges desc) total_charge_rank from
churn
limit 10 

/*partition rank and partition  */


SELECT customerid,gender,tenure,dense_rank() OVER( partition by gender order by  tenure DESC) total_charge_rank 
FROM churn


/* partition and dense rank with multiple lines */

SELECT customerid,internetservice,  totalcharges,dense_rank() OVER(partition by internetservice  ORDER BY totalcharges DESC) total_charge_rank 
FROM churn
order by 2 


/* using  nitle */

SELECT customerid,internetservice,tenure,  totalcharges,ntile(10) OVER( partition by  internetservice  ORDER BY tenure DESC) total_charge_rank 
FROM churn

