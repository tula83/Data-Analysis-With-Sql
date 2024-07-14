SELECT * FROM customer

/* total rows */
SELECT COUNT(*) 'total customers' FROM customer;

/* analysing amount spend */

SELECT  cs.customer_id ,SUM(amount) AS 'toal amount' FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id
GROUP BY 1 
ORDER BY 2 DESC;

/*cards and amount spent */
SELECT  card_type ,SUM(amount) AS 'toal amount' FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id
GROUP BY 1 
ORDER BY 2 DESC;


/*datewise analysis*/
SELECT YEAR(DATE) 'year',SUM(amount) AS 'toal amount' FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id
GROUP BY 1 
ORDER BY 2 DESC;



/*monthwise analysis */
SELECT  MONTHNAME(DATE) 'month',SUM(amount) AS 'toal amount' FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id

GROUP BY 1 
ORDER BY 2 DESC;

/*location wise analysis*/

SELECT  city ,SUM(amount) AS 'toal amount' FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 10


/*job segment analysis*/
SELECT  job_segment ,SUM(amount) AS 'toal amount' FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id
GROUP BY 1 
ORDER BY 2 DESC;

/*age wise analysis*/
SELECT  age ,SUM(amount) AS 'toal amount' FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 10



/* product_type and card used frequently */

SELECT card_type, product_type ,SUM(amount) AS 'toal amount' FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id
GROUP BY 1 ,2
ORDER BY 3 DESC
LIMIT 10

/*less card used */
SELECT card_type, product_type ,SUM(amount) AS 'toal amount' FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id
GROUP BY 1 ,2
ORDER BY 3 ASC
LIMIT 10


/*card and age */
SELECT age,card_type,SUM(amount) AS 'toal amount' FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id
GROUP BY 1 ,2
ORDER BY 3 DESC
LIMIT 10


/*credit limits */
CREATE VIEW  credit_max AS
 SELECT  MAX(credit_limit) FROM customer   


/*customer spending within credit limit */
SELECT  cs.customer_id ,SUM(amount) AS 'toal amount' ,SUM(credit_limit) 'credit limit'
FROM  customer cs
JOIN spend sp ON cs.customer_id=sp.customer_id
GROUP BY 1
ORDER BY 3 DESC
LIMIT 10






/* repayment date*/
CREATE VIEW repayment_view 
AS  SELECT customer_id,STR_TO_DATE(DATE,'%m/%d/%Y')AS 'date',amount FROM repayment

/*negative payment  and customer */

WITH  cte 
AS
(SELECT sp.customer_id,sp.date 'spend_days',rp.date 'payment_date',ABS(DATEDIFF(rp.date,sp.date)) 'days',
sp.amount 'spend_amount',rp.amount 'repayment_amount',(sp.amount-rp.amount) AS 'dues'
FROM  spend sp
JOIN repayment_view rp ON sp.customer_id=rp.customer_id
GROUP BY 1 
HAVING dues <0)

SELECT   cte.customer_id ,spend_days,payment_date,days,cr.credit_limit,spend_amount,repayment_amount,
dues FROM cte 
JOIN 
customer cr 
ON cte.customer_id=cr.customer_id

SELECT * FROM repayment_view;



/* credit limint according to job_segment*/
SELECT job_segment,AVG(credit_limit) 'avg credit limit' FROM customer 
GROUP BY 1


SELECT STDDEV(credit_limit) 'standard deviation' FROM customer;



/* most common type expenses*/
SELECT  product_type,COUNT(*) AS 'count'
FROM spend
GROUP BY 1 
ORDER BY 2 DESC;

/*average spend per category*/

SELECT product_type,AVG(amount) AS 'avg spending' FROM spend
GROUP BY 1 
ORDER BY 2 DESC;



/* top 5 cities  with highest amount of spend */

WITH top_customer AS (
SELECT customer_id,ROUND(SUM(amount)) 'amount',COUNT(*) 'count'
FROM spend 
GROUP BY 1
ORDER BY 2 DESC
)

SELECT city ,SUM(amount) 'total amount',SUM(COUNT) 'total transaction' FROM customer cs
JOIN top_customer tc
ON cs.customer_id=tc.customer_id
GROUP BY 1
ORDER BY 2 DESC;



 ---Q14. What IS the spending RANGE OF EACH customer?
 
 SELECT customer_id,CONCAT(MAX(amount),'-',MIN(amount)) 'amount range' FROM spend
 GROUP BY 1
 
 ---citywise customer
 
 SELECT city,COUNT(*) AS  'total customer' FROM customer
 GROUP BY 1
 ORDER BY 2 DESC;
 
 
 --- What IS the average no. OF days a customer pays off their credit card bill?


WITH cte AS(
   SELECT sp.customer_id,
   MAX(sp.date) AS spend_date,
   MAX(rp.date) AS payment_date,
   ABS(DATEDIFF(MAX(rp.date),MAX(sp.date))) AS 'days'
   FROM spend sp
   JOIN customer ON sp.customer_id=customer.customer_id
   JOIN repayment_view rp ON rp.customer_id=customer.customer_id
   GROUP BY 1)
   
   SELECT ROUND(AVG(days)) 'avg-days' FROM cte;










