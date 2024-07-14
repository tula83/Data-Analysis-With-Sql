/*date and count */
SELECT  DATE, COUNT(*) AS COUNT FROM
call_center GROUP BY  DATE 
ORDER BY 2 DESC

/* call happen in weekday */
SELECT DAYNAME(DATE)AS 'day',COUNT(*) AS COUNT FROM call_center
GROUP BY 1 
ORDER BY 2 DESC

/* answered  */
SELECT  `Answered_`,`Resolved`,COUNT(*) AS COUNT
FROM call_center 
GROUP BY `Answered_`,`Resolved`
ORDER BY 3 DESC


/*RESOLVED */
SELECT `Resolved`,count(*) as count from  call_center 
group by `Answered_`
order by 2 desc;

/*topic related */

select `Topic` ,count(*) as count from  call_center 
group by 1 
order by 2  desc;


/*speed  */
select avg(speed),max(speed),min(speed) from call_center ;

/*  duration */

select avg(duration) 'avg duration',min(duration) 'min duration',
max(duration) 'max duration' from call_center 

/* rating */
select avg(`Satisfaction_rating`) as 'average rating' ,min(`Satisfaction_rating`)  as 'min rating',
max(`Satisfaction_rating`) as 'max rating' from 
call_center;

/* rating count */

select `Satisfaction_rating`, count(*) as count from call_center
group by 1
order by 2 desc

/* agen count*/

select agent,count(*) as count 
from   call_center 
group by agent
order by 2 desc;


/* duration of  call by agent */
select agent,round(sum(time),2) as duration 
from call_center group  by agent
order by 2 desc

/* call answered */

select `Answered_`, concat(count(*)*100/(select  count(*) from call_center),'%' ) as portion 
from call_center group by `Answered_`


/*highest rating */

select agent,avg(`Satisfaction_rating`) as sum from call_center
group by agent  order by 2 desc;


/* total calls answered monthwise */

select monthname(date) as month ,ANSWERED_,count(*) count from call_center
group by 1 ,ANSWERED_
order by 2 desc;















