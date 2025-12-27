-- E-COMMERCE SQL PROJECT
-- Created by bhavesh pawar

CREATE DATABASE ecommerce_db;
USE ecommerce_db;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Details Table
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Customers
INSERT INTO customers (name, email, city, signup_date) VALUES
('Amit', 'amit@gmail.com', 'Pune', '2024-01-10'),
('Neha', 'neha@gmail.com', 'Mumbai', '2024-02-05'),
('Raj', 'raj@gmail.com', 'Nashik', '2024-03-12');

-- Insert Products
INSERT INTO products (product_name, category, price, stock) VALUES
('Laptop', 'Electronics', 55000, 10),
('Mobile', 'Electronics', 20000, 25),
('Headphones', 'Accessories', 2000, 50);

-- Insert Orders
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-06-01', 57000),
(2, '2024-06-02', 20000);

-- Insert Order Details
INSERT INTO order_details (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 55000),
(1, 3, 1, 2000),
(2, 2, 1, 20000);

-- ANALYSIS QUERIES


-- All Orders with Customer Names
SELECT o.order_id, c.name, o.order_date, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Total Sales
SELECT SUM(total_amount) AS total_sales FROM orders;

-- Top Selling Products
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- City-wise Sales
SELECT c.city, SUM(o.total_amount) AS city_sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city;