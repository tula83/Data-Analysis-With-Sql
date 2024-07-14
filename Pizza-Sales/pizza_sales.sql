/* pizza */

SELECT * FROM pizza;

/* total rows */
SELECT COUNT(*) 'total rows' FROM pizza ;


/*revenue */
SELECT  SUM(total_price) 'revenue' FROM pizza;



/*revenue by pizza size */

SELECT  pizza_size,FORMAT(ROUND(SUM(total_price),2) ,2)'total revenue' FROM  pizza
GROUP BY  1 
ORDER BY 2 DESC


/* revenue by pizza name*/

SELECT  pizza_name,FORMAT(ROUND(SUM(total_price),2) ,2)'total revenue' FROM  pizza
GROUP BY  1 
ORDER BY 2 DESC


/*revenue by pizza category */
SELECT  pizza_category,FORMAT(ROUND(SUM(total_price),2) ,2)'total revenue' FROM  pizza
GROUP BY  1 
ORDER BY 2 DESC


/* revenue by order date */
SELECT unit_price,FORMAT(ROUND(SUM(total_price),2) ,2)'total revenue' FROM  pizza
GROUP BY  1 
ORDER BY 2 DESC

/*revenue by pizza ingredients*/

SELECT  pizza_ingredients,FORMAT(ROUND(SUM(total_price),2) ,2)'total revenue' FROM  pizza
GROUP BY  1 
ORDER BY 2 DESC

/*order date and revenue*/

SELECT DAYNAME(STR_TO_DATE(order_date,'%m/%d/%y')) 'day name',COUNT(*) AS COUNT 
,ROUND(SUM(total_price),2) AS 'revenue'
FROM pizza 
GROUP BY 1
ORDER BY 3 DESC;


/*monthwise revenue */

SELECT MONTHNAME(STR_TO_DATE(order_date,'%m/%d/%y')) 'month',COUNT(*) AS COUNT 
,ROUND(SUM(total_price),2) AS 'revenue'
FROM pizza 
GROUP BY 1
ORDER BY 3 DESC;

/* time and revenue*/

SELECT HOUR(STR_TO_DATE(order_time,'%H:%i:%s')) 'hour',COUNT(*) AS COUNT 
,ROUND(SUM(total_price),2) AS 'revenue'
FROM pizza 
GROUP BY 1
ORDER BY 3 DESC;



/* pizza according to quantity */

SELECT pizza_name,  SUM(quantity) 'total'
FROM pizza 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

/* bottom 5 pizza according to quantity */
SELECT pizza_name,  SUM(quantity) 'total'
FROM pizza 
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5


/* finding  avg order value */
SELECT (SUM(total_price)/(SELECT  COUNT(DISTINCT order_id) FROM pizza)) 'order value'
FROM pizza

/*avg pizza per order*/
SELECT (SUM(quantity)/(SELECT COUNT(DISTINCT order_id) FROM pizza)) AS 'avg pizza per order' FROM pizza

/* total orders */

SELECT COUNT(DISTINCT order_id)'total orders' FROM pizza;


/*stddev in quantity*/
SELECT STDDEV(quantity) 'std dev',CEIL(AVG(quantity)),MAX(quantity) 'max quant',MIN(quantity) 'min qunat' FROM pizza







