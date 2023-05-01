select * from tiny_theaters.all_tiny_theaters;

use tiny_theaters;
desc all_tiny_theaters;

select * from all_tiny_theaters;

-- INSERTS

insert into theater
	(`name`, `address`, `phone`, `email`)
select distinct `theater`, `theater_address`, `theater_phone`, `theater_email`
from all_tiny_theaters;

select * from theater;

insert into performance
	(`name`, `date`, `ticket_price`, `theater_id`)
select distinct a.`show`, a.`date`, a.`ticket_price`, t.`theater_id` 
from all_tiny_theaters a
inner join theater t on a.theater_email = t.email;

select * from performance;

insert into customer
	(`first_name`, `last_name`, `email`, `phone`, `address`)
select distinct `customer_first`, `customer_last`,`customer_email`, `customer_phone`, `customer_address`
from all_tiny_theaters;

select * from customer;

insert into ticket
	(`seat_name`, `performance_id`, `customer_id`)
select distinct a.`seat`, p.`performance_id`, c.`customer_id`
from all_tiny_theaters a
inner join customer c on a.customer_email = c.email
inner join performance p on a.show = p.name
	and a.date = p.date
order by customer_id;

select * from ticket;

drop table all_tiny_theaters;

-- UPDATES

-- The Little Fitz's 2021-03-01 performance of The Sky Lit Up is listed with a $20 ticket price. 
-- The actual price is $22.25 because of a visiting celebrity actor. (Customers were notified.) 
-- Update the ticket price for that performance only.

update performance 
set ticket_price = 22.25
where performance_id = (select performance_id 
from (select * from performance where name = 'The Sky Lit Up' and date = '2021-03-01') as temp);

select * from performance where name = 'The Sky Lit Up' and date = '2021-03-01';

-- In the Little Fitz's 2021-03-01 performance of The Sky Lit Up, Pooh Bedburrow and Cullen Guirau seat reservations aren't in the same row. 
-- Adjust seating so all groups are seated together in a row. This may require updates to all reservations for that performance. 
-- Confirm that no seat is double-booked and that everyone who has a ticket is as close to their original seat as possible.



-- Update Jammie Swindles's phone number from "801-514-8648" to "1-801-EAT-CAKE".

update customer
set phone = '1-801-EAT-CAKE'
where customer_id = (select customer_id
from (select * from customer where first_name = 'Jammie' and last_name = 'Swindles') as temp);

select * from customer where first_name = 'Jammie' and last_name = 'Swindles';

-- DELETES

-- Delete all single-ticket reservations at the 10 Pin. (You don't have to do it with one query.)

delete from ticket
where performance_id = (select performance_id
from (select * from performance where theater_id = (select theater_id
from (select * from theater where name = '10 Pin') as temp) as temp));

delete from performance
where theater_id = (select theater_id
from (select * from theater where name = '10 Pin') as temp);




-- Delete the customer Liv Egle of Germany. It appears their reservations were an elaborate joke.

set sql_safe_updates = 0;

delete from ticket
where customer_id = (select customer_id
from (select * from customer where first_name = 'Liv' and last_name = 'Egle of Germany') as temp);

delete from customer
where first_name = 'Liv' and last_name = 'Egle of Germany';

set sql_safe_updates = 1;

select * from customer
where first_name = 'Liv' and last_name = 'Egle of Germany';




    
    
    