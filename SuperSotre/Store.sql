--- There is table  superstore 


SELECT  DISTINCT(customerid),city,sales,profit,discount,DATEDIFF(STR_TO_DATE(shipdate,'%m-%d-%Y'),STR_TO_DATE(orderdate,'%m-%d-%Y'))
AS conversion_days FROM  superstore 
ORDER BY  profit DESC ,conversion_days DESC;



SELECT  COUNT(*)AS negative  FROM
(SELECT shipdate,orderdate ,DATEDIFF(STR_TO_DATE(shipdate,'%m-%d-%Y')
,STR_TO_DATE(orderdate,'%m-%d-%Y')) AS delivery
FROM  superstore )AS result WHERE result.delivery <0


SELECT state,SUM(sales)AS sales,SUM(profit)AS profit  FROM  superstore  WHERE state LIKE'M%ontan%' GROUP BY state ORDER BY profit DESC;

SELECT city, SUM(sales)AS sales,SUM(profit)AS profit  FROM  superstore  GROUP BY city ORDER BY profit DESC;

SELECT  category,sales,profit FROM superstore GROUP BY category ORDER BY profit DESC;

SELECT  category,subcategory,sales,profit FROM superstore GROUP BY subcategory ORDER BY profit DESC;

SELECT productname,sales,profit FROM superstore GROUP BY productname ORDER BY sales DESC;

SELECT  segment,sales,profit FROM superstore GROUP  BY segment ORDER BY profit DESC;

SELECT postalcode,region,sales,profit  FROM  superstore  GROUP BY postalcode ORDER BY profit DESC;

/-- fiding which time the profit was highest/
SELECT orderdate,sales,profit  FROM superstore GROUP BY orderdate ORDER BY profit DESC LIMIT 10;


SELECT YEAR(STR_TO_DATE(orderdate,'%m-%d-%Y')) AS order1,sales,profit  FROM superstore GROUP BY order1 ORDER BY
profit DESC;

SELECT  DATE_FORMAT(STR_TO_DATE(orderdate,'%m-%d-%Y'),'%m') AS order_year,sales,profit FROM superstore
GROUP BY order_year;


SELECT MONTHNAME(STR_TO_DATE(orderdate,'%m-%d-%Y')) AS order_in_month,sales,profit  FROM superstore GROUP BY order_in_month ORDER BY
profit DESC;


SELECT DAYNAME(STR_TO_DATE(orderdate,'%m-%d-%Y')) AS order_in_day,sales,profit  FROM superstore GROUP BY order_in_day ORDER BY
profit DESC;



SELECT  YEAR(STR_TO_DATE(orderdate,'%m-%d-%Y') ) AS YEAR ,
CASE WHEN MONTH(STR_TO_DATE(orderdate,'%m-%d-%Y')) IN (1,2,3) THEN 'Q1'
 WHEN  MONTH(STR_TO_DATE(orderdate,'%m-%d-%Y')) IN (4,5,6) THEN 'Q2'
 WHEN  MONTH(STR_TO_DATE(orderdate,'%m-%d-%Y')) IN (7,8,9) THEN 'Q3'
 ELSE 'Q4'
 END AS QUARTER,SUM(sales)AS sales,SUM(profit) AS profit
 
 FROM superstore GROUP BY  YEAR ,QUARTER ORDER BY YEAR ASC,QUARTER
 
 /* finding overall quater result */
  
 SELECT  
CASE WHEN MONTH(STR_TO_DATE(orderdate,'%m-%d-%Y')) IN (1,2,3) THEN 'Q1'
 WHEN  MONTH(STR_TO_DATE(orderdate,'%m-%d-%Y')) IN (4,5,6) THEN 'Q2'
 WHEN  MONTH(STR_TO_DATE(orderdate,'%m-%d-%Y')) IN (7,8,9) THEN 'Q3'
 ELSE 'Q4'
 END AS QUARTER,CONCAT('$',SUM(sales))AS sales, CONCAT('$',SUM(profit)) AS profit
 
 FROM superstore GROUP BY QUARTER ORDER BY profit DESC ,QUARTER
 
  

/* finding  profit margins */

SELECT region,ROUND(SUM(profit)/SUM(sales) * 100,2)AS profit_margin 
FROM superstore GROUP BY region ORDER BY profit_margin DESC

/* relationship between the discount and sales  and the total discount per category */

SELECT discount,ROUND(AVG(sales),2)AS average_sales FROM superstore GROUP BY discount ORDER BY average_sales DESC


/* Let’s observe the total discount per product category and subcategory*/


SELECT category,subcategory,SUM(discount)AS discount_amt FROM superstore GROUP BY category,subcategory ORDER BY  discount_amt DESC


/*What category generates the highest sales and profits in each region and state ? */

SELECT  region,state,category,SUM(sales) AS total_sales,SUM(profit)AS total_profit,
ROUND((SUM(profit)/SUM(sales ))* 100,2) AS profit_margin
 FROM superstore GROUP BY category
ORDER BY profit DESC, sales DESC


/*  Let’s observe the highest total
sales and total profits per Category in each region */

SELECT  region,category ,SUM(sales)AS total_sales,SUM(profit)AS total_profit 
FROM superstore
GROUP BY region,category ORDER BY total_profit DESC


/* let’s see the highest total sales and total profits per Category in each state */

SELECT  state,category,SUM(sales)AS total_sales,SUM(profit) AS total_profit FROM superstore 
GROUP BY state,category ORDER BY total_profit DESC;


/* let’s see the highest total sales and total profits per subCategory in each state */

SELECT subcategory,SUM(sales)AS total_sales,SUM(profit) AS total_profit FROM superstore 
GROUP BY state,subcategory ORDER BY total_profit DESC;

/*  What are the names of the products that are the most and least profitable to us */

SELECT SUBSTRING(productname,1,12)AS product_name ,SUM(profit)AS total_profit FROM superstore GROUP BY productname
ORDER BY total_profit DESC;


SELECT SUBSTRING(productname,1,12)AS product_name ,SUM(profit)AS total_profit FROM superstore GROUP BY productname
ORDER BY total_profit LIMIT 10;



/* What segment makes the most of our profits and sales */


SELECT segment,SUM(sales)AS total_sales,SUM(profit)AS total_profit FROM 
superstore GROUP BY segment ORDER BY total_profit DESC;

/* Let’s say we want to build a loyalty and rewards program in the future */

SELECT customerid,SUM(sales)AS total_sales,SUM(profit)AS total_profit FROM 
superstore GROUP BY customerid ORDER BY total_sales DESC;







