drop database if exists tiny_theaters;
create database tiny_theaters;

select * from tiny_theaters.all_tiny_theaters;
use tiny_theaters;

desc all_tiny_theaters;

select * from all_tiny_theaters;

create table theater (
	theater_id int primary key auto_increment,
    name varchar(255) not null,
    address varchar(255) not null,
    phone varchar(25) not null,
    email varchar(255)
);

create table performance (
	performance_id int primary key auto_increment,
    name varchar(255) not null,
    date date not null,
    ticket_price decimal(5,2) not null,
    theater_id int not null,
    constraint fk_performance_theater_id
		foreign key (theater_id)
        references theater (theater_id)
);

create table customer (
	customer_id int primary key auto_increment,
    first_name varchar(255) not null,
    last_name varchar(255) not null,
    email varchar(255) not null,
    phone varchar(25) null,
    address varchar(255) null
);

create table ticket (
	ticket_id int primary key auto_increment,
    seat_name varchar(4),
    performance_id int not null,
    customer_id int not null,
    constraint fk_ticket_performance_id
		foreign key (performance_id)
        references performance (performance_id),
	constraint fk_ticket_customer_id
		foreign key (customer_id)
        references customer (customer_id)
);

