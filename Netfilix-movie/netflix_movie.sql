/* production and  title */

SELECT  `production_countries`,COUNT(*) AS 'film count' FROM titles
WHERE TYPE='movie'
GROUP BY `production_countries` 
ORDER BY 2 DESC  LIMIT 10

/*age_certification*/
SELECT `age_certification`,COUNT(*) AS COUNT FROM titles 
GROUP  BY `age_certification` ORDER BY 2 DESC 

/*year*/
SELECT release_year,COUNT(*) AS COUNT FROM  titles 
GROUP BY 1 ORDER BY 2 DESC LIMIT 10

/* runtime  and type=movie or show */

select genres ,count(*) as count,round(avg(runtime),2) as 'avg runtime' from titles 
where type='movie'
group by 1 
order by 2 desc;

/* imdb score */

select type ,round(avg(`imdb_score`),2) as 'avg score',
round(avg(tmdb_score),2) as 'avg tmdb score',
round(avg(`tmdb_popularity`),2) 'avg tmdb popularity',
round(avg(tmdb_score),2) 'avg tmdb score'
from titles group by 1

/* movies in each decades */
select concat(floor(release_year/10)*10,'s') as 'rel_year',
count(*) as count
from titles 
group by 1
order by 1


/* production and imbd */
select `production_countries`, round(avg(`imdb_score`),2) as 'avg imdb',
round(avg(`tmdb_score`),2) as 'avg tmdb'
from titles
group by `production_countries`
order by 2 desc


/* age certification */

select `age_certification`,count(*) as count
from titles  where type='movie'
and `age_certification` != 'n/a'
group by `age_certification`
order by 2 desc


/* using credits */


select title ,count(*) as 'number of appearance '
from credits  WHERE roles='director'
group by title
order by 2 desc limit 20

/* average runtime for shows and movies */
select  'movies' as content_type,
round(avg(runtime),2) as 'avg runtime'
from titles 
where type='movie'
union all
select 'show' as content_type,
round(avg(runtime),2) as 'avg runtime'
from titles where type='show'



/* finding titles and directors */
select `release_year`, t.title,cr.title as 'director' from  titles t
join credits cr on cr.id=t.id
where type='movie'
and release_year >='2010'
and cr.roles='director'
order by `release_year`

/* seasons */
select  title,sum(seasons)as 'sum'
from titles 
group by title
order by 2 desc  limit 20


/* which genres has the most shows */

select genres, count(*) as 'count show'
from titles  
WHERE TYPE='show'
group by genres

order by 2 desc limit 20

/* titles and directors with highest movie rating */

select t.title,cr.title
from  titles t join credits cr
on t.id=cr.id
where t.type='Movie'
and t.`imdb_score` > 7.5
and t.`tmdb_popularity` >30
and cr.roles='director'


/* actors  who have starred in the most  shows and movie */
select  t.title,cr.title ,count(*) as 'highly rated'
from titles t join credits cr
on t.id=cr.id
where cr.roles='actor'
and t.type='show' or t.type='movie'
and t.`imdb_score`= 7
and t.`tmdb_score`=7
group by cr.title
order by 3 desc limit 20


/* Which actors/actresses played the same character in multiple movies or TV shows?  */

select cr.title as 'actor /actress' ,cr.characters
count(*) as count
from titles t join credits cr
on t.id=cr.id
where  cr.roles='actor' or cr.roles='actress'
group by cr.title, cr.charcters


/* Which actors/actresses played the same character in multiple movies or TV shows?  */

select  cr.title ,cr.characters,count(*) as count
from credits cr
join titles t on cr.id=t.id
where cr.roles='actor' or cr.roles='actress'
group by cr.title,cr.characters
having count(t.title) >=1
limit 20

/* average imdb score for leading roles  in tv or shows */
select cr.title as 'actor_actress',
round(avg(t.`imdb_score`),2) as  'avg rating'
from credits cr  join titles t
on cr.id=t.id
where cr.roles='actor' or cr.roles='actress'
and cr.characters='leading role'
group by cr.title
order by 2 desc
limit 20





