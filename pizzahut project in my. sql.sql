create database pizzahut;

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key (order_id));

select * from pizzahut.orders


select * from pizzahut.pizza_types;

select* from pizzahut.pizzas;

create table order_details1(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id));

select*from pizzahut.order_details1;


-- retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- calculate the total revenue generated from pizza saless.

SELECT 
    SUM(order_details1.quantity * pizzas.price) AS total_sales
FROM
    order_details1
        JOIN
    pizzas ON pizzas.pizza_id = order_details1.pizza_id

-- identity the highest- priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- identity the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(order_details1.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details1 ON pizzas.pizza_id = order_details1.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;


-- list the top 5 most ordered pizza 
-- along with thrir quantities.

SELECT 
    pizza_types.name, SUM(order_details1.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details1 ON order_details1.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

-- determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time), COUNT(order_id)
FROM
    orders
GROUP BY HOUR(order_time);

-- join relevent tables to find the category_wise distribution of pizzas.

select category,count(name) from pizza_types
group by category;

-- group the orders by date and calulate the average
-- number of pizzas ordered per day.
select avg(quantity) from order_details1
(select orders.order_date, sum(order_details1.quantity)
from orders join order_details1
on orders.order_id=order_details1.order_id
group by orders.order_date)

-- determine the top 3 most orderd pizza types based on revenue.
select pizza_types.name,sum(order_details1.quantity*pizzas.price) as total revenue
from pizza_types
join pizzas on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details
on order_details1.pizza_id=pizzas.pizza_id;
group by pizza_types.name order by revenue desc limit 3;

-- analyze the cumulative revenue generated over time.
select orders.order_date,sum(order_details1.quantity* pizzas.price)as revenue
from order_details1 join pizzas
on order_details1.pizza_id=pizzas.pizza_id
join orders
on orders.order_id=order_details1.order_id
group by orders.order_date;

-- determine the top 3 most ordered pizza types
-- based on revenue for each pizza category.

select pizza_types.category,pizza_types.name,
sum(order_details1.quantity)*pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details1
on order_details.pizza_id= pizza_id
group by pizza_types. category,pizza_types. name;











