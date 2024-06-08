CREATE DATABASE sales_db;
USE sales_db;

CREATE TABLE sales_data (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    product_id INT,
    category VARCHAR(100),
    sales DECIMAL(10, 2),
    discount DECIMAL(5, 2)
);


INSERT INTO sales_data (order_id, order_date, customer_id, customer_name, segment, product_id, category, sales, discount) VALUES
(1, '2023-01-15', 101, 'Amit Sharma', 'Consumer', 1001, 'Electronics', 15000.50, 10.00),
(2, '2023-01-16', 102, 'Sakshi Verma', 'Corporate', 1002, 'Furniture', 25000.75, 12.50),
(3, '2023-01-17', 103, 'Rahul Kumar', 'Home Office', 1003, 'Office Supplies', 5000.20, 5.00),
(4, '2023-01-18', 104, 'Neha Gupta', 'Consumer', 1004, 'Electronics', 10000.00, 8.00),
(5, '2023-01-19', 105, 'Rajesh Singh', 'Corporate', 1005, 'Furniture', 30000.90, 15.00),
(6, '2023-01-20', 106, 'Pooja Patil', 'Home Office', 1006, 'Office Supplies', 7000.30, 7.00),
(7, '2023-01-21', 107, 'Vikram Jain', 'Consumer', 1007, 'Electronics', 12000.45, 9.50),
(8, '2023-01-22', 108, 'Aishwarya Iyer', 'Corporate', 1008, 'Furniture', 20000.65, 11.00),
(9, '2023-01-23', 109, 'Karan Mehta', 'Home Office', 1009, 'Office Supplies', 6000.80, 6.00),
(10, '2023-01-24', 110, 'Deepika Rao', 'Consumer', 1010, 'Electronics', 18000.55, 10.50);


SELECT * FROM sales_data;


SELECT 
    category,
    segment,
    SUM(sales) AS total_sales,
    AVG(discount) AS average_discount
FROM 
    sales_data
GROUP BY 
    category, segment;
    
    
CREATE TABLE product_details (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    product_description TEXT
);
-- Inserting real product details into the product_details table
INSERT INTO product_details (product_id, product_name, product_description) VALUES 
(1, 'Masala Tea', 'A flavorful tea infused with traditional Indian spices such as cinnamon, cardamom, and ginger.'),
(2, 'Sari', 'A traditional Indian garment available in a variety of colors and designs, typically worn for special occasions.'),
(3, 'Potato Bhaji', 'A classic Indian vegetable dish made by frying potatoes in oil and seasoning them with spices.');

    
    
    
SELECT 
    sd.order_id,
    sd.order_date,
    sd.customer_id,
    sd.customer_name,
    sd.segment,
    sd.category,
    sd.sales,
    sd.discount,
    pd.product_name,
    pd.product_description
FROM 
    sales_data sd
JOIN 
    product_details pd
ON 
    sd.product_id = pd.product_id;
    



CREATE TABLE monthly_sales_data AS
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS total_sales
FROM
    sales_data
GROUP BY
    DATE_FORMAT(order_date, '%Y-%m');
    
INSERT INTO monthly_sales_data (month, total_sales) VALUES
('2024-01-01', 4200.00),
('2024-02-01', 3700.00),
('2024-03-01', 4500.00),
('2024-04-01', 3900.00),
('2024-05-01', 4800.00),
('2024-06-01', 4300.00),
('2024-07-01', 4600.00),
('2024-08-01', 4100.00),
('2024-09-01', 4700.00),
('2024-10-01', 4400.00);

SELECT * FROM monthly_sales_data;


SELECT
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales,
    (total_sales - LAG(total_sales) OVER (ORDER BY month)) / LAG(total_sales) OVER (ORDER BY month) * 100 AS month_over_month_growth_rate
FROM
    monthly_sales_data;
    
    
 SELECT
    customer_name,
    SUM(sales) AS total_sales,
    AVG(discount) AS average_discount
FROM
    sales_data
GROUP BY
    customer_name
ORDER BY
    total_sales DESC
LIMIT 10;
   
   
   
   
