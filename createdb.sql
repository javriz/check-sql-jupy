-- Active: 1706330407016@@127.0.0.1@3306@baby_names
use baby_names;
select * from usa_baby_names;
select year from  usa_baby_names;

### -- Select first names and the total babies with that first_name
-- Group by first_name and filter for those names that appear in all 101 years
-- Order by the total number of babies with that first_name, descending 
select first_name , sum(num)
from usa_baby_names
group by first_name
having count(DISTINCT year)=101
order by sum(num) desc

### -- Classify first names as 'Classic', 'Semi-classic', 'Semi-trendy', or 'Trendy'
-- Alias this column as popularity_type
-- Select first_name, the sum of babies who have ever had that name, and popularity_type
-- Order the results alphabetically by first_name

select first_name,sum(num) as sum ,CASE 
        WHEN sum(num) > 0 and sum(num) < 20 then 'Classic'
        WHEN sum(num) > 20 and sum(num) < 50 then 'Semi-Classic'
        when sum(num) > 50 and sum(num) < 80 then 'Semi-trendy'
        ELSE 'Trendy' end  as popularity_type
from usa_baby_names
group by first_name
order by first_name;

### -- RANK names by the sum of babies who have ever had that name (descending), aliasing as name_rank
-- Select name_rank, first_name, and the sum of babies who have ever had that name
-- Filter the data for results where sex equals 'F'
-- Limit to ten results

select RANK() OVER (ORDER BY SUM(num) DESC) AS name_rank,first_name,sum(num) as sum
from usa_baby_names
where sex ='F'
group by first_name
order by sum(num) desc
limit 10

### -- Select only the first_name column
-- Filter for results where sex is 'F', year is greater than 2015, and first_name ends in 'a'
-- Group by first_name and order by the total number of babies given that first_name

select first_name
from usa_baby_names
where sex = 'F' and year > 2015 and first_name like '%a'
group by first_name
order by sum(num) desc

### -- Select year, first_name, num of Olivias in that year, and cumulative_olivias
-- Sum the cumulative babies who have been named Olivia up to that year; alias as cumulative_olivias
-- Filter so that only data for the name Olivia is returned.
-- Order by year from the earliest year to most recent


Select year,first_name, sum(num) as num ,
 SUM(SUM(num)) OVER (ORDER BY year asc) AS cumulative_olivias
    from usa_baby_names
    where first_name = 'Olivia'
    group by year, first_name
    order by year asc


### -- Select year and maximum number of babies given any one male name in that year, aliased as max_num
-- Filter the data to include only results where sex equals 'M'

select year, max(num) as max_num
from usa_baby_names
where sex = 'M'
group by year

### -- Select year, first_name given to the largest number of male babies, and num of babies given that name
-- Join baby_names to the code in the last task as a subquery
-- Order results by year descending

SELECT 
    year,
    (
        SELECT 
            first_name
        FROM 
            usa_baby_names AS inner_names
        WHERE 
            inner_names.sex = 'M' AND
            inner_names.year = outer_names.year
        ORDER BY 
            num DESC
        LIMIT 1
    ) AS first_name,
    MAX(num) AS num
FROM 
    usa_baby_names AS outer_names
GROUP BY 
    year
ORDER BY 
    year DESC;