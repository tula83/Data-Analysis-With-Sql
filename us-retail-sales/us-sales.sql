SELECT  * FROM us_sales;

/*total rows */
SELECT COUNT(*) AS 'total rows ' FROM  us_sales;

/* count distinct rows */
SELECT COUNT(DISTINCT sales_month ) AS 'distinct rows' FROM us_sales;

/*kind of business */

SELECT  kind_of_business,COUNT(*) AS 'count'  FROM us_sales
WHERE kind_of_business LIKE '%vehicle%'
GROUP BY 1 
ORDER BY 2 DESC

/*reason for null */
SELECT reason_for_null,COUNT(*) AS COUNT FROM us_sales
group by 1

/* highest revenue in business */

select kind_of_business , sum(sales) as 'revenue' ,
format(avg(sales),2) as 'avg revenue' from us_sales
group by 1 
order by 2  desc


/* finding revenue in each year */
select year(sales_month) 'year',sum(sales) as 'revenue' from us_sales
group by 1 
order by 2 desc;

/*revenue in each month */

select monthname(sales_month) 'month',sum(sales) as 'revenue' from us_sales
group by 1 
order by 2 desc;

/* analytical */

select kind_of_business , sales_month,sales,
lag(sales_month) over(partition  by kind_of_business order by sales_month) as prev_month,
lag(sales) over(partition by kind_of_business order by sales_month) as 'prev_month_sales'
from us_sales
where kind_of_business='Book Stores'


/*percentage growth */

select sales_year,yearly_sales ,
lag(yearly_sales) over(order by sales_year) as 'prev_year_sales',
(yearly_sales/lag(yearly_sales) over(order by sales_year)-1)*100 as 'pct growth from year'
from 
(select monthname(sales_month) as sales_year,sum(sales)  as 'yearly_sales'
from us_sales  
where kind_of_business='Clothing and clothing access. stores'
group by 1 )a

/* finding revenue in mens ans womens collection */
select kind_of_business ,
sum(sales) as 'revenue'
from us_sales
where kind_of_business in ('Men''s clothing stores' ,'Women''s clothing stores')
group by 1
order by 2 desc


/*finding yearly revenue in each categories */
select year(sales_month) as 'sales year'
,sum(case when kind_of_business='Men''s clothing stores' then sales end ) 'mens sales'
,sum(case when kind_of_business='Women''s clothing stores' then sales end) 'womens sales'
from us_sales
where kind_of_business in ('Women''s clothing stores','Men''s clothing stores')
group by 1

/*calculating cummulative values*/


select sales_month,sales,sum(sales) over (partition by monthname(sales_month) order 
by sales_month) as sales_ytd from us_sales
where kind_of_business='Women''s clothing stores'












