--creating customers table,

CREATE TABLE customers(
  customer_id INT,
  customer_name VARCHAR(50),
  city VARCHAR(50),
  state VARCHAR(10)
);

-- inserting the values into customers table

INSERT INTO customers VALUES
(1,'Amit','Hyderabad','TS'),
(2,'Ravi','Bangalore','KA'),
(3,'Suresh','Chennai','TN'),
(4,'Kiran','Mumbai','MH'),
(5,'Arjun','Delhi','DL'),
(6,'Vikram','Pune','MH'),
(7,'Rahul','Kolkata','WB'),
(8,'Manoj','Jaipur','RJ'),
(9,'Anil','Vizag','AP'),
(10,'Naveen','Kochi','KL');

-- creating table products
CREATE TABLE products (
  product_id INT,
  product_name VARCHAR(50),
  category VARCHAR(50),
  price INT
);

-- inserting values into products table
INSERT INTO products VALUES
(101,'Laptop','Electronics',55000),
(102,'Mobile','Electronics',25000),
(103,'Headphones','Electronics',3000),
(104,'Chair','Furniture',7000),
(105,'Table','Furniture',12000),
(106,'Shoes','Fashion',4000),
(107,'T-Shirt','Fashion',1500),
(108,'Watch','Accessories',8000),
(109,'Backpack','Accessories',3500),
(110,'Books','Education',1200);

--creating orders table
CREATE TABLE orders (
  order_id INT,
  customer_id INT,
  order_date DATE,
  order_status VARCHAR(20)
);

-- inserting values into orders table

INSERT INTO orders VALUES
(201,1,'2025-01-05','Delivered'),
(202,2,'2025-01-07','Delivered'),
(203,3,'2025-01-10','Cancelled'),
(204,4,'2025-01-12','Delivered'),
(205,5,'2025-01-15','Delivered'),
(206,6,'2025-01-18','Pending'),
(207,7,'2025-01-20','Delivered'),
(208,8,'2025-01-22','Delivered'),
(209,9,'2025-01-25','Delivered'),
(210,10,'2025-01-28','Delivered');

--creating order_items table
CREATE TABLE order_items (
  order_item_id INT,
  order_id INT,
  product_id INT,
  quantity INT
);

--inserting values into order_items table

INSERT INTO order_items VALUES
(1,201,101,1),
(2,202,102,1),
(3,203,103,2),
(4,204,104,1),
(5,205,105,1),
(6,206,106,2),
(7,207,107,3),
(8,208,108,1),
(9,209,109,2),
(10,210,110,4);


--creating payments table
CREATE TABLE payments (
  payment_id INT,
  order_id INT,
  payment_method VARCHAR(20),
  payment_amount INT
);

--inserting values into payments table

INSERT INTO payments VALUES
(1,201,'UPI',55000),
(2,202,'Card',25000),
(3,203,'UPI',6000),
(4,204,'Card',7000),
(5,205,'NetBanking',12000),
(6,206,'UPI',8000),
(7,207,'Card',4500),
(8,208,'UPI',8000),
(9,209,'NetBanking',7000),
(10,210,'Card',4800);

--Task 1 :- data validation and sanity check
-- count of all rows
SELECT 'CUSTOMERS' AS table_name , 
COUNT(*) AS row_count
FROM customers
UNION ALL
SELECT 'PRODUCTS' , COUNT(*) FROM products
UNION ALL 
SELECT 'ORDERS' , COUNT(*) FROM orders
UNION ALL 
SELECT 'ORDER_ITEMS' , COUNT(*) FROM order_items
UNION ALL
SELECT 'PAYMENTS' , COUNT(*) FROM payments;


--Identifying  any orders without payments 
SELECT (p.*),(O.*)
FROM payments p
LEFT JOIN orders o
ON p.order_id = o.order_id
WHERE payment_method IS NULL;




--Task 2 :- order & customer mapping
--combining customers and orders
SELECT (c.*),(o.*)
FROM customers c
INNER JOIN orders o 
ON c.customer_id = o.customer_id;

--analysing order distribution by customer
SELECT 
	(c.customer_name),
	(c.city),
	(o.order_status)
FROM 
	customers c 
LEFT JOIN
	orders o 
ON
	c.customer_id = o.customer_id
WHERE 
	customer_name = 'Ravi';


-- identifying customers with multiple orders

SELECT 
	(c.customer_id),
	(c.customer_name),
	(o.order_id),
	COUNT(order_id) AS no_of_ordrs
FROM 
	customers c
LEFT JOIN
	orders o
ON 
	c.customer_id = o.order_id
GROUP BY
	(c.customer_id),
	(c.customer_name),
	(o.order_id)
HAVING COUNT(order_id) > 1;
	
--customers with cancelled orders

SELECT 
	(c.customer_id),
	(o.order_id),
	(c.customer_name),
	(o.order_status)
FROM 
	customers c
LEFT JOIN
	orders o
ON 
	c.customer_id = o.customer_id
WHERE
	order_status = 'Cancelled';

--sorting customer by most recent order

SELECT 
	(c.customer_id),
	(o.order_id),
	(c.customer_name),
	(o.order_date)
FROM 
	customers c
LEFT JOIN 
	orders o
ON 
	c.customer_id = o.customer_id
WHERE
	order_date = (SELECT MAX(o.order_date)
					FROM orders o);


-- Task 3 ( revenue logic verification )
--calculating order-level revenue
SELECT
	o.order_id,
	SUM(oi.quantity*p.price) AS order_revenue
FROM orders o
LEFT JOIN
	order_items oi 
ON
	o.order_id = oi.order_id
LEFT JOIN
	products p
ON 
	oi.product_id = p.product_id
GROUP BY
	o.order_id
ORDER BY 
	order_revenue DESC;



-- filter only completed (delivered) orders
SELECT 
	SUM(oi.quantity*p.price) AS total_revenue
FROM 
	orders o
LEFT JOIN
	order_items oi
ON 
	o.order_id = oi.order_id 
LEFT JOIN
	products p
ON 
	p.product_id = oi.product_id
WHERE 
	o.order_status = 'Delivered';


--explain revenue calculation logic





--Step 4 :- customer spending analysis 
--calculating total spending per customer
SELECT DISTINCT
	(c.customer_name),
	(SUM(pa.payment_amount)) AS total_spent
FROM 
	customers c
LEFT JOIN 
	orders o
ON
	c.customer_id = o.customer_id
LEFT JOIN 
	payments pa
ON 
	pa.order_id = o.order_id
GROUP BY
	c.customer_name
ORDER BY
	total_spent DESC;


--rank customers by spendings 
SELECT
	c.customer_name,
	SUM(pa.payment_amount) AS total_spents,
RANK() OVER(ORDER BY SUM(pa.payment_amount) DESC) AS spend_rank
FROM 
	customers c
LEFT JOIN 
	orders o
ON 
	c.customer_id = o.customer_id
LEFT JOIN
	payments pa
ON
	pa.order_id = o.order_id
GROUP BY 
	c.customer_name
ORDER BY
	spend_rank;


--segment customers into high/medium/low spenders
 WITH customer_spend AS(
 	SELECT
		c.customer_id,
		c.customer_name,
		SUM(pa.payment_amount) AS total_spend
	FROM customers c
	JOIN orders o USING (customer_id)
	JOIN payments pa USING (order_id)
	GROUP BY c.customer_id,c.customer_name
)
SELECT
	(customer_id),
	(customer_name),
	(total_spenD),
	CASE
		WHEN total_spend < 10000 THEN 'low spend'
		WHEN total_spend BETWEEN 10000 AND 20000 THEN 'medium spend'
		ELSE 'high spend'
	END AS spend_segment
FROM customer_spend
ORDER BY total_spend DESC;

--identify cities with highest customer spend
SELECT 
	(c.customer_id),
	(c.city),
	(p.product_id),
	(c.customer_name),
	(p.price)
FROM 
	customers c
LEFT JOIN
	orders o USING (customer_id)
LEFT JOIN
	order_items oi USING (order_id)
LEFT JOIN
	products p USING (product_id)
WHERE
	p.price = (SELECT MAX(price) AS maxi_pri FROM products) --subquery intialisation


-- Task 5 :- (product performance analysis)
-- calculate total quantity of products sold
SELECT 
	(c.customer_name),
	(p.product_name),
	(p.category),
	(oi.quantity)
FROM 
	customers c
LEFT JOIN
	orders o USING (customer_id)
LEFT JOIN
	order_items oi USING (order_id)
LEFT  JOIN
	products p USING (product_id);


--calculate total quantity per category
SELECT DISTINCT
	(p.category),
	SUM(oi.quantity) AS total_quan_per_category
FROM
	order_items oi
LEFT JOIN
	products p USING (product_id)
GROUP BY 
	(p.category)
ORDER BY
	total_quan_per_category DESC;


-- calculating revenue per category and quantity of products 
SELECT DISTINCT
	(p.category),
	SUM(oi.quantity*p.price) AS category_revenue
FROM 
	products p
LEFT JOIN
	order_items oi USING (product_id)
GROUP BY 
	p.category
ORDER BY 
	category_revenue DESC;


--rank products by revenue 
SELECT 
	p.product_name,
	p.category,
	SUM(price) AS revenue_product,
RANK() OVER(ORDER BY SUM(oi.quantity*p.price) DESC ) AS revenue_rank 
FROM 
	products p
LEFT JOIN 
	order_items oi
 ON 
 	p.product_id = oi.product_id
GROUP BY
	product_name,
	category
ORDER BY 
	revenue_rank;


--Task 6 :- time based analysis
--identify peak order dates
SELECT 
	o.order_id,
	o.order_date,
	SUM(oi.quantity) AS total_quantity
FROM 
	orders o 
LEFT JOIN
	order_items oi USING (order_id)
GROUP BY
	o.order_id,o.order_date
ORDER BY 
	SUM(oi.quantity) DESC
LIMIT 5;


--Task 7 :- advanced insight task
--rank customers using window logic
WITH customer_spend AS(
	SELECT 
		c.customer_id,
		c.customer_name,
		SUM(oi.quantity * p.price) AS total_spenT
	FROM customers c
	LEFT JOIN orders o USING (customer_id)
	LEFT JOIN order_items oi USING (order_id)
	LEFT JOIN products p USING (product_id)
	GROUP BY c.customer_id,c.customer_name
)
SELECT 
	customer_id,
	customer_name,
	total_spenT,
	RANK() OVER(ORDER BY total_spenT DESC) AS spend_rank
FROM customer_spend;


--rank products within each category
WITH product_revenue AS(
	SELECT
		p.category,
		p.product_name,
		SUM(oi.quantity*p.price) AS revenue
	FROM products p
	JOIN order_items oi USING (product_id)
	GROUP BY p.category,p.product_name
)	
SELECT 
	category,
	product_name,
	revenue,
	RANK() OVER(
		PARTITION BY category
		ORDER BY revenue DESC
	) AS  category_rank
FROM product_revenue;


--compare indivisual customer spend to overall avergare
WITH customer_spend AS(
	SELECT
		c.customer_id,
		c.customer_name,
		SUM(oi.quantity*p.price) AS total_spent
	FROM customers c
	JOIN orders o USING (customer_id)
	JOIN order_items oi USING (order_id)
	JOIN products p USING (product_id)
	GROUP BY c.customer_id,c.customer_name
)
SELECT
	customer_id,
	customer_name,
	total_spent,
	AVG(total_spent) OVER() AS avg_customer_spend,
	total_spent - AVG(total_spent) OVER() AS spend_difference
FROM customer_spend
ORDER BY total_spent DESC;

	
	

















SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;








