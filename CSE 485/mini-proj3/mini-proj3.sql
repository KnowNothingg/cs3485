// 1. 
Base query: 
select f.title, c.city, count(*)
from film f, store s, address a, city c, inventory i, rental r
where s.store_id = i.store_id
    and i.film_id = f.film_id
    and s.address_id = a.address_id
    and a.city_id = c.city_id
    and r.inventory_id = i.inventory_id
group by 1, 2
order by 1, 2;


select first.film_title, coalesce("Woodridge", 0) as "Woodridge",
                coalesce("Lethbridge", 0) as "Lethbridge"
from crosstab('
select f.title, c.city, count(*)
from film f, store s, address a, city c, inventory i, rental r
where s.store_id = i.store_id
    and i.film_id = f.film_id
    and s.address_id = a.address_id
    and a.city_id = c.city_id
    and r.inventory_id = i.inventory_id
group by 1, 2
order by 1, 2', 
'select c.city
from city c, address a, store s
where s.address_id = a.address_id 
    and a.city_id = c.city_id
group by c.city
order by c.city')
as first(film_title text, "Woodridge" integer, "Lethbridge" integer);


2. 
select c.email, f.rating, count(*)
from customer c, rental r, inventory i, film f
where c.customer_id = r.customer_id 
    and r.inventory_id = i.inventory_id
    and i.film_id = f.film_id
group by 1, 2
order by 1, 2;

select second.customer_email, coalesce("PG-13", 0) as "PG-13", coalesce("R", 0) as "R", 
    coalesce("PG", 0) as "PG", coalesce("G", 0) as "G", coalesce("NC-17", 0) as "NC-17"
from crosstab('
select c.email, f.rating, count(*)
from customer c, rental r, inventory i, film f
where c.customer_id = r.customer_id 
    and r.inventory_id = i.inventory_id
    and i.film_id = f.film_id
group by 1, 2
order by 1, 2',
'select rating from film
group by rating
order by rating')
as second(customer_email text, "PG-13" integer, 
"R" integer, "PG" integer, "G" integer, "NC-17" integer);

3. 
select f.title, EXTRACT(MONTH FROM p.payment_date), count(*)
from film f, rental r, payment p, inventory i
where f.film_id = i.inventory_id
    and r.inventory_id = i.inventory_id
    and r.rental_id = p.rental_id
group by 1, 2
order by 1, 2;

select third.film_title, coalesce("Jan", 0) as "Jan", coalesce("Feb", 0) as "Feb", coalesce("Mar", 0) as "Mar", 
coalesce("Apr", 0) as "Apr", coalesce("May", 0) as "May", coalesce("Jun", 0) as "Jun", coalesce("Jul", 0) as "Jul",
coalesce("Aug", 0) as "Aug", coalesce("Sep", 0) as "Sep", coalesce("Oct", 0) as "Oct", coalesce("Nov", 0) as "Nov", 
coalesce("Dec", 0) as "Dec"
from crosstab('
select f.title, EXTRACT(MONTH FROM p.payment_date), count(*)
from film f, rental r, payment p, inventory i
where f.film_id = i.inventory_id
    and r.inventory_id = i.inventory_id
    and r.rental_id = p.rental_id
group by 1, 2
order by 1, 2', 
'values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11),(12)'   
)
as third(film_title text, "Jan" integer, "Feb" integer, "Mar" integer, "Apr" integer, "May" integer,
    "Jun" integer, "Jul" integer, "Aug" integer, "Sep" integer, "Oct" integer, "Nov" integer, "Dec" integer);


4. 
select (a.first_name || ' ' || a.last_name) as fullname, c.name as cate, count(*)
from category c, actor a, film_actor fa, film_category fc, film f
where f.film_id = fc.film_id and fc.category_id = c.category_id
    and f.film_id = fa.film_id and fa.actor_id = a.actor_id
group by a.first_name, a.last_name, c.name
order by a.last_name, a.first_name, c.name; 


select fourth.fullname, coalesce("Action", 0) as "Action", coalesce("Animation", 0) as "Animation", coalesce("Children", 0) as "Children", 
    coalesce("Classics", 0) as "Classics", coalesce("Comedy", 0) as "Comedy", coalesce("Documentary", 0) as "Documentary", 
    coalesce("Drama", 0) as "Drama", coalesce("Family", 0) as "Family", coalesce("Foreign", 0) as "Foreign", coalesce("Games", 0) as "Games", 
    coalesce("Horror", 0) as "Horror", coalesce("Music", 0) as "Music", coalesce("New", 0) as "New", coalesce("Sports", 0) as "Sports", 
    coalesce("Travel", 0) as "Travel"
from crosstab('select a.first_name || '' '' || a.last_name as fullname, c.name as category, count(*)
from category c, actor a, film_actor fa, film_category fc, film f
where f.film_id = fc.film_id and fc.category_id = c.category_id
    and f.film_id = fa.film_id and fa.actor_id = a.actor_id
group by a.first_name, a.last_name, c.name
order by a.last_name, a.first_name, c.name', 
'select name from category
order by name')
as fourth(fullname text, "Action" integer, "Animation" integer, "Children" integer, 
        "Classics" integer, "Comedy" integer, "Documentary" integer, "Drama" integer,
        "Family" integer, "Foreign" integer, "Games" integer, "Horror" integer, 
        "Music" integer, "New" integer, "Sci-Fi" integer, "Sports" integer, "Travel" integer);


