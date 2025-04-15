

WITH film_categories AS 
(select f.length,
case 
when f.length < 70
then 'Короткие'
when f.length >= 70 and  f.length < 130
then 'Средние'
else 'Длинные'  end 
from film f
group by 1),
films_with_rentals AS (
select fc.category_id , i.inventory_id, r.rental_id 
    from film_category fc
    join inventory i  on  i.film_id = fc.film_id 
    join rental r on i.inventory_id = r.inventory_id
)
select
    fc.category_id,
    COUNT(DISTINCT fc.film_id) AS film_count,
    count(r.rental_id) AS rental_count
from film_category fc
   join inventory i  on  i.film_id = fc.film_id 
   join rental r on i.inventory_id = r.inventory_id
group by
    fc.category_id


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