-- Question 1: Find rooms that have overlapping (double-booked) bookings.

-- 🗄️ Dataset
CREATE TABLE bookings_s2q1 (
    booking_id INT PRIMARY KEY,
    room_id INT,
    guest_name VARCHAR(50),
    check_in DATE,
    check_out DATE
);

INSERT INTO bookings_s2q1 VALUES
(1,101,'Ravi Kumar','2024-04-01','2024-04-05'),
(2,101,'Anita Sharma','2024-04-04','2024-04-08'),
(3,102,'Vikram Singh','2024-04-01','2024-04-03'),
(4,102,'Neha Joshi','2024-04-03','2024-04-06'),
(5,103,'Suresh Rao','2024-04-01','2024-04-02'),
(6,101,'Priya Nair','2024-04-10','2024-04-12');

SELECT *
FROM bookings_s2q1;
SELECT b.room_id, b.booking_id AS booking_id_1, b.guest_name AS Guest_1, bk.booking_id AS booking_id_2, bk.guest_name AS Guest_2
FROM bookings_s2q1 b
JOIN bookings_s2q1 bk
ON b.room_id = bk.room_id
AND b.booking_id < bk.booking_id
AND b.check_in < bk.check_out
AND b.check_out > bk.check_in;

     guest 1                guest 2
-- b.check_in < (after) bk.check_out
-- b.check_out > (before) bk.check_in

-- Q2 — Find the top-selling product (by quantity) in each category.
CREATE TABLE products_s2q2 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30)
);

CREATE TABLE sales_s2q2 (
    sale_id INT PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE
);

INSERT INTO products_s2q2 VALUES
(1,'Colgate Toothpaste','Personal Care'),
(2,'Dove Soap','Personal Care'),
(3,'Tata Salt','Grocery'),
(4,'Aashirvaad Atta','Grocery'),
(5,'Lays Chips','Snacks'),
(6,'Kurkure','Snacks');

INSERT INTO sales_s2q2 VALUES
(1,1,50,'2024-01-01'),
(2,2,80,'2024-01-02'),
(3,3,120,'2024-01-03'),
(4,4,150,'2024-01-04'),
(5,5,200,'2024-01-05'),
(6,6,90,'2024-01-06'),
(7,1,30,'2024-01-07'),
(8,4,60,'2024-01-08');


-- Answer
SELECT *
FROM products_s2q2 p
JOIN sales_s2q2 s
ON p.product_id = s.product_id;


WITH
    summary_table AS (
        SELECT p.category, p.product_name, SUM(s.quantity_sold) AS quantity_sold
        FROM products_s2q2 p
            JOIN sales_s2q2 s ON p.product_id = s.product_id
        GROUP BY
            p.category,
            p.product_name
        ORDER BY quantity_sold DESC
    )
SELECT *
FROM (
        SELECT *, ROW_NUMBER() OVER (
                PARTITION BY category
                ORDER BY quantity_sold DESC
            ) as ranking
        FROM summary_table
    ) temp_table
WHERE
    ranking = 1
ORDER BY quantity_sold DESC;


-- Q3 - Find patients who booked more than one appointment on the same day.
CREATE TABLE appointments_s2q3 (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE
);

INSERT INTO appointments_s2q3 VALUES
(1,1,10,'2024-05-01'),
(2,1,11,'2024-05-01'),
(3,2,10,'2024-05-01'),
(4,3,12,'2024-05-02'),
(5,3,12,'2024-05-02'),
(6,4,13,'2024-05-03'),
(7,1,10,'2024-05-04');


-- Answer
SELECT *
FROM appointments_s2q3;

SELECT patient_id,appointment_date, COUNT(appointment_id)
FROM appointments_s2q3 as ap
GROUP BY patient_id, appointment_date
HAVING COUNT(appointment_id) > 1;


-- Q4 — Find customers who downgraded from a paid plan (BASIC/PRO) to the free plan.
CREATE TABLE subscriptions_s2q4 (
    subscription_id INT PRIMARY KEY,
    customer_id INT,
    plan_type VARCHAR(20),   -- FREE, BASIC, PRO
    start_date DATE,
    end_date DATE
);

INSERT INTO subscriptions_s2q4 VALUES
(1,1,'BASIC','2024-01-01','2024-02-01'),
(2,1,'FREE','2024-02-01',NULL),
(3,2,'PRO','2024-01-01','2024-03-01'),
(4,2,'PRO','2024-03-01',NULL),
(5,3,'FREE','2024-01-01','2024-02-01'),
(6,3,'BASIC','2024-02-01',NULL);

-- Answer
SELECT *
FROM subscriptions_s2q4;
-- Find customers who downgraded from a paid plan (BASIC/PRO) to the free plan.
WITH cte as (SELECT 
    (CASE 
    WHEN LAG(plan_type) OVER(PARTITION BY customer_id) <> "free" AND plan_type = "free" THEN customer_id  
    END) AS customer_id,
     LAG(plan_type) OVER(PARTITION BY customer_id) AS from_plan, plan_type as to_plan, LAG(end_date) OVER(PARTITION BY customer_id) AS end_date
FROM subscriptions_s2q4)

SELECT *
FROM cte
WHERE customer_id IS NOT NULL;




WITH cte as (SELECT customer_id, LAG(plan_type) OVER(PARTITION BY customer_id) AS from_plan, plan_type as to_plan, LAG(end_date) OVER(PARTITION BY customer_id) AS end_date
FROM subscriptions_s2q4)

SELECT *
FROM cte
WHERE end_date IS NOT NULL;



