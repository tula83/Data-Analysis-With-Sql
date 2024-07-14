/* release  year  and  count */
SELECT release_year,track_name,artist_name,COUNT(*) AS COUNT FROM
spotify GROUP BY release_year,artist_name
ORDER BY 4 DESC LIMIT 10


/* artist popularity */

SELECT artist_name ,release_year,AVG(`artist_popularity`) 'average popularity '
FROM spotify GROUP BY  1 ,release_year
ORDER BY 3 DESC LIMIT 10

/* which gives danceability */

SELECT artist_name,release_year,AVG(danceability)
FROM spotify 
GROUP BY artist_name,2
order by 3 desc limit 10


/* which  has the highes energy  per year  */

select artist_name,release_year,avg(energy)  as 'average energy' from spotify 
group by 1 , 2 
order by 3 desc limit 10

select track_name,avg(loudness) from spotify
group by 1 
order by 2 desc 
limit 10

/* duration */
select track_name, artist_name,round(duration_ms/(3600*60),2) as 'time'  from spotify
order by duration_ms desc limit 10


/*liveness */
select  artist_name,track_name ,round(sum(liveness),2) 'liveness sum'
from spotify group by artist_name
order by 3 desc limit 10

/* ditinct track name on the basis of popularity */

select distinct  track_name,album,artist_name,release_year,track_popularity
from spotify 
order by track_popularity desc
limit 10



/* top song  for each year 2000 to 2022 based on popularity */

select release_year,track_name,album,artist_name, track_popularity 
from ( 

   select release_year,track_name, album,artist_name, track_popularity ,
   row_number() over ( partition by release_year order by track_popularity desc ) as rank2
   from spotify 
   
   )ranked_songs
   where rank2=1
   
  
  
/* analysis based  on tempo */

select avg(tempo)  from spotify 


/*classify temp */
select track_name, tempo,
 (case 
  when tempo > 121.80 then 'above average tempo'
  when  tempo =121.80 then 'average tempo'
  when tempo=121.80 then 'below average tempo'
  end) as tempo_average
  
 from  spotify 
 
 
 /* classify energy */
 
 select track_name,energy ,
 (case 
    when energy between 0.1 and 0.3 then 'calm musics'
    when energy between 0.3 and 0.6 then 'moderate musics'
    else 'energetics musics'
   end
    ) as energyAverage
   
  from spotify  limit 10
 
 
 
 
  



