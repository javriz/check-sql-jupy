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