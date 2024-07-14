/* finding top 10 genre  */

SELECT genre , COUNT(*) AS COUNT FROM movies
GROUP BY genre ORDER BY 2 DESC LIMIT 10


/*movie according to audience score */

SELECT film ,audience_score 'max score ' FROM  movies
WHERE `Audience_score` = (SELECT MAX(`Audience_score`) FROM movies)

/*rotten tomatoes */
SELECT `Rotten_Tomatoes`,COUNT(*) AS COUNT  FROM movies
GROUP BY  `Rotten_Tomatoes`
ORDER BY  1 DESC LIMIT 10 

/* worldwidegross and genre */
SELECT genre, SUM(`Worldwide_Gross`) AS 'sum',AVG(`Worldwide_Gross`) AS 'average gross' FROM movies 
GROUP BY  genre ORDER BY 2 DESC;

/* year and gross */

SELECT YEAR, SUM(`Worldwide_Gross`) AS 'gross sum' 
FROM  movies GROUP BY  YEAR
ORDER BY 2 DESC;

/* profitability and film */

SELECT genre,  SUM(`Profitability`) AS 'sum profit' FROM movies 
GROUP BY genre ORDER BY 2 DESC;


/* leadstudio and  film */

SELECT `Lead_Studio`,  SUM(`Profitability`) AS 'sum profit' FROM movies 
GROUP BY `Lead_Studio` ORDER BY 2 DESC;

/*rotten tomatoes */
SELECT  `Rotten_Tomatoes`,SUM(`Worldwide_Gross`) AS 'gross wide ',  SUM(`Profitability`) AS 'sum profit' FROM movies 
GROUP BY `Rotten_Tomatoes` ORDER BY 2 DESC;

