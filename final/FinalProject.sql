/*

PM: Ben Kubin
	Mukendi Tshimanga
	Sara Hernandez
    
    For most of this assignment, we worked together as a team on each problem. 
    When working on the procedure and function, Sara contributed majorly to the procedure 
    and Mukendi did the same for the function. More divisions of work were made for the 
    LWTech Literacy Assignment.
    
*/

CREATE DATABASE `instacart_orders`;
USE instacart_orders;


CREATE TABLE `instacart_orders`.`aisles` (
    `aisle_id` INT NOT NULL,
    `aisle` VARCHAR(50) NOT NULL
);
    
CREATE TABLE `instacart_orders`.`departments` (
    `department_id` INT NOT NULL,
    `department` VARCHAR(50) NOT NULL,
    `aisle_id` INT NOT NULL DEFAULT '0'
);
    
CREATE TABLE `instacart_orders`.`products` (
    `product_id` INT NOT NULL,
    `product_name` VARCHAR(50) NOT NULL,
    `aisle_id` INT NOT NULL DEFAULT '0',
    `department_id` INT NOT NULL,
    `price` DECIMAL(9 , 2 ) NOT NULL
);
    
CREATE TABLE `instacart_orders`.`customers` (
    `user_id` INT NOT NULL,
    `email_address` VARCHAR(50) NOT NULL,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `phone_number` CHAR(14) NOT NULL
);
    
CREATE TABLE `instacart_orders`.`orders` (
    `order_number` INT NOT NULL,
    `order_hour_of_day` INT NOT NULL,
    `days_since_prior_order` INT NOT NULL,
    `order_day_of_week` INT NOT NULL,
    `user_id` INT NOT NULL
);

CREATE TABLE `instacart_orders`.`order_products` (
    `order_id` INT NOT NULL,
    `quantity` INT NOT NULL,
    `quantity_reordered` INT NOT NULL,
    `order_number` INT NOT NULL,
    `product_id` INT NOT NULL
);
    
CREATE TABLE `instacart_orders`.`addresses` (
    `zip_code` INT NOT NULL,
    `city` VARCHAR(50) NOT NULL,
    `user_id` INT NOT NULL
);
    
-- -------------------------------------------------------------------------    
-- 							TABLE ALTERATIONS
-- -------------------------------------------------------------------------    

ALTER TABLE aisles ADD CONSTRAINT aisles_aisle_id_pk PRIMARY KEY (aisle_id);


ALTER TABLE departments ADD CONSTRAINT departments_department_id_pk PRIMARY KEY (department_id);
ALTER TABLE departments ADD CONSTRAINT departments_aisle_id_fk FOREIGN KEY (aisle_id) REFERENCES aisles (aisle_id);


ALTER TABLE products ADD CONSTRAINT products_product_id_pk PRIMARY KEY (product_id);
ALTER TABLE products ADD CONSTRAINT products_aisle_id_fk FOREIGN KEY (aisle_id) REFERENCES aisles (aisle_id);
ALTER TABLE products ADD CONSTRAINT products_department_id_fk FOREIGN KEY (department_id) REFERENCES departments (department_id);


ALTER TABLE customers ADD CONSTRAINT customers_user_id_pk PRIMARY KEY (user_id), MODIFY user_id INT AUTO_INCREMENT;


ALTER TABLE orders ADD CONSTRAINT orders_order_number_pk PRIMARY KEY (order_number);
ALTER TABLE orders ADD CONSTRAINT customers_user_id_fk FOREIGN KEY (user_id) REFERENCES customers (user_id);


ALTER TABLE order_products ADD CONSTRAINT order_products_order_id_pk PRIMARY KEY (order_id);
ALTER TABLE order_products ADD CONSTRAINT orders_order_number_fk FOREIGN KEY (order_number) REFERENCES orders (order_number);
ALTER TABLE order_products ADD CONSTRAINT products_product_id_fk FOREIGN KEY (product_id) REFERENCES products (product_id);


ALTER TABLE addresses ADD CONSTRAINT addresses_city_pk PRIMARY KEY (city);
ALTER TABLE addresses ADD CONSTRAINT customers_addresses_user_id_fk FOREIGN KEY (user_id) REFERENCES customers (user_id);

-- -------------------------------------------------------------------------    
-- 							TABLE INSERTS
-- ------------------------------------------------------------------------- 

USE instacart_orders;
INSERT INTO customers (email_address, first_name, last_name, phone_number)
VALUES
('suspendisse.aliquet.sem@outlook.org', 'Cynthia', 'Alston', '(122) 861-1777'),
('sed.neque.sed@yahoo.org', 'Carla', 'Mcintyre', '(204) 586-1772'),
('morbi@aol.edu', 'Martin', 'Weeks', '(945) 781-8341'),
('nam@google.ca', 'Leo', 'Morton', '(845) 454-1682'),
('ligula@yahoo.com', 'TaShya', 'Mcconnell', '(486) 912-1572');

INSERT INTO addresses (user_id, city, zip_code) 
VALUES
('1', 'Seattle', '61369'),
('2', 'Wichita', '13037'),
('3', 'Grand Rapids', '77179'),
('4', 'Springdale', '79068'),
('5', 'Aurora', '53606');
SELECT 
    *
FROM
    addresses;
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

INSERT INTO products (product_id, product_name, department_id, aisle_id, price)
VALUES
('209', 'Italian Pasta Salad', '9', '1', '12.99'),
('11307', 'Goat Cheese Logs', '16', '2', '6.99'),
('6683', 'Raspberry Energy Shot', '19', '3', '3.99'),
('18966', 'Hot & Spicy with Shrimp', '20', '4', '15.99'),
('1840', 'Cheesy Taco Seasoning Mix', '13', '5', '4.99');

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
('2398795', '2', '2', 2, '1840'),
('473747', '3', '0', 3, '6683'),
('2254736', '4', '1', 4, '11307'),
('431534', '5', '2', 5, '18966');


-- -------------------------------------------------------------------------    
-- 							FINAL PROJECT
-- ------------------------------------------------------------------------- 

/*
- List right below this set of comments, the code for the Programming
Problem - Indexes
- Keep this set of comments in your team's submission
*/

CREATE INDEX idx_days_since_prior_order ON orders(days_since_prior_order);
CREATE INDEX idx_order_number ON orders(order_number);

CREATE INDEX idx_quantity_reordered ON order_products(quantity_reordered);
CREATE INDEX idx_quantity ON order_products(quantity);
CREATE INDEX idx_price ON products(price);
CREATE INDEX idx_product_id ON products(product_id);

/*
- List right below this set of comments, the code for the Programming
Problem - Multi-table Query
- Keep this set of comments in your team's submission
*/

SELECT 
    COUNT(p.product_id) AS product_count,
    op.quantity_reordered,
    c.user_id
FROM
    products p
        JOIN
    order_products op ON p.product_id = op.product_id
        JOIN
    orders o ON op.order_number = o.order_number
        JOIN
    customers c ON o.user_id = c.user_id
WHERE
    c.user_id = '1'
        AND op.quantity_reordered > 0
GROUP BY op.quantity_reordered
HAVING op.quantity_reordered < 20
ORDER BY COUNT(p.product_id) ASC;


/*
-List right below this set of comments, the code for the Programming Problem - Multi-table Subquery
-Keep this set of comments in your team's submission
*/

SELECT 
    COUNT(p.product_id) AS product_count,
    op.quantity_reordered,
    op.order_id
FROM
    products p
        JOIN
    order_products op ON p.product_id = op.product_id
        JOIN
    orders o ON op.order_number = o.order_number
WHERE
    op.quantity_reordered > (SELECT 
            AVG(quantity_reordered)
        FROM
            order_products)
GROUP BY op.quantity_reordered , op.order_id
ORDER BY op.quantity_reordered ASC;

/*
-List right below this set of comments, the code for the Programming Problem - Updatable Single Table View
-Keep this set of comments in your team's submission
*/

CREATE VIEW customer_information AS
    SELECT 
        c.user_id,
        c.first_name,
        c.last_name,
        c.email_address,
        a.city
    FROM
        customers c
            JOIN
        addresses a ON c.user_id = a.user_id WITH CHECK OPTION;

SELECT 
    *
FROM
    customer_information
LIMIT 20;

UPDATE customer_information 
SET 
    first_name = 'Ben',
    last_name = 'Kubin',
    email_address = 'benkubin@sql.com'
WHERE
    user_id = '1';
UPDATE customer_information 
SET 
    first_name = 'Sara',
    last_name = 'Hernandez',
    email_address = 'sarahernandez@sql.com'
WHERE
    user_id = '2';
UPDATE customer_information 
SET 
    first_name = 'Mukendi',
    last_name = 'Tshimanga',
    email_address = 'mukenditshimanga@sql.com'
WHERE
    user_id = '3';

SELECT 
    *
FROM
    customer_information
LIMIT 20;

/*
-List right below this set of comments, the code for the Programming Problem - Stored Procedure
-Keep this set of comments in your team's submission
*/

DELIMITER //
CREATE PROCEDURE get_discount(OUT total_price DOUBLE)
BEGIN
	DECLARE days_since_prior_order INT;
    DECLARE discount DOUBLE;
    DECLARE order_number INT;
	-- Per our conversation in class, we have added in a variable 'price' to return an calculated result
    DECLARE price DOUBLE DEFAULT 550.00;
    DECLARE total_price DOUBLE;
    DECLARE done INT DEFAULT 0;
    
    DECLARE cur CURSOR FOR
		SELECT order_number, days_since_prior_order FROM orders;
	
    OPEN cur;
    
	read_loop: LOOP
    FETCH cur INTO order_number, days_since_prior_order;
    IF done = 1 THEN LEAVE read_loop;
	END IF;

    IF days_since_prior_order > (SELECT AVG(days_since_prior_order) FROM orders)
    THEN SET discount = 0.15;
    ELSEIF days_since_prior_order = (SELECT AVG(days_since_prior_order) FROM orders)
	THEN SET discount = 0.10;
        SET done = 1;

    ELSE 
    SET discount = 0.05;
        SET done = 1;

	END IF;
    SET total_price = price * (1 - discount);
    SET done = 1;
	END LOOP;
    
    CLOSE cur;
    SELECT total_price;
END //
DELIMITER ;

CALL get_discount(@total_price);

/*
-List right below this set of comments, the code for the Programming Problem - Stored Function
-Keep this set of comments in your team's submission
*/

DELIMITER //
CREATE FUNCTION total_cost(order_number INT) RETURNS DOUBLE
DETERMINISTIC
BEGIN
	DECLARE total_price DECIMAL(9,2) DEFAULT 0.00;
    DECLARE initial_price DECIMAL(9,2) DEFAULT 0.00;
    DECLARE total_quantity INT;
    DECLARE discount DOUBLE DEFAULT 0.00;
    
    SELECT SUM(p.price * op.quantity) INTO initial_price FROM order_products op
    JOIN products p ON op.product_id = p.product_id
		WHERE op.order_number = order_number;
        
	SELECT SUM(op.quantity + op.quantity_reordered) INTO total_quantity FROM order_products op
		WHERE op.order_number = order_number;
        
	IF total_quantity > 9 THEN SET discount = .25;
    ELSEIF total_quantity > 6 THEN SET discount = .20;
    ELSEIF total_quantity > 3 THEN SET discount = .15;
    END IF;
    
    SET total_price = initial_price - (initial_price * discount);
    RETURN total_price;
END //
DELIMITER ;

SELECT TOTAL_COST(2);
