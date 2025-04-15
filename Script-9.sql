-- 1oe задание
select
    p.payment_id,
    p.amount  AS Сумма,
    TO_CHAR(p.payment_date, 'DD.MM.YYYY') AS Дата,
    TO_CHAR(p.payment_date, 'Day') AS "День недели"
FROM payment p;

-- 2е задание
select 
case 
when f.length < 70
then 'Короткие'
when f.length >= 70 and  f.length < 130
then 'Средние'
else 'Длинные'  
end, 
count(f.film_id),
count(r.rental_id)
from film f
left join inventory i using (film_id)
left join rental r  using (inventory_id)
group by 1

-- 3е задание с create table у меня почему то не срабатывало 

create table weekly_revenue as
select
extract(year from rental_date) as r_year,
extract(week from rental_date) as r_week,
sum(amount) as revenue
from rental r
left join payment p on p.rental_id = r.rental_id
group by 1, 2
order by 1, 2



WITH weekly_revenue AS (
    SELECT
        EXTRACT(YEAR FROM r.rental_date) AS r_year,
        EXTRACT(WEEK FROM r.rental_date) AS r_week,
        SUM(p.amount) AS revenue
    FROM
        rental r
    LEFT JOIN
        payment p ON p.rental_id = r.rental_id
    WHERE
        p.amount IS NOT NULL 
    GROUP BY
        1, 2
)
SELECT
    r_year,
    r_week,
    revenue,
    ROUND(
        SUM(revenue) OVER (ORDER BY r_year, r_week ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
    ) AS cumulative_revenue
FROM
    weekly_revenue
ORDER BY
    r_year,
    r_week;
-- 4ое задание 

WITH weekly_revenue AS (
    SELECT
        EXTRACT(YEAR FROM r.rental_date) AS r_year,
        EXTRACT(WEEK FROM r.rental_date) AS r_week,
        SUM(p.amount) AS revenue
    FROM
        rental r
    LEFT JOIN
        payment p ON p.rental_id = r.rental_id
    WHERE
        p.amount IS NOT NULL 
    GROUP BY
        1, 2
)
SELECT
    r_year,
    r_week,
    revenue,
    ROUND(
        SUM(revenue) OVER (ORDER BY r_year, r_week ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
    ) AS cumulative_revenue,
    ROUND(
        AVG(revenue) OVER (ORDER BY r_year, r_week ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
    ) AS moving_average_revenue
FROM
    weekly_revenue
ORDER BY
    r_year,
    r_week;

-- 5ое задание
WITH weekly_revenue AS (
    SELECT
        EXTRACT(YEAR FROM r.rental_date) AS r_year,
        EXTRACT(WEEK FROM r.rental_date) AS r_week,
        SUM(p.amount) AS revenue
    FROM
        rental r
    LEFT JOIN
        payment p ON p.rental_id = r.rental_id
    WHERE
        p.amount IS NOT NULL 
    GROUP BY
        1, 2)
SELECT
    r_year,
    r_week,
    revenue,
ROUND(
 SUM(revenue) OVER (ORDER BY r_year, r_week ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
    ) AS cumulative_revenue,
ROUND(
 AVG(revenue) OVER (ORDER BY r_year, r_week ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
    ) AS moving_average_revenue,
ROUND (
( revenue
-
LAG(revenue, 1) OVER (
ORDER BY  r_year, r_week
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
) * 100.00
/
LAG(revenue, 1) OVER (
ORDER BY r_year, r_week
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
, 2) AS pct_growth
FROM weekly_revenue

