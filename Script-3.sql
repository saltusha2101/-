
select c.customer_id, c.first_name, c.last_name from customer c 

select c.customer_id, c.first_name, c.last_name from customer c 
where c.first_name ilike 'Carolyn'

select  c.first_name, c.last_name from customer c 
where c.first_name ilike '%ary%' or c.last_name ilike '%ary%'

select p.payment_id  from payment p
order by p.payment_id desc
limit 20

select a.address_id, a.address FROM address a

select p.payment_id, extract (day from p.payment_date) as "Число", 
extract (month from p.payment_date) as "Месяц", 
extract (dow from p.payment_date) as "День недели"
from payment p

SELECT r.customer_id , r.staff_id,  CAST(r.rental_date AS date ) FROM rental r 
WHERE rental_date >= '2005-06-01'::DATE 
AND rental_date < '2005-07-01'::DATE;


select f.title, f.description, f.length, f.release_year from film f 
where f.release_year > 2000 AND f.length BETWEEN 60 AND 120
order by f.length  desc
limit 20

select p.payment_id, p.amount, date (p.payment_date)   
from payment p
WHERE p.payment_date  BETWEEN '2007-04-01' AND '2007-04-30'  
and p.amount <= 4 
order by p.amount  desc,
p.payment_date asc

select c.customer_id as "Идентификатор", c.first_name as "Имя", c.last_name as "Фамилия" from customer c 
where c.first_name IN ('Jack', 'Bob', 'Sara')
and c.last_name ilike '%p%'







