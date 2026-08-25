create table books(
book_id SERIAL PRIMARY KEY,
title VARCHAR(100),
author VARCHAR(100),
genre VARCHAR (50),
published_year INT,
price NUMERIC(10,2),
stock INT
);

select * from books;


create table customer(
customer_id serial primary key,
name varchar (100),
email varchar(100),
phone varchar (15),
city varchar (50),
country varchar(150)
);
 select * from customer


create table orders(
order_id serial primary key,
customer_id int references customer(customer_id),
Book_Id int references books(book_id),
order_date date,
quentity int,
total_amount numeric(10,2)
);

   DROP table  orders;
select * from orders;

 --1) retrieve all books in the "fiction" genre.

SELECT * FROM books
WHERE genre='Fiction';

--2) find books published after the year 1950;
select * from books
where published_year>1950

--3) list all customer from the canada:
select * from customer
where country='Canada'
--4) show orders placed in november 2023;

select * from orders
where order_date between '2023-11-01'AND '2023-11-30';

--5) retrieve the total stock of books available:
select sum(stock)as total_stock
from books;

--6) find the details of the most expensive book;
select * from books
order by price DESC
limit 1;

--7) show all customers who ordered more than 1 quenity of a book :

select * from orders
where quentity<1

--8)retrieve all orders where the total amount exceeds $20:

select * from orders
where total_amount >20

--9) list all genres available in the books table:
select distinct genre from books;

--10) find the book with the lowest stock:
select * from books
order by stock limit 1
--11) calculate the total revenue generated from all orders:
select sum(total_amount)
from orders

--12) retrieve the total number of books sold for each genre:
select * from orders

select b.genre,sum(o.quentity) as total_book_sold
from orders o 
join books b on o.book_id=b.book_id
group by b.genre;

--13) find the average price of books in the "Fantasy" genre:
select avg(price)
from books
where genre = 'Fantasy';

--14) list customers who have placed at least 2 orders:

select customer_id,count(order_id) as order_count
from orders 
group by customer_id 
having count(order_id)>2 


--15) find the most frequently ordered book:

select book_id , count (order_id)
from orders 
group by book_id
order by order_count DESC limit 1;

--16) show the top 3 most expensive books of 'fantasy' genre:

select* from books
where genre = 'Fantasy'
order by price DESC
limit 3;





