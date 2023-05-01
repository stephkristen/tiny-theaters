use tiny_theaters;

-- QUERIES

-- Find all performances in the last quarter of 2021 (Oct. 1, 2021 - Dec. 31 2021).

select * from performance
where date between '2021-10-01' and '2021-12-31';

-- List customers without duplication.

select * from customer;

-- Find all customers without a .com email address.

select * from customer
where email not like '%.com';

-- Find the three cheapest shows.

select name, date, ticket_price from performance
order by ticket_price
limit 3;

-- List customers and the show they're attending with no duplication.

select distinct p.name, p.date, c.first_name from ticket t
inner join performance p on t.performance_id = p.performance_id
inner join customer c on t.customer_id = c.customer_id;


-- List customer, show, theater, and seat number in one query.

select c.first_name, p.name, th.name, t.seat_name
from ticket t
inner join performance p on t.performance_id = p.performance_id
inner join theater th on p.theater_id = th.theater_id
inner join customer c on t.customer_id = c.customer_id;

-- Find customers without an address.

select * from customer
where address like '';

-- Recreate the spreadsheet data with a single query.

select c.first_name, c.last_name, c.email, c.phone, c.address, t.seat_name, p.name, p.ticket_price, p.date, th.name, th.address, th.phone, th.email 
from ticket t
inner join performance p on t.performance_id = p.performance_id
inner join theater th on p.theater_id = th.theater_id
inner join customer c on t.customer_id = c.customer_id;

-- Count total tickets purchased per customer.

select c.first_name, count(t.ticket_id)
from ticket t
inner join customer c on t.customer_id = c.customer_id
group by c.first_name;

-- Calculate the total revenue per show based on tickets sold.

select name, sum(ticket_price)
from performance
group by name;

-- Calculate the total revenue per theater based on tickets sold.

select th.name, sum(p.ticket_price)
from performance p
left outer join theater th on p.theater_id = th.theater_id
group by th.name;

-- Who is the biggest supporter of RCTTC? Who spent the most in 2021?

select c.first_name
from ticket t
where customer_id = ();

select c.first_name, count(t.ticket_id) ticket_count
from ticket t
inner join customer c on t.customer_id = c.customer_id
order by ticket_count;