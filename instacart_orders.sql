DROP DATABASE instacart_orders;
CREATE DATABASE IF NOT EXISTS `instacart_orders`;
USE `instacart_orders`;

CREATE TABLE IF NOT EXISTS `instacart_orders`.`aisles` (
	`aisle_id` INT NOT NULL,
	`aisle` VARCHAR(255) NOT NULL);
    
CREATE TABLE IF NOT EXISTS 	`instacart_orders`.`departments` (
	`department_id` INT NOT NULL,
    `department` VARCHAR(255) NOT NULL,
    `aisle_id` INT NOT NULL DEFAULT '0');
    
CREATE TABLE IF NOT EXISTS `instacart_orders`.`products` (
	`product_id` INT NOT NULL,
    `product_name` VARCHAR(255) NOT NULL,
    `aisle_id` INT NOT NULL DEFAULT '0',
    `department_id` INT NOT NULL);
    
CREATE TABLE IF NOT EXISTS `instacart_orders`.`customers` (
    `user_id` INT NOT NULL,
    `email_address` VARCHAR(255) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `phone_number` CHAR(14) NOT NULL);
    
CREATE TABLE IF NOT EXISTS `instacart_orders`.`orders` (
	`order_number` INT NOT NULL,
    `order_hour_of_day` INT NOT NULL,
    `days_since_prior_order` INT NOT NULL,
    `order_day_of_week` INT NOT NULL,
    `user_id` INT NOT NULL);

CREATE TABLE IF NOT EXISTS `instacart_orders`.`order_products` (
	`order_id` INT NOT NULL,
    `quantity` INT NOT NULL,
    `quantity_reordered` INT NOT NULL,
	`order_number` INT NOT NULL, 
    `product_id` INT NOT NULL);
    
CREATE TABLE IF NOT EXISTS `instacart_orders`.`addresses` (
	`zip_code` INT NOT NULL,
    `city` VARCHAR(255) NOT NULL,
    `user_id` INT NOT NULL);
    
-- -------------------------------------------------------------------------    
-- 							TABLE ALTERATIONS
-- -------------------------------------------------------------------------    

ALTER TABLE aisles ADD PRIMARY KEY (aisle_id);

ALTER TABLE departments ADD PRIMARY KEY (department_id);
ALTER TABLE departments ADD FOREIGN KEY (aisle_id) REFERENCES aisles(aisle_id);

ALTER TABLE products ADD PRIMARY KEY (product_id);
ALTER TABLE products ADD FOREIGN KEY (aisle_id) REFERENCES aisles(aisle_id);
ALTER TABLE products ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

ALTER TABLE customers ADD PRIMARY KEY (user_id), MODIFY user_id INT AUTO_INCREMENT;

ALTER TABLE orders ADD PRIMARY KEY (order_number);
ALTER TABLE orders ADD FOREIGN KEY (user_id) REFERENCES customers(user_id);

ALTER TABLE order_products ADD PRIMARY KEY (order_id);
ALTER TABLE order_products ADD FOREIGN KEY (order_number) REFERENCES orders(order_number);
ALTER TABLE order_products ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE addresses ADD PRIMARY KEY (city);
ALTER TABLE addresses ADD FOREIGN KEY (user_id) REFERENCES customers(user_id);

-- -------------------------------------------------------------------------    
-- 							TABLE INSERTS
-- ------------------------------------------------------------------------- 

USE instacart_orders;
INSERT INTO customers (user_id, email_address, first_name, last_name, phone_number)
VALUES
('1', 'suspendisse.aliquet.sem@outlook.org', 'Cynthia', 'Alston', '(122) 861-1777'),
('2', 'sed.neque.sed@yahoo.org', 'Carla', 'Mcintyre', '(204) 586-1772'),
('3', 'morbi@aol.edu', 'Martin', 'Weeks', '(945) 781-8341'),
('4', 'nam@google.ca', 'Leo', 'Morton', '(845) 454-1682'),
('5', 'ligula@yahoo.com', 'TaShya', 'Mcconnell', '(486) 912-1572');

INSERT INTO addresses (user_id, city, zip_code) 
VALUES
('1', 'Seattle', '61369'),
('2', 'Wichita', '13037'),
('3', 'Grand Rapids', '77179'),
('4', 'Springdale', '79068'),
('5', 'Aurora', '53606');

INSERT INTO aisles (aisle_id, aisle)
VALUES
('1', 'prepared soups salads'),
('2', 'specialty cheeses'),
('3', 'energy granola bars'),
('4', 'instant foods'),
('5', 'marinades meat preparation'),
('6', 'other'),
('7', 'packaged meat'),
('8', 'bakery desserts'),
('9', 'pasta sauce'),
('10', 'kitchen supplies');

INSERT INTO departments (department_id, department, aisle_id)
VALUES
('9', 'dry goods pasta', '6'),
('13', 'pantry', '4'),
('16', 'dairy eggs', '6'),
('19', 'snacks', '3'),
('20', 'deli', '5');

INSERT INTO products (product_id, product_name, department_id, aisle_id)
VALUES
('209', 'Italian Pasta Salad', '9', '1'),
('11307', 'Goat Cheese Logs', '16', '2'),
('6683', 'Raspberry Energy Shot', '19', '3'),
('18966', 'Hot & Spicy with Shrimp', '20', '4'),
('1840', 'Cheesy Taco Seasoning Mix', '13', '5');

INSERT INTO orders (order_number, order_day_of_week, order_hour_of_day, days_since_prior_order, user_id)
VALUES
('1', '2', '8', '0', 1),
('2', '2', '11', '10', 1),
('3', '3', '19', '9', 2),
('4', '4', '15', '21', 3),
('5', '0', '16', '11', 5);

INSERT INTO order_products (order_id, quantity, quantity_reordered, order_number, product_id)
VALUES
('2539329', '1', '1', 1, '209'),
('2398795', '2', '1', 2, '1840'),
('473747', '3', '0', 3, '6683'),
('2254736', '4', '1', 4, '11307'),
('431534', '5', '0', 5, '18966');

-- -------------------------------------------------------------------------    
-- 							SELECT STATEMENTS
-- ------------------------------------------------------------------------- 

SELECT * FROM customers;
SELECT * FROM addresses;
SELECT * FROM aisles;
SELECT * FROM departments;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_products;