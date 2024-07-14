SELECT * FROM  credit_trnx

/* total rows */
SELECT COUNT(*) 'total rows' FROM credit_trnx;

/*city*/

SELECT COUNT(DISTINCT city) AS ' total unique cities'  FROM credit_trnx

SELECT city,COUNT(*) AS 'count' FROM credit_trnx   
GROUP BY city
ORDER BY 2 DESC;

/* lowest number of cities */
SELECT city,COUNT(*) AS 'count' FROM credit_trnx   
GROUP BY city
ORDER BY 2 ASC LIMIT 20

/* count  card_type*/
SELECT COUNT(DISTINCT card_type) AS 'distinct credit card' FROM credit_trnx; 

/*popular card */
SELECT  card_type,COUNT(*) 'count' 
 FROM credit_trnx
GROUP BY 1 
ORDER BY 2 DESC

/* male and female count */
SELECT  gender,COUNT(*) AS COUNT FROM credit_trnx
GROUP BY gender 
ORDER BY 2 DESC


/*most common exp_type */
SELECT exp_type,COUNT(*) AS COUNT FROM credit_trnx
GROUP BY 1 
ORDER BY 2 DESC;

/* revenue by card */

SELECT  card_type,SUM(amount) AS 'total revenue' FROM credit_trnx
GROUP BY card_type
ORDER BY 2 DESC;


/* revenue  in each month*/
DROP VIEW trnx_year_view;

CREATE VIEW  trnx_year_view AS 
SELECT STR_TO_DATE(transaction_date,'%d-%m-%y') trnx_date ,city,card_type,amount,gender,exp_type
FROM credit_trnx ;

/*getting data from view */
/*there is only one year  i.e 2020 */

SELECT YEAR(trnx_date) AS 'year' , SUM(amount)  AS 'revenue'
FROM trnx_year_view
GROUP BY 1 
ORDER BY 2 DESC

/*monthwise revenue*/
SELECT MONTHNAME(trnx_date) 'month' ,FORMAT(SUM(amount),2) AS 'total revenue',
FORMAT(AVG(amount),2) AS 'avg revenue',
FORMAT(MIN(amount),2) AS 'min revenue',
FORMAT(MAX(amount),2) AS 'max revenue'
FROM  trnx_year_view
GROUP BY 1 
ORDER BY 2 DESC


/*who spends the most*/
SELECT  gender,FORMAT(SUM(amount),2) AS 'total'
FROM credit_trnx 
GROUP BY 1
ORDER BY 2 DESC;


/* top 10  citywise revenue */
SELECT city,FORMAT(SUM(amount),2) AS 'revenue'
FROM credit_trnx 
GROUP BY 1 
ORDER BY 2 DESC
LIMIT 10;


/*  who uses the which card most */
SELECT  gender ,card_type,COUNT(*) AS COUNT 
FROM trnx_year_view
GROUP BY 1 ,2
ORDER BY 3 DESC

/* female uses silver and male uses platinum most */



/*gender  preference for  expense */
--female uses  card food,bill AND male FOR fuel

SELECT  gender ,exp_type,COUNT(*) AS COUNT 
FROM trnx_year_view
GROUP BY 1 ,2
ORDER BY 3 DESC


/*card used for exp_type*/
--silver IS used  widely EXCEPT travel 
SELECT card_type,exp_type,COUNT(*) AS COUNT 
FROM trnx_year_view
GROUP BY 1 ,2
ORDER BY 3 DESC





