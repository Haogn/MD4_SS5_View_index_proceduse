CREATE DATABASE ss5_bt2;
use ss5_bt2;
create table customer
(
    customer_id   int auto_increment
        primary key,
    customer_name varchar(25) null,
    customer_age  int         null
);

create table order_shop
(
    order_id    int auto_increment
        primary key,
    customer_id int                          null,
    order_date  datetime default (curdate()) null,
    order_total int                          null
);

create table products
(
    product_id    int auto_increment
        primary key,
    product_name  varchar(25) null,
    product_price int         null
);

create table order_detail
(
    od_id       int null,
    product_id  int null,
    od_quantity int null,
    constraint fk_order_detail
        foreign key (od_id) references order_shop (order_id),
    constraint fk_product_detail
        foreign key (product_id) references products (product_id)
);

INSERT INTO customer(customer_name, customer_age)
values ('Minh Quan', 10),
       ('Ngoc Oanh', 20),
       ('Hong Ha', 30);

INSERT INTO order_shop (customer_id, order_date, order_total)
values (1, '2022/02/02', NULL),
       (2, '2022/03/03', NULL),
       (1, '2022-04-04', NULL);

INSERT INTO products (product_name, product_price)
values ('May Giat', 3),
       ('Tu Lanh', 5),
       ('Dieu Hoa', 7),
       ('Quat', 1),
       ('Bep Dien', 2);


INSERT INTO order_detail(od_id, product_id, od_quantity)
values (1, 1, 3),
       (1, 3, 7),
       (1, 4, 2),
       (2, 1, 1),
       (3, 1, 8),
       (2, 5, 4),
       (2, 3, 3);

--
SELECT *
from order_shop
order by order_date desc;

--
SELECT product_name, od_quantity
from products
         join order_detail od_d ON products.product_id = od_d.product_id
order by od_quantity desc
limit 1;

-- sub query
SELECT  MAX(od_quantity) as od_quantity  FROM
(SELECT od_quantity from order_detail join products p ON p.product_id = order_detail.product_id) as m ;

-- hien thi ten khach hang va ten san pham da mua
SELECT customer_name , product_name
from order_detail od
join order_shop os ON od.od_id = os.order_id
join customer c on os.customer_id = c.customer_id
join products p on od.product_id = p.product_id;

-- hien thi ten khach hang khong mua bat ky san pham nao
SELECT customer_name from customer
left join order_shop os on customer.customer_id = os.customer_id
where os.customer_id is null ;

--
SELECT order_id , order_date, od_quantity, product_name,product_price
from order_detail
join order_shop os on order_detail.od_id = os.order_id
join products p on order_detail.product_id = p.product_id;


--
SELECT order_id , order_date , SUM(od_quantity*product_price) as total_order from order_detail
join order_shop os on order_detail.od_id = os.order_id
join products p on order_detail.product_id = p.product_id
group by order_id;