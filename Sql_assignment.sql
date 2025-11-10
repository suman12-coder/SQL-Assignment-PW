-- ==========================================
-- SQL ASSIGNMENT (ECommerceDB)
-- Assignment Code: DA-AG-014
-- Introduction to SQL and Advanced Functions | Assignment | Practical
-- ==========================================

-- Practical Questions:

-- ==========================================
-- QUESTION 6:
-- Create a database named ECommerceDB and perform the following tasks:
-- (a) Create tables
-- (b) Insert records
-- ======================================

create database ECommerceDB;
use EcommerceDB;

# Create  Tables

create table Categories(
CategoryID int primary key,
CategoryName varchar(50) not null unique
);

Create table Products(
ProductID int primary key,
ProductName varchar(100) not null unique,
CategoryID int,
Price decimal(10,2) not null,
StockQuantity int,
foreign key (CategoryID) references Categories(CategoryID)
);

Create table Customers(
CustomerID int primary key,
CustomerName varchar(100) not null,
Email varchar(100) unique,
JoinDate date
);

Create table Orders(
OrderID int primary key,
CustomerID int,
OrderDAte date not null,
TotalAmount decimal(10,2)
);

-- Insert Data --

Insert into Categories values
(1,'Electronics'),
(2,'Books'),
(3,'Home Goods'),
(4, 'Apparel');

Insert into Products values
(101,'Laptop Pro',1,1200.00,50),
(102, 'SQL Handbook',2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 3, 75.00, 80),
(105, 'Novel : The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 3, 120.00, 60),
(108, 'T-Shirt Casual', 4, 20.00, 300);

Insert into Customers values
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');

Insert into  Orders values
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);


-- ==========================================
-- QUESTION 7:
-- Generate a report showing CustomerName, Email, and the TotalNumberOfOrders 
-- for each customer (including customers with 0 orders).
-- Order the results by CustomerName.
-- ==========================================

select c.CustomerName, c.Email, count(o.OrderID) as TotalNumberOfOrders
from Customers c left join  Orders o 
on c.CustomerID = o.CustomerID
group by c.CustomerID
order by c.CustomerName ;

-- ===========================================================================================
-- Question 8 :  Retrieve Product Information with Category: Write a SQL query to 
-- display the ProductName, Price, StockQuantity, and CategoryName for all 
-- products. Order the results by CategoryName and then ProductName alphabetically. 
-- ============================================================================================
select * from products;
select ProductName, Price, StockQuantity, ct.CategoryName from Products p join Categories ct
on p.CategoryID = ct.CategoryID
order by ct.CategoryName and productname;

-- ======================================================================================
-- Question 9 : Write a SQL query that uses a Common Table Expression (CTE) and a 
-- Window Function (specifically ROW_NUMBER() or RANK()) to display the 
-- CategoryName, ProductName, and Price for the top 2 most expensive products in 
-- each CategoryName. 
-- ==========================================================================================
with AggRank as (
select c.CategoryName, p.Productname, p.Price,
rank() over (partition by c.CategoryName order by p.price desc) as rnk
from Products p join Categories c
on p.categoryid = c.categoryid)
select CategoryName, ProductName, Price, rnk  from Aggrank
where rnk < 3;
-- ===============================================================================================

-- QUESTION 10:
-- Sakila Video Rentals Analysis
-- Database: sakila
-- ==========================================

USE sakila;

-- ==========================================
-- 10.1 Identify the top 5 customers based on the total amount they’ve spent.
-- Include customer name, email, and total amount spent.
-- ==========================================
select * from payment;
select * from customer;
select concat(c.first_name,' ',c.last_name) as CustomerName, c.Email, sum(p.Amount) as Total_Amt
from Customer c join payment p 
on c.customer_id = p.customer_id
group by c.customer_id
order by Total_Amt desc
limit 5;

-- ==========================================
-- 10.2 Which 3 movie categories have the highest rental counts?
-- Display the category name and number of times movies from that category were rented.
-- ====================================================
select c.name as Category_Name, count(r.rental_id) as RentalCount
from rental r 
join inventory i on r.inventory_id = i.inventory_id
join film_category f on i.film_id = f.film_id
join category c on c.category_id = f.category_id
group by c.name
order by RentalCount desc
limit 3;

-- ==========================================
-- 10.3 Calculate how many films are available at each store
-- and how many of those have never been rented.
-- ==========================================
SELECT s.store_id,
       COUNT(i.inventory_id) AS total_films,
       SUM(CASE WHEN r.rental_id IS NULL THEN 1 ELSE 0 END) AS never_rented
FROM store s
JOIN inventory i ON s.store_id = i.store_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY s.store_id;

-- ==========================================
-- 10.4 Show the total revenue per month for the year 2023
-- to analyze business seasonality.
-- ==========================================
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month,
       SUM(amount) AS total_revenue
FROM payment
WHERE YEAR(payment_date) = 2023
GROUP BY month
ORDER BY month;



-- ==========================================
-- 10.5 Identify customers who have rented more than 10 times in the last 6 months.
-- ==========================================

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS CustomerName,
    c.email,
    COUNT(r.rental_id) AS TotalRentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY c.customer_id
HAVING TotalRentals > 10
ORDER BY TotalRentals DESC;