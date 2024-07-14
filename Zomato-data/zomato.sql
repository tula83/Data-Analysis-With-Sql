SELECT * FROM zomato;

SELECT  rating,COUNT(*) AS COUNT FROM zomato
GROUP BY rating ORDER BY COUNT DESC;

SELECT  city,Restaurantname,COUNT(*) AS COUNT  FROM zomato GROUP BY city, restaurantname ORDER  BY 3 ;

---ROLLING/MOVING COUNT OF RESTAURANTS IN INDIAN CITIES

SELECT countrycode, city FROM zomato
WHERE countrycode=1
GROUP BY countrycode 
 
 
--- TYPES OF FOODS ARE AVAILABLE IN INDIA WHERE THE MAX RESTAURANTS ARE LISTED IN ZOMATO
WITH  count_table 
AS(
SELECT  city ,locality ,COUNT(restaurantid) AS count_id 
FROM zomato 
GROUP BY city,locality
)

select city,locality ,count_id from  count_table where count_id = (select max(count_id) from count_table) ;


/*finding online delivery */

select city,cuisines, count(*) 'online count' from zomato
where `Has_Online_delivery` ='yes'
group by  city,cuisines;


/* finding  price range */

select  city,cuisines ,count(*) as 'booking count'
from zomato where `Has_Table_booking`='Yes'
group by city,cuisines
order by 3 desc

/*price range */

SELECT price_range, city,cuisines ,COUNT(*) AS 'booking count'
FROM zomato WHERE `Has_Table_booking`='Yes'
GROUP BY price_range,city,cuisines
ORDER BY 4 DESC

/* switch  to order menu */
SELECT  city,cuisines ,COUNT(*) AS 'order menu count'
FROM zomato  where `Switch_to_order_menu` ='No'
GROUP BY city,cuisines
ORDER BY 3 DESC

/* finding average cost for two */

SELECT  city,cuisines , ceil(avg(rating))as 'avg rating',floor(avg(`Average_Cost_for_two`)) as 'average cost '
FROM zomato 
GROUP BY city,cuisines
ORDER BY 3 DESC

/* finding  for votest */

SELECT  city,cuisines , sum(votes) as votes
FROM zomato  
GROUP BY city,cuisines
ORDER BY 3 DESC


/* cost according to cost */

SELECT  city,`RestaurantName` ,sum(`Average_Cost_for_two`) as cost
FROM zomato  WHERE `Switch_to_order_menu` ='No'
GROUP BY `RestaurantName`
ORDER BY 3 DESC






