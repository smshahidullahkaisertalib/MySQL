CREATE DATABASE IF NOT EXISTS interview_questions;
USE interview_questions;
DROP DATABASE interview_questions;

-- Q1 — Customers who never placed an order
CREATE TABLE customers_s1q1 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE orders_s1q1 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20)
);

INSERT INTO customers_s1q1 VALUES
(1,'Ravi Kumar','Mumbai','2024-01-05'),
(2,'Anita Sharma','Delhi','2024-01-10'),
(3,'Vikram Singh','Pune','2024-01-15'),
(4,'Neha Joshi','Bangalore','2024-02-01'),
(5,'Suresh Rao','Chennai','2024-02-10'),
(6,'Priya Nair','Hyderabad','2024-02-15'),
(7,'Amit Verma','Mumbai','2024-03-01'),
(8,'Kavita Desai','Delhi','2024-03-05');

INSERT INTO orders_s1q1 VALUES
(101,1,'2024-01-20','DELIVERED'),
(102,2,'2024-01-25','DELIVERED'),
(103,1,'2024-02-05','CANCELLED'),
(104,4,'2024-02-10','DELIVERED'),
(105,5,'2024-02-20','DELIVERED');

-- Answer
-- Approach 1
SELECT c.customer_id, c.customer_name, o.order_id
FROM customers_s1q1 as c
LEFT JOIN orders_s1q1 as o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Approach 2
SELECT *
FROM customers_s1q1 c
WHERE NOT EXISTS(
    SELECT 1
    FROM orders_s1q1 o
    WHERE c.customer_id = o.customer_id
);

-- Q2 — Average delivery time per restaurant
CREATE TABLE orders_s1q2 (
    order_id INT PRIMARY KEY,
    restaurant_name VARCHAR(50),
    order_time DATETIME,
    delivery_time DATETIME  -- NULL means order is still in transit / undelivered
);

INSERT INTO orders_s1q2 VALUES
(1,'Spice Villa','2024-03-01 12:00:00','2024-03-01 12:45:00'),
(2,'Spice Villa','2024-03-01 13:00:00','2024-03-01 13:50:00'),
(3,'Pizza Hub','2024-03-01 12:10:00','2024-03-01 12:40:00'),
(4,'Pizza Hub','2024-03-01 13:15:00',NULL),
(5,'Pizza Hub','2024-03-01 14:00:00','2024-03-01 14:35:00'),
(6,'Curry House','2024-03-01 12:30:00','2024-03-01 13:20:00');

-- Answer
SELECT restaurant_name, AVG(TIMESTAMPDIFF(MINUTE,order_time, delivery_time)) AS avg_time
FROM orders_s1q2
GROUP BY restaurant_name
ORDER BY avg_time ASC;

-- Q3 — Running wallet balance per customer
CREATE TABLE wallet_transactions_s1q3 (
    txn_id INT PRIMARY KEY,
    customer_id INT,
    txn_date DATE,
    txn_type VARCHAR(10),   -- CREDIT or DEBIT
    amount DECIMAL(10,2)
);

INSERT INTO wallet_transactions_s1q3 VALUES
(1,1,'2024-01-01','CREDIT',1000.00),
(2,1,'2024-01-03','DEBIT',200.00),
(3,1,'2024-01-05','CREDIT',500.00),
(4,1,'2024-01-07','DEBIT',300.00),
(5,2,'2024-01-01','CREDIT',2000.00),
(6,2,'2024-01-04','DEBIT',700.00);


-- Answer
SELECT *, SUM(
    CASE 
        WHEN txn_type = "CREDIT" THEN amount
        WHEN txn_type = "DEBIT" THEN -amount
        ELSE 0
    END
) OVER(PARTITION BY customer_id ORDER BY txn_date) AS running_total
FROM wallet_transactions_s1q3;
SELECT *
FROM wallet_transactions_s1q3;

-- Q4 — Distinct active users per month
-- Q4 — Find the number of distinct active users per month.
CREATE TABLE watch_history_s1q4 (
    watch_id INT PRIMARY KEY,
    user_id INT,
    content_id INT,
    watch_date DATE
);

INSERT INTO watch_history_s1q4 VALUES
(1,1,101,'2024-01-05'),
(2,2,102,'2024-01-10'),
(3,1,103,'2024-01-20'),
(4,3,101,'2024-02-01'),
(5,1,104,'2024-02-15'),
(6,4,105,'2024-02-20'),
(7,2,101,'2024-03-01'),
(8,3,103,'2024-03-05');


-- Answer
SELECT DATE_FORMAT(watch_date, "%Y-%m") AS MONTH, COUNT(DISTINCT user_id) AS Active_User
FROM watch_history_s1q4
GROUP BY DATE_FORMAT(watch_date, "%Y-%m");

-- Q5 — Trip cancellation rate per city
CREATE TABLE trips_s1q5 (
    trip_id INT PRIMARY KEY,
    city VARCHAR(30),
    rider_id INT,
    driver_id INT,
    trip_status VARCHAR(20)  -- COMPLETED, CANCELLED_BY_RIDER, CANCELLED_BY_DRIVER
);

INSERT INTO trips_s1q5 VALUES
(1,'Mumbai',1,10,'COMPLETED'),
(2,'Mumbai',2,11,'CANCELLED_BY_RIDER'),
(3,'Mumbai',3,10,'COMPLETED'),
(4,'Mumbai',4,12,'CANCELLED_BY_DRIVER'),
(5,'Delhi',5,13,'COMPLETED'),
(6,'Delhi',6,14,'COMPLETED'),
(7,'Delhi',7,13,'CANCELLED_BY_RIDER'),
(8,'Pune',8,15,'COMPLETED');

-- Answer
SELECT city, COUNT(trip_id) AS total_trip,
SUM(
    CASE 
        WHEN trip_status LIKE "CANCELLED%" THEN 1 
        ELSE 0 
    END
) AS Cencelled_Trips,
SUM(
    (
        CASE 
            WHEN trip_status LIKE "CANCELLED%" THEN 1 
            ELSE 0 
        END
    )) * 100 / COUNT(trip_id) AS Cancallation_Rate
FROM trips_s1q5
GROUP BY city;

SELECT *
FROM trips_s1q5;