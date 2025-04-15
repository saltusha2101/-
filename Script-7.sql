select c.customer_id , c.first_name from  customer c 
group by c.customer_id 
order by 1

select  p.amount, Sum(p.amount), COUNT(*) from payment p 
group by p.amount 
order by 3 desc
limit 5

select i.store_id,COUNT(*)
from inventory i 
group by i.store_id

select a.address, a.address_id , s.store_id 
from address a   
join store s
using (address_id)

select s.first_name || '' || s.last_name as "Фамилия Имя"
from staff s
union 
select c.first_name || '' || c.last_name as "ФАмилия Имя"
from customer c 

select c.first_name 
from customer c 
except 
select s.first_name 
from staff s  

select c.customer_id, c.first_name || '' || c.last_name as "Фамилия Имя клиента" , 
       s.staff_id, s.first_name || '' || s.last_name as "Фамилия Имя сотрудниика",  
       CAST(r.rental_date AS date ) 
from rental r 
join staff s on s.staff_id = r.staff_id
join customer c on c.customer_id  = r.customer_id
where rental_date >= '2005-06-01'::DATE 
and rental_date < '2005-07-01'::DATE
order by 5

select  p.customer_id, count (*), 
        (select round (AVG(p.amount),2) from payment p)
from payment p 
group by p.customer_id
HAVING (p.customer_id) > 40

select a.actor_id, a.first_name || '' || a.last_name as "Фамилия Имя", 
         count (fa.film_id)
from actor a
join film_actor fa on a.actor_id  = fa.actor_id
group by a.actor_id
order by 3 desc


select   
       extract (month from r.rental_date) AS "Месяц",
       ROUND(SUM(p.amount), 1) AS "Выручка"
from 
       rental r
left join payment p on r.rental_id = p.rental_id
group by extract (month from r.rental_date) 
order by "Месяц";


select
    c.name AS Жанр,                             
    ROUND(AVG(p.amount), 2) AS Средний_платеж   
from  payment p
join rental  r ON p.rental_id = r.rental_id
join inventory  i ON r.inventory_id = i.inventory_id
join film_category  fc ON i.film_id = fc.film_id
join category c ON fc.category_id = c.category_id
group by c.name                                      
having COUNT(DISTINCT fc.film_id) > 60            
order by Средний_платеж DESC;                        



SELECT
    f.title AS "Название фильма"
from  rental  r
JOIN
    inventory  i ON r.inventory_id = i.inventory_id
JOIN
    film  f ON i.film_id = f.film_id
where EXTRACT(DOW FROM r.rental_date) = 6 
GROUP by  f.title
ORDER by COUNT(r.rental_id) DESC,
         f.title ASC             
LIMIT 5
