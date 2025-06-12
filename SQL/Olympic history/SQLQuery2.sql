

--1.Which Team has won the maximum gold medals over the year.
select top 1 team,COUNT(distinct(event)) as cnt
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
group by  team
order by cnt desc;

/*--1 row
team	cnt
United States	626*/

--2.for each team print total silver medals and year in which they won maximum silver medal 
with cte as (
select a.team,ae.year , count(distinct event) as silver_medals
,rank() over(partition by team order by count(distinct event) desc) as rn
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where medal='Silver'
group by a.team,ae.year)
select team,sum(silver_medals) as total_silver_medals, max(case when rn=1 then year end) as  year_of_max_silver
from cte
group by team;
--300 rows

--3.Which player has won the maximum gold medals amongst players
--which have won only gold medal (never won silver or bronze) over the years
with cte as (
select name,medal
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id)
select top 1 name , count(1) as no_of_gold_medals
from cte 
where name not in (select distinct name from cte where medal in ('Silver','Bronze'))
and medal='Gold'
group by name
order by no_of_gold_medals desc

-- 1.row


--4.in each year which player has won maximum gold medal. Write a query to print year ,player name
-- no of golds won in that year . Incase of a tie print comma seperated player names.

with cte as (
select ae.year,a.name,count(1) as no_of_gold
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where medal='Gold'
group by ae.year,a.name)
select year,no_of_gold,STRING_AGG(name,',') as players from (
select *,
rank() over(partition by year order by no_of_gold desc) as rn
from cte) a where rn=1
group by year,no_of_gold
;
--35 rows

--5.In which event and year india has won its first gold medal, first silver medal and first bronze medal
--print 3 columns medal,year,sport
select distinct * from(
select medal,year,event,rank() over(partition by medal order by year) rn
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where team='India' and medal !='NA'
) A
where rn=1

--4 rows

--6.find players who won gold medal in summer and winter olympics both
select a.name
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where medal='Gold'
group by a.name having count(distinct season)=2
--4 rows

--7.find players who won gold silver and bronze medal in a single olympics.print player name along with year
select year,name
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where medal!='NA'
group by year,name having count(distinct medal)=3;
--182 rows

--8.find players who have won gold medals in consecutive 3 summer olympics in the same event. Consider only olympics 2000 onwords
--Assume summer olympics happens every 4 year starting 2000. Print player name and event name

with cte as (
select name,year,event
from athlete_events ae
inner join athletes a on ae.athlete_id=a.id
where year >=2000 and season='Summer'and medal = 'Gold'
group by name,year,event)
select * from
(select *, lag(year,1) over(partition by name,event order by year ) as prev_year
, lead(year,1) over(partition by name,event order by year ) as next_year
from cte) A
where year=prev_year+4 and year=next_year-4

--62 rows
