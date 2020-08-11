create database if not exists yad2

CREATE TABLE if not exists orders (
   order_id   NUMERIC      NOT NULL AUTO_INCREMENT,
   title    VARCHAR(255) NOT NULL
);

use yad2;

insert into orders (title) values "first order"
insert into orders (title) values "second order"
upate orders set title="first order changed" where title="first order"
insert into orders (title) values "third order"
delete from orders where order_id=2
insert into orders (title) values "order 4"