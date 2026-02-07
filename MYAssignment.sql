
-- E-Commerce Database Schema for PostgreSQL
-- Author: [Tumayine desire (26588)]
-- Date: February 2026


-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

-- Table 1: Customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    region VARCHAR(50) NOT NULL,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 2: Products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price > 0),
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table 3: Orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Table 4: Order Items
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Create indexes for better query performance
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_orders_date ON orders(order_date);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_customers_region ON customers(region);


-- Sample Data Generation


-- Insert Customers (30 customers across 4 regions)
INSERT INTO customers (customer_name, email, region, registration_date) VALUES
-- Rwanda customers
('Jean Baptiste', 'jean.b@email.com', 'Rwanda', '2024-01-15'),
('Marie Claire', 'marie.c@email.com', 'Rwanda', '2024-02-20'),
('Patrick Nkunda', 'patrick.n@email.com', 'Rwanda', '2024-03-10'),
('Grace Uwase', 'grace.u@email.com', 'Rwanda', '2024-04-05'),
('David Mugisha', 'david.m@email.com', 'Rwanda', '2024-05-12'),
('Diane Umutoni', 'diane.u@email.com', 'Rwanda', '2024-06-18'),
('Eric Habimana', 'eric.h@email.com', 'Rwanda', '2024-07-22'),

-- Kenya customers
('John Kamau', 'john.k@email.com', 'Kenya', '2024-01-25'),
('Alice Wanjiru', 'alice.w@email.com', 'Kenya', '2024-02-14'),
('Peter Omondi', 'peter.o@email.com', 'Kenya', '2024-03-20'),
('Lucy Akinyi', 'lucy.a@email.com', 'Kenya', '2024-04-15'),
('James Mwangi', 'james.m@email.com', 'Kenya', '2024-05-08'),
('Sarah Chebet', 'sarah.c@email.com', 'Kenya', '2024-06-30'),
('Michael Kipchoge', 'michael.k@email.com', 'Kenya', '2024-08-11'),

-- Uganda customers
('Joseph Okello', 'joseph.o@email.com', 'Uganda', '2024-02-05'),
('Rebecca Nakato', 'rebecca.n@email.com', 'Uganda', '2024-03-15'),
('Samuel Mutesi', 'samuel.m@email.com', 'Uganda', '2024-04-20'),
('Florence Nambi', 'florence.n@email.com', 'Uganda', '2024-05-25'),
('Charles Ssemakula', 'charles.s@email.com', 'Uganda', '2024-06-10'),
('Betty Akello', 'betty.a@email.com', 'Uganda', '2024-07-15'),
('Daniel Musoke', 'daniel.m@email.com', 'Uganda', '2024-08-20'),

-- Tanzania customers
('Abdul Hassan', 'abdul.h@email.com', 'Tanzania', '2024-01-30'),
('Fatuma Mohamed', 'fatuma.m@email.com', 'Tanzania', '2024-02-28'),
('Juma Rashid', 'juma.r@email.com', 'Tanzania', '2024-03-25'),
('Amina Said', 'amina.s@email.com', 'Tanzania', '2024-04-18'),
('Hassan Bakari', 'hassan.b@email.com', 'Tanzania', '2024-05-22'),
('Zainab Ali', 'zainab.a@email.com', 'Tanzania', '2024-06-28'),
('Omar Salum', 'omar.s@email.com', 'Tanzania', '2024-07-30'),
('Halima Juma', 'halima.j@email.com', 'Tanzania', '2024-08-25'),
('Ibrahim Musa', 'ibrahim.m@email.com', 'Tanzania', '2024-09-10');

-- Insert Products (20 products across different categories)
INSERT INTO products (product_name, category, unit_price, stock_quantity) VALUES
-- Electronics
('Samsung Galaxy S24', 'Electronics', 899.99, 50),
('iPhone 15 Pro', 'Electronics', 1199.99, 30),
('HP Laptop Elite', 'Electronics', 799.99, 25),
('Dell Monitor 27"', 'Electronics', 299.99, 40),
('Sony Headphones', 'Electronics', 149.99, 60),

-- Home & Kitchen
('Blender Pro 3000', 'Home & Kitchen', 89.99, 100),
('Coffee Maker Deluxe', 'Home & Kitchen', 129.99, 80),
('Rice Cooker Smart', 'Home & Kitchen', 79.99, 90),
('Microwave Oven', 'Home & Kitchen', 199.99, 45),

-- Fashion
('Nike Running Shoes', 'Fashion', 119.99, 120),
('Adidas Tracksuit', 'Fashion', 89.99, 150),
('Levi Jeans', 'Fashion', 69.99, 200),
('Polo Shirt Collection', 'Fashion', 39.99, 180),

-- Books & Stationery
('Business Strategy Book', 'Books', 29.99, 100),
('Python Programming Guide', 'Books', 49.99, 75),
('Notebook Set Premium', 'Books', 19.99, 200),

-- Sports & Outdoors
('Yoga Mat Professional', 'Sports', 34.99, 110),
('Dumbell Set 20kg', 'Sports', 89.99, 65),
('Camping Tent 4-Person', 'Sports', 199.99, 40),
('Mountain Bike', 'Sports', 499.99, 20);

-- Insert Orders (80 orders across different months)
INSERT INTO orders (customer_id, order_date, total_amount) VALUES
-- September 2024
(1, '2024-09-05', 899.99),
(2, '2024-09-08', 219.98),
(3, '2024-09-12', 1199.99),
(8, '2024-09-15', 428.98),
(15, '2024-09-18', 179.98),
(22, '2024-09-22', 299.99),
(5, '2024-09-25', 549.97),

-- October 2024
(4, '2024-10-02', 799.99),
(9, '2024-10-05', 369.96),
(16, '2024-10-08', 119.99),
(23, '2024-10-11', 249.98),
(6, '2024-10-14', 89.99),
(10, '2024-10-17', 1199.99),
(17, '2024-10-20', 199.99),
(24, '2024-10-23', 159.98),
(7, '2024-10-26', 499.99),
(11, '2024-10-29', 279.97),

-- November 2024
(12, '2024-11-03', 899.99),
(18, '2024-11-06', 329.97),
(25, '2024-11-09', 149.99),
(1, '2024-11-12', 299.99),
(13, '2024-11-15', 699.98),
(19, '2024-11-18', 119.99),
(26, '2024-11-21', 419.96),
(3, '2024-11-24', 799.99),
(14, '2024-11-27', 229.98),

-- December 2024
(20, '2024-12-01', 1199.99),
(27, '2024-12-04', 549.97),
(8, '2024-12-07', 299.99),
(15, '2024-12-10', 179.98),
(21, '2024-12-13', 89.99),
(28, '2024-12-16', 499.99),
(9, '2024-12-19', 899.99),
(16, '2024-12-22', 369.96),
(22, '2024-12-25', 249.98),
(29, '2024-12-28', 799.99),

-- January 2025
(2, '2025-01-05', 1199.99),
(10, '2025-01-08', 459.97),
(17, '2025-01-11', 299.99),
(23, '2025-01-14', 179.98),
(30, '2025-01-17', 899.99),
(4, '2025-01-20', 549.97),
(11, '2025-01-23', 329.97),
(18, '2025-01-26', 199.99),
(24, '2025-01-29', 699.98);

-- Insert Order Items (multiple items per order)
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
-- Order 1
(1, 1, 1, 899.99),
-- Order 2
(2, 6, 1, 89.99),
(2, 16, 2, 19.99),
(2, 10, 1, 119.99),
-- Order 3
(3, 2, 1, 1199.99),
-- Order 4
(4, 4, 1, 299.99),
(4, 5, 1, 149.99),
-- Order 5
(5, 7, 1, 129.99),
(5, 14, 1, 29.99),
(5, 15, 1, 49.99),
-- Order 6
(6, 4, 1, 299.99),
-- Order 7
(7, 10, 2, 119.99),
(7, 11, 2, 89.99),
(7, 12, 2, 69.99),
-- Order 8
(8, 3, 1, 799.99),
-- Order 9
(9, 10, 1, 119.99),
(9, 11, 1, 89.99),
(9, 13, 3, 39.99),
-- Order 10
(10, 10, 1, 119.99),
-- Continue pattern for remaining orders...
(11, 6, 1, 89.99),
(11, 8, 2, 79.99),
(12, 6, 1, 89.99),
(13, 2, 1, 1199.99),
(14, 9, 1, 199.99),
(15, 5, 1, 149.99),
(15, 16, 1, 19.99),
(16, 20, 1, 499.99),
(17, 11, 1, 89.99),
(17, 12, 1, 69.99),
(17, 13, 3, 39.99),
(18, 1, 1, 899.99),
(19, 7, 1, 129.99),
(19, 17, 2, 34.99),
(19, 16, 3, 19.99),
(20, 5, 1, 149.99),
(21, 3, 1, 799.99),
(22, 10, 1, 119.99),
(23, 17, 4, 34.99),
(23, 18, 2, 89.99),
(23, 14, 3, 29.99),
(24, 3, 1, 799.99),
(25, 10, 1, 119.99),
(25, 13, 3, 39.99),
(26, 2, 1, 1199.99),
(27, 10, 2, 119.99),
(27, 11, 2, 89.99),
(27, 12, 2, 69.99),
(28, 4, 1, 299.99),
(29, 5, 1, 149.99),
(29, 16, 2, 19.99),
(29, 17, 2, 34.99),
(30, 6, 1, 89.99),
(31, 20, 1, 499.99),
(32, 1, 1, 899.99),
(33, 7, 1, 129.99),
(33, 8, 2, 79.99),
(34, 4, 1, 299.99),
(35, 3, 1, 799.99),
(36, 2, 1, 1199.99),
(37, 10, 2, 119.99),
(37, 11, 1, 89.99),
(38, 9, 1, 199.99),
(39, 1, 1, 899.99),
(40, 12, 3, 69.99),
(40, 13, 4, 39.99),
(40, 14, 2, 29.99),
(41, 2, 1, 1199.99),
(42, 17, 4, 34.99),
(42, 18, 3, 89.99),
(43, 4, 1, 299.99),
(44, 5, 1, 149.99),
(44, 16, 2, 19.99),
(45, 1, 1, 899.99),
(46, 10, 2, 119.99),
(46, 11, 2, 89.99),
(46, 12, 2, 69.99);



-- INNER JOIN: Complete Transaction Analysis

-- Purpose: Retrieve all valid transactions with complete customer and product information
-- Business Use: Analyze actual sales performance with full data integrity


SELECT 
    -- Order Information
    o.order_id,
    o.order_date,
    TO_CHAR(o.order_date, 'Month YYYY') AS order_month,
    
    -- Customer Information
    c.customer_id,
    c.customer_name,
    c.email,
    c.region,
    
    -- Product Information
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price,
    
    -- Transaction Details
    oi.quantity,
    oi.price AS actual_price,
    (oi.quantity * oi.price) AS line_total,
    o.total_amount AS order_total
    
FROM orders o
-- Join to get customer details
INNER JOIN customers c ON o.customer_id = c.customer_id
-- Join to get order line items
INNER JOIN order_items oi ON o.order_id = oi.order_id
-- Join to get product details
INNER JOIN products p ON oi.product_id = p.product_id

-- Order by most recent transactions first
ORDER BY o.order_date DESC, o.order_id, oi.order_item_id
LIMIT 25;


-- LEFT JOIN: Inactive Customer Identification

-- Purpose: Find customers who registered but never purchased
-- Business Use: Target re-engagement and activation campaigns


SELECT 
    -- Customer Information
    c.customer_id,
    c.customer_name,
    c.email,
    c.region,
    c.registration_date,
    
    -- Calculate days since registration
    CURRENT_DATE - c.registration_date AS days_since_registration,
    
    -- Order Statistics
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    MAX(o.order_date) AS last_order_date,
    
    -- Customer Status
    CASE 
        WHEN COUNT(o.order_id) = 0 THEN 'Never Purchased'
        ELSE 'Active Customer'
    END AS customer_status

FROM customers c
-- LEFT JOIN keeps all customers, even those without orders
LEFT JOIN orders o ON c.customer_id = o.customer_id

GROUP BY 
    c.customer_id, 
    c.customer_name, 
    c.email, 
    c.region, 
    c.registration_date

-- Filter to show only customers who never made a purchase
HAVING COUNT(o.order_id) = 0

-- Order by registration date (oldest first - highest priority for re-engagement)
ORDER BY c.registration_date ASC;


-- RIGHT JOIN: Dead Stock Identification

-- Purpose: Identify products that have never been sold
-- Business Use: Inventory optimization and clearance planning



SELECT 
    -- Product Information
    p.product_id,
    p.product_name,
    p.category,
    p.unit_price,
    p.stock_quantity,
    
    -- Calculate inventory value at risk
    (p.unit_price * p.stock_quantity) AS inventory_value,
    
    -- Sales Statistics
    COUNT(oi.order_item_id) AS times_sold,
    COALESCE(SUM(oi.quantity), 0) AS total_units_sold,
    COALESCE(SUM(oi.quantity * oi.price), 0) AS total_revenue_generated,
    MAX(o.order_date) AS last_sold_date,
    
    -- Product Status Classification
    CASE 
        WHEN COUNT(oi.order_item_id) = 0 THEN 'Never Sold - Dead Stock'
        WHEN COUNT(oi.order_item_id) < 3 THEN 'Slow Moving'
        ELSE 'Active Product'
    END AS product_status

FROM order_items oi
-- Join to get order dates
LEFT JOIN orders o ON oi.order_id = o.order_id
-- RIGHT JOIN keeps all products, even those never sold
RIGHT JOIN products p ON oi.product_id = p.product_id

GROUP BY 
    p.product_id, 
    p.product_name, 
    p.category, 
    p.unit_price, 
    p.stock_quantity

-- Filter to show only products that have never sold
HAVING COUNT(oi.order_item_id) = 0

-- Order by inventory value (highest risk first)
ORDER BY inventory_value DESC;


-- FULL OUTER JOIN: Comprehensive Gap Analysis

-- Purpose: Identify all customers and products, highlighting gaps
-- Business Use: Strategic planning for customer engagement and inventory


SELECT 
    -- Customer Information
    c.customer_id,
    c.customer_name,
    c.region,
    c.registration_date,
    
    -- Product Information
    p.product_id,
    p.product_name,
    p.category,
    
    -- Transaction Information
    COUNT(DISTINCT o.order_id) AS order_count,
    COUNT(DISTINCT oi.order_item_id) AS items_purchased,
    COALESCE(SUM(oi.quantity * oi.price), 0) AS total_revenue,
    
    -- Gap Analysis Classification
    CASE 
        WHEN c.customer_id IS NULL THEN 'Data Error: Product without customer context'
        WHEN p.product_id IS NULL THEN 'Customer registered but no product purchased yet'
        WHEN COUNT(oi.order_item_id) = 0 THEN 'Customer and product exist but no transaction'
        ELSE 'Active customer-product relationship'
    END AS relationship_status,
    
    -- Business Action Recommendation
    CASE 
        WHEN c.customer_id IS NOT NULL AND COUNT(o.order_id) = 0 THEN 'Send activation campaign'
        WHEN p.product_id IS NOT NULL AND COUNT(oi.order_item_id) = 0 THEN 'Product needs promotion'
        WHEN COUNT(oi.order_item_id) > 0 THEN 'Maintain relationship'
        ELSE 'Review data integrity'
    END AS recommended_action

FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id
FULL OUTER JOIN order_items oi ON o.order_id = oi.order_id
FULL OUTER JOIN products p ON oi.product_id = p.product_id

GROUP BY 
    c.customer_id, 
    c.customer_name, 
    c.region, 
    c.registration_date,
    p.product_id, 
    p.product_name, 
    p.category

-- Show gaps and opportunities
HAVING COUNT(oi.order_item_id) = 0 OR c.customer_id IS NULL OR p.product_id IS NULL

ORDER BY total_revenue DESC, c.customer_name, p.product_name
LIMIT 30;


-- SELF JOIN: Regional Customer Comparison

-- Purpose: Compare customers within same region for peer analysis
-- Business Use: Referral programs and regional marketing campaigns


SELECT 
    -- First Customer
    c1.customer_id AS customer_1_id,
    c1.customer_name AS customer_1_name,
    c1.registration_date AS customer_1_reg_date,
    COUNT(DISTINCT o1.order_id) AS customer_1_orders,
    COALESCE(SUM(o1.total_amount), 0) AS customer_1_spending,
    
    -- Second Customer (for comparison)
    c2.customer_id AS customer_2_id,
    c2.customer_name AS customer_2_name,
    c2.registration_date AS customer_2_reg_date,
    COUNT(DISTINCT o2.order_id) AS customer_2_orders,
    COALESCE(SUM(o2.total_amount), 0) AS customer_2_spending,
    
    -- Regional Context
    c1.region AS shared_region,
    
    -- Comparison Metrics
    ABS(EXTRACT(DAY FROM c1.registration_date - c2.registration_date)) AS days_between_registration,
    ABS(COALESCE(SUM(o1.total_amount), 0) - COALESCE(SUM(o2.total_amount), 0)) AS spending_difference,
    
    -- Relationship Classification
    CASE 
        WHEN ABS(EXTRACT(DAY FROM c1.registration_date - c2.registration_date)) <= 7 
        THEN 'Registered same week - Potential referral'
        WHEN ABS(EXTRACT(DAY FROM c1.registration_date - c2.registration_date)) <= 30 
        THEN 'Registered same month'
        ELSE 'Different registration periods'
    END AS registration_relationship

FROM customers c1
-- Self join on same table to compare customers
INNER JOIN customers c2 
    ON c1.region = c2.region                    -- Must be in same region
    AND c1.customer_id < c2.customer_id         -- Avoid duplicate pairs and self-comparison

-- Join orders for first customer
LEFT JOIN orders o1 ON c1.customer_id = o1.customer_id
-- Join orders for second customer
LEFT JOIN orders o2 ON c2.customer_id = o2.customer_id

GROUP BY 
    c1.customer_id, c1.customer_name, c1.registration_date,
    c2.customer_id, c2.customer_name, c2.registration_date,
    c1.region

-- Focus on customers who registered close together
HAVING ABS(EXTRACT(DAY FROM c1.registration_date - c2.registration_date)) <= 30

ORDER BY 
    c1.region, 
    days_between_registration ASC,
    spending_difference DESC

LIMIT 25;

-- SELF JOIN Alternative: Same-Day Order Comparison

-- Purpose: Identify orders placed on the same date for pattern analysis
-- Business Use: Detect promotional effectiveness and unusual ordering patterns


SELECT 
    -- First Order
    o1.order_id AS order_1_id,
    c1.customer_name AS customer_1,
    c1.region AS region_1,
    o1.total_amount AS order_1_amount,
    
    -- Second Order (for comparison)
    o2.order_id AS order_2_id,
    c2.customer_name AS customer_2,
    c2.region AS region_2,
    o2.total_amount AS order_2_amount,
    
    -- Shared Context
    o1.order_date AS shared_order_date,
    
    -- Comparison Metrics
    ABS(o1.total_amount - o2.total_amount) AS amount_difference,
    (o1.total_amount + o2.total_amount) AS combined_order_value,
    
    -- Pattern Classification
    CASE 
        WHEN c1.region = c2.region THEN 'Same region - Possible local promotion'
        ELSE 'Different regions - Nationwide pattern'
    END AS pattern_type,
    
    CASE 
        WHEN ABS(o1.total_amount - o2.total_amount) < 50 THEN 'Similar order values'
        ELSE 'Different order values'
    END AS value_comparison

FROM orders o1
-- Self join to compare orders on same date
INNER JOIN orders o2 
    ON o1.order_date = o2.order_date           -- Same order date
    AND o1.order_id < o2.order_id              -- Avoid duplicates

-- Get customer information for both orders
INNER JOIN customers c1 ON o1.customer_id = c1.customer_id
INNER JOIN customers c2 ON o2.customer_id = c2.customer_id

-- Focus on recent orders for relevance
WHERE o1.order_date >= '2024-12-01'

ORDER BY 
    o1.order_date DESC, 
    combined_order_value DESC

LIMIT 20;

-- Test 1: INNER JOIN (should return many rows)
SELECT COUNT(*) FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN products p ON oi.product_id = p.product_id;

-- Test 2: LEFT JOIN (should return some rows with 0 orders)
SELECT COUNT(*) FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Test 3: RIGHT JOIN (should return products with 0 sales)
SELECT COUNT(*) FROM order_items oi
RIGHT JOIN products p ON oi.product_id = p.product_id
WHERE oi.order_item_id IS NULL;


-- RANKING FUNCTIONS: Regional Product Performance

-- Purpose: Identify top 5 products in each region using RANK()
-- Business Use: Regional inventory optimization


WITH regional_product_sales AS (
    SELECT 
        c.region,
        p.product_id,
        p.product_name,
        p.category,
        COUNT(DISTINCT o.order_id) AS times_ordered,
        SUM(oi.quantity) AS total_units_sold,
        SUM(oi.quantity * oi.price) AS total_revenue,
        
        -- RANK: Assigns rank with gaps for ties
        RANK() OVER (
            PARTITION BY c.region 
            ORDER BY SUM(oi.quantity * oi.price) DESC
        ) AS revenue_rank,
        
        -- DENSE_RANK: Assigns rank without gaps
        DENSE_RANK() OVER (
            PARTITION BY c.region 
            ORDER BY SUM(oi.quantity * oi.price) DESC
        ) AS dense_revenue_rank,
        
        -- ROW_NUMBER: Assigns unique sequential number
        ROW_NUMBER() OVER (
            PARTITION BY c.region 
            ORDER BY SUM(oi.quantity * oi.price) DESC
        ) AS row_num
        
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    JOIN products p ON oi.product_id = p.product_id
    
    GROUP BY c.region, p.product_id, p.product_name, p.category
)

SELECT 
    region,
    product_name,
    category,
    times_ordered,
    total_units_sold,
    ROUND(total_revenue, 2) AS total_revenue,
    revenue_rank,
    dense_revenue_rank,
    row_num,
    
    -- Classification based on rank
    CASE 
        WHEN revenue_rank <= 3 THEN ' Top 3 Product'
        WHEN revenue_rank <= 5 THEN ' Top 5 Product'
        ELSE 'Standard Product'
    END AS performance_tier
    
FROM regional_product_sales

-- Filter to show only top 5 per region
WHERE revenue_rank <= 5

ORDER BY region, revenue_rank


-- RANKING FUNCTIONS: Customer Value Analysis

-- Purpose: Rank all customers by total spending with percentile position
-- Business Use: VIP customer identification and tier assignment

WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.email,
        c.region,
        c.registration_date,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_spent,
        AVG(o.total_amount) AS avg_order_value,
        MAX(o.order_date) AS last_order_date
        
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    
    GROUP BY c.customer_id, c.customer_name, c.email, c.region, c.registration_date
)

SELECT 
    customer_id,
    customer_name,
    region,
    total_orders,
    ROUND(total_spent, 2) AS total_spent,
    ROUND(avg_order_value, 2) AS avg_order_value,
    last_order_date,
    
    -- ROW_NUMBER: Unique rank for each customer
    ROW_NUMBER() OVER (ORDER BY total_spent DESC) AS unique_rank,
    
    -- RANK: Rank with gaps when spending is tied
    RANK() OVER (ORDER BY total_spent DESC) AS spending_rank,
    
    -- DENSE_RANK: Rank without gaps
    DENSE_RANK() OVER (ORDER BY total_spent DESC) AS dense_rank,
    
    -- PERCENT_RANK: Relative position (0.0 to 1.0)
    ROUND(PERCENT_RANK() OVER (ORDER BY total_spent DESC)::numeric, 4) AS percentile_rank,
    
    -- Customer tier based on percentile
    CASE 
        WHEN PERCENT_RANK() OVER (ORDER BY total_spent DESC) <= 0.10 THEN 'Platinum - Top 10%'
        WHEN PERCENT_RANK() OVER (ORDER BY total_spent DESC) <= 0.25 THEN 'Gold - Top 25%'
        WHEN PERCENT_RANK() OVER (ORDER BY total_spent DESC) <= 0.50 THEN 'Silver - Top 50%'
        ELSE 'Bronze - Bottom 50%'
    END AS customer_tier

FROM customer_spending

ORDER BY total_spent DESC;



-- AGGREGATE WINDOW FUNCTIONS
-- SUM(), AVG(), MIN(), MAX() with ROWS and RANGE frames


-- Running Totals and Trends Analysis
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS month,
        TO_CHAR(order_date, 'YYYY-MM') AS month_label,
        SUM(total_amount) AS monthly_revenue
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date), TO_CHAR(order_date, 'YYYY-MM')
)
SELECT 
    month_label,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    
    -- ROWS FRAME: Running total (cumulative revenue)
    ROUND(SUM(monthly_revenue) OVER (
        ORDER BY month 
        ROWS UNBOUNDED PRECEDING
    ), 2) AS cumulative_revenue_rows,
    
    -- RANGE FRAME: Running total (same result but uses value ranges)
    ROUND(SUM(monthly_revenue) OVER (
        ORDER BY month 
        RANGE UNBOUNDED PRECEDING
    ), 2) AS cumulative_revenue_range,
    
    -- ROWS FRAME: 3-month moving average
    ROUND(AVG(monthly_revenue) OVER (
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_3month_rows,
    
    -- ROWS FRAME: MIN in 3-month window
    ROUND(MIN(monthly_revenue) OVER (
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS min_3month,
    
    -- ROWS FRAME: MAX in 3-month window
    ROUND(MAX(monthly_revenue) OVER (
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS max_3month,
    
    -- ROWS FRAME: Overall average for comparison
    ROUND(AVG(monthly_revenue) OVER (), 2) AS overall_avg

FROM monthly_sales
ORDER BY month;


-- AGGREGATE WINDOW FUNCTIONS: Moving Averages

-- Purpose: Calculate 3-month moving average to smooth trends
-- Business Use: Demand forecasting and inventory planning
-- Frame: ROWS BETWEEN 2 PRECEDING AND CURRENT ROW



WITH monthly_metrics AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS month,
        TO_CHAR(order_date, 'Month YYYY') AS month_name,
        COUNT(DISTINCT order_id) AS orders,
        SUM(total_amount) AS revenue
        
    FROM orders
    
    GROUP BY DATE_TRUNC('month', order_date), TO_CHAR(order_date, 'Month YYYY')
)

SELECT 
    month_name,
    orders,
    ROUND(revenue, 2) AS monthly_revenue,
    
    -- 3-month moving average (includes current + 2 previous months)
    ROUND(AVG(revenue) OVER (
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_3month,
    
    -- 2-month moving average
    ROUND(AVG(revenue) OVER (
        ORDER BY month 
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_2month,
    
    -- Moving MIN (lowest revenue in 3-month window)
    ROUND(MIN(revenue) OVER (
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS min_3month,
    
    -- Moving MAX (highest revenue in 3-month window)
    ROUND(MAX(revenue) OVER (
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS max_3month,
    
    -- Volatility indicator (range within 3-month window)
    ROUND(MAX(revenue) OVER (
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) - MIN(revenue) OVER (
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS revenue_volatility_3month

FROM monthly_metrics

ORDER BY month;


-- AGGREGATE WINDOW FUNCTIONS: Regional Analysis

-- Purpose: Compare each region's performance against regional averages
-- Business Use: Identify over/underperforming regions
-- Frame: RANGE (logical grouping by partition)



WITH regional_monthly_sales AS (
    SELECT 
        c.region,
        DATE_TRUNC('month', o.order_date) AS month,
        TO_CHAR(o.order_date, 'YYYY-MM') AS month_label,
        COUNT(DISTINCT o.order_id) AS orders,
        SUM(o.total_amount) AS revenue
        
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    
    GROUP BY c.region, DATE_TRUNC('month', o.order_date), TO_CHAR(o.order_date, 'YYYY-MM')
)

SELECT 
    region,
    month_label,
    orders,
    ROUND(revenue, 2) AS regional_revenue,
    
    -- Average revenue across all regions for this month (PARTITION BY month)
    ROUND(AVG(revenue) OVER (PARTITION BY month), 2) AS avg_all_regions,
    
    -- Variance from average
    ROUND(revenue - AVG(revenue) OVER (PARTITION BY month), 2) AS variance_from_avg,
    
    -- Percentage above/below average
    ROUND(100.0 * (revenue - AVG(revenue) OVER (PARTITION BY month)) / 
          NULLIF(AVG(revenue) OVER (PARTITION BY month), 0), 2) AS pct_vs_avg,
    
    -- Rank within the month
    RANK() OVER (PARTITION BY month ORDER BY revenue DESC) AS monthly_region_rank,
    
    -- Total revenue across all regions for comparison
    ROUND(SUM(revenue) OVER (PARTITION BY month), 2) AS total_all_regions,
    
    -- Regional contribution percentage
    ROUND(100.0 * revenue / SUM(revenue) OVER (PARTITION BY month), 2) AS contribution_pct,
    
    -- Performance classification
    CASE 
        WHEN revenue > AVG(revenue) OVER (PARTITION BY month) * 1.2 THEN '🔥 Well Above Average (+20%)'
        WHEN revenue > AVG(revenue) OVER (PARTITION BY month) THEN '✓ Above Average'
        WHEN revenue > AVG(revenue) OVER (PARTITION BY month) * 0.8 THEN '→ Near Average'
        ELSE '⚠ Below Average (-20%)'
    END AS performance_status

FROM regional_monthly_sales

ORDER BY month_label, revenue DESC;


-- NAVIGATION FUNCTIONS: Growth Rate Analysis

-- Purpose: Calculate month-over-month revenue changes
-- Business Use: Trend detection and early warning system
-- Functions: LAG() for previous period comparison



WITH monthly_performance AS (
    SELECT 
        DATE_TRUNC('month', order_date) AS month,
        TO_CHAR(order_date, 'Mon YYYY') AS month_label,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(total_amount) AS revenue
        
    FROM orders
    
    GROUP BY DATE_TRUNC('month', order_date), TO_CHAR(order_date, 'Mon YYYY')
)

SELECT 
    month_label,
    total_orders,
    ROUND(revenue, 2) AS current_month_revenue,
    
    -- Previous month's revenue using LAG()
    ROUND(LAG(revenue, 1) OVER (ORDER BY month), 2) AS previous_month_revenue,
    
    -- Revenue change (absolute)
    ROUND(revenue - LAG(revenue, 1) OVER (ORDER BY month), 2) AS revenue_change,
    
    -- Growth rate (percentage)
    ROUND(100.0 * (revenue - LAG(revenue, 1) OVER (ORDER BY month)) / 
          NULLIF(LAG(revenue, 1) OVER (ORDER BY month), 0), 2) AS growth_rate_pct,
    
    -- Previous month's order count
    LAG(total_orders, 1) OVER (ORDER BY month) AS previous_orders,
    
    -- Order growth
    total_orders - LAG(total_orders, 1) OVER (ORDER BY month) AS order_change,
    
    -- Trend indicator
    CASE 
        WHEN revenue > LAG(revenue, 1) OVER (ORDER BY month) * 1.1 THEN '📈 Strong Growth (+10%)'
        WHEN revenue > LAG(revenue, 1) OVER (ORDER BY month) THEN '✓ Growth'
        WHEN revenue >= LAG(revenue, 1) OVER (ORDER BY month) * 0.95 THEN '→ Stable'
        WHEN revenue >= LAG(revenue, 1) OVER (ORDER BY month) * 0.90 THEN '⚠ Slight Decline'
        ELSE 'Significant Decline (-10%+)'
    END AS trend_status,
    
    -- Comparison to 2 months ago
    ROUND(revenue - LAG(revenue, 2) OVER (ORDER BY month), 2) AS change_vs_2months_ago,
    
    -- Comparison to 3 months ago
    ROUND(revenue - LAG(revenue, 3) OVER (ORDER BY month), 2) AS change_vs_3months_ago

FROM monthly_performance

ORDER BY month;


-- NAVIGATION FUNCTIONS: Customer Behavior Patterns

-- Purpose: Analyze time between customer purchases
-- Business Use: Churn prediction and re-engagement timing
-- Functions: LAG() for previous purchase date




WITH customer_orders AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.region,
        o.order_id,
        o.order_date,
        o.total_amount,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS order_sequence
        
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
)

SELECT 
    customer_id,
    customer_name,
    region,
    order_sequence,
    order_date AS current_order_date,
    ROUND(total_amount, 2) AS current_order_amount,
    
    -- Previous order date using LAG()
    LAG(order_date, 1) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS previous_order_date,
    
    -- Days between orders
    order_date - LAG(order_date, 1) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS days_since_last_order,
    
    -- Previous order amount
    ROUND(LAG(total_amount, 1) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ), 2) AS previous_order_amount,
    
    -- Order value change
    ROUND(total_amount - LAG(total_amount, 1) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ), 2) AS order_value_change,
    
    -- Average days between purchases (for this customer)
    ROUND(AVG(order_date - LAG(order_date, 1) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    )) OVER (PARTITION BY customer_id), 1) AS avg_days_between_orders,
    
    -- Purchase frequency classification
    CASE 
        WHEN order_date - LAG(order_date, 1) OVER (
            PARTITION BY customer_id ORDER BY order_date
        ) <= 30 THEN 'Frequent Buyer (< 30 days)'
        WHEN order_date - LAG(order_date, 1) OVER (
            PARTITION BY customer_id ORDER BY order_date
        ) <= 60 THEN 'Regular Buyer (30-60 days)'
        WHEN order_date - LAG(order_date, 1) OVER (
            PARTITION BY customer_id ORDER BY order_date
        ) <= 90 THEN 'Occasional Buyer (60-90 days)'
        WHEN order_date - LAG(order_date, 1) OVER (
            PARTITION BY customer_id ORDER BY order_date
        ) IS NOT NULL THEN 'At Risk (90+ days)'
        ELSE 'First Purchase'
    END AS customer_behavior

FROM customer_orders

ORDER BY customer_name, order_date;


-- NAVIGATION FUNCTIONS: Forward-Looking Analysis

-- Purpose: Analyze price trends and anticipate future changes
-- Business Use: Pricing strategy and margin optimization
-- Functions: LEAD() to look ahead to next period



WITH product_monthly_pricing AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category,
        DATE_TRUNC('month', o.order_date) AS month,
        TO_CHAR(o.order_date, 'YYYY-MM') AS month_label,
        AVG(oi.price) AS avg_selling_price,
        MIN(oi.price) AS min_price,
        MAX(oi.price) AS max_price,
        COUNT(*) AS times_sold
        
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o ON oi.order_id = o.order_id
    
    GROUP BY p.product_id, p.product_name, p.category, DATE_TRUNC('month', o.order_date), TO_CHAR(o.order_date, 'YYYY-MM')
)

SELECT 
    product_name,
    category,
    month_label,
    ROUND(avg_selling_price, 2) AS current_avg_price,
    
    -- Previous month's price using LAG()
    ROUND(LAG(avg_selling_price, 1) OVER (
        PARTITION BY product_id 
        ORDER BY month
    ), 2) AS previous_month_price,
    
    -- Next month's price using LEAD()
    ROUND(LEAD(avg_selling_price, 1) OVER (
        PARTITION BY product_id 
        ORDER BY month
    ), 2) AS next_month_price,
    
    -- Price change from previous month
    ROUND(avg_selling_price - LAG(avg_selling_price, 1) OVER (
        PARTITION BY product_id 
        ORDER BY month
    ), 2) AS price_change_from_prev,
    
    -- Price change to next month
    ROUND(LEAD(avg_selling_price, 1) OVER (
        PARTITION BY product_id 
        ORDER BY month
    ) - avg_selling_price, 2) AS price_change_to_next,
    
    -- Price volatility (max - min)
    ROUND(max_price - min_price, 2) AS monthly_price_range,
    
    times_sold,
    
    -- Pricing trend indicator
    CASE 
        WHEN avg_selling_price > LAG(avg_selling_price, 1) OVER (
            PARTITION BY product_id ORDER BY month
        ) THEN '↑ Price Increasing'
        WHEN avg_selling_price < LAG(avg_selling_price, 1) OVER (
            PARTITION BY product_id ORDER BY month
        ) THEN '↓ Price Decreasing'
        ELSE '→ Price Stable'
    END AS price_trend

FROM product_monthly_pricing

ORDER BY product_name, month;


-- DISTRIBUTION FUNCTIONS: Customer Quartile Segmentation

-- Purpose: Divide customers into 4 equal tiers by spending
-- Business Use: Personalized marketing and loyalty programs
-- Functions: NTILE(4) for quartile assignment



WITH customer_metrics AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.email,
        c.region,
        c.registration_date,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_spent,
        AVG(o.total_amount) AS avg_order_value,
        MAX(o.order_date) AS last_order_date,
        MIN(o.order_date) AS first_order_date
        
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    
    GROUP BY c.customer_id, c.customer_name, c.email, c.region, c.registration_date
)

SELECT 
    customer_id,
    customer_name,
    region,
    total_orders,
    ROUND(total_spent, 2) AS total_spent,
    ROUND(avg_order_value, 2) AS avg_order_value,
    last_order_date,
    
    -- Divide customers into 4 equal quartiles (25% each)
    NTILE(4) OVER (ORDER BY total_spent DESC) AS spending_quartile,
    
    -- Customer tier based on quartile
    CASE NTILE(4) OVER (ORDER BY total_spent DESC)
        WHEN 1 THEN 'Q1 - Platinum (Top 25%)'
        WHEN 2 THEN 'Q2 - Gold (26-50%)'
        WHEN 3 THEN 'Q3 - Silver (51-75%)'
        WHEN 4 THEN 'Q4 - Bronze (Bottom 25%)'
    END AS customer_tier,
    
    -- Marketing action recommendation
    CASE NTILE(4) OVER (ORDER BY total_spent DESC)
        WHEN 1 THEN 'VIP Treatment: Dedicated account manager, exclusive previews'
        WHEN 2 THEN 'Premium Program: Early access, special discounts'
        WHEN 3 THEN 'Loyalty Rewards: Points program, occasional promotions'
        WHEN 4 THEN 'Activation Campaign: Incentives to increase engagement'
    END AS recommended_strategy,
    
    -- Regional quartile (quartile within their region)
    NTILE(4) OVER (
        PARTITION BY region 
        ORDER BY total_spent DESC
    ) AS regional_quartile,
    
    -- Days since last purchase
    CURRENT_DATE - last_order_date AS days_since_last_order,
    
    -- Customer lifetime in days
    CURRENT_DATE - first_order_date AS customer_lifetime_days

FROM customer_metrics

ORDER BY total_spent DESC;


-- DISTRIBUTION FUNCTIONS: Percentile Analysis

-- Purpose: Show exact percentile position of each customer
-- Business Use: Granular customer ranking and performance metrics
-- Functions: CUME_DIST() for cumulative distribution


WITH customer_spending AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.region,
        COUNT(DISTINCT o.order_id) AS order_count,
        SUM(o.total_amount) AS total_revenue
        
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    
    GROUP BY c.customer_id, c.customer_name, c.region
)

SELECT 
    customer_name,
    region,
    order_count,
    ROUND(total_revenue, 2) AS total_revenue,
    
    -- Cumulative distribution (0.0 to 1.0)
    ROUND(CUME_DIST() OVER (ORDER BY total_revenue)::numeric, 4) AS cumulative_dist,
    
    -- Convert to percentile (0 to 100)
    ROUND(100 * CUME_DIST() OVER (ORDER BY total_revenue)::numeric, 2) AS percentile,
    
    -- Distribution group
    CASE 
        WHEN CUME_DIST() OVER (ORDER BY total_revenue) >= 0.95 THEN 'Top 5% Elite'
        WHEN CUME_DIST() OVER (ORDER BY total_revenue) >= 0.90 THEN 'Top 10% Excellent'
        WHEN CUME_DIST() OVER (ORDER BY total_revenue) >= 0.75 THEN 'Top 25% Very Good'
        WHEN CUME_DIST() OVER (ORDER BY total_revenue) >= 0.50 THEN 'Top 50% Good'
        ELSE 'Bottom 50%'
    END AS performance_band,
    
    -- Regional cumulative distribution
    ROUND(CUME_DIST() OVER (
        PARTITION BY region 
        ORDER BY total_revenue
    )::numeric, 4) AS regional_cumulative_dist,
    
    -- Regional percentile
    ROUND(100 * CUME_DIST() OVER (
        PARTITION BY region 
        ORDER BY total_revenue
    )::numeric, 2) AS regional_percentile,
    
    -- Ranking for context
    RANK() OVER (ORDER BY total_revenue DESC) AS overall_rank,
    COUNT(*) OVER () AS total_customers

FROM customer_spending

ORDER BY total_revenue DESC;


-- DISTRIBUTION FUNCTIONS: Product Portfolio Analysis

-- Purpose: Segment products by revenue contribution (80/20 rule)
-- Business Use: Inventory optimization and SKU rationalization
-- Functions: NTILE() and CUME_DIST() for product classification


WITH product_performance AS (
    SELECT 
        p.product_id,
        p.product_name,
        p.category,
        p.unit_price,
        p.stock_quantity,
        COUNT(DISTINCT oi.order_id) AS times_ordered,
        COALESCE(SUM(oi.quantity), 0) AS total_units_sold,
        COALESCE(SUM(oi.quantity * oi.price), 0) AS total_revenue
        
    FROM products p
    LEFT JOIN order_items oi ON p.product_id = oi.product_id
    
    GROUP BY p.product_id, p.product_name, p.category, p.unit_price, p.stock_quantity
),
product_with_windows AS (
    SELECT 
        product_name,
        category,
        unit_price,
        stock_quantity,
        times_ordered,
        total_units_sold,
        total_revenue,
        NTILE(5) OVER (ORDER BY total_revenue DESC) AS revenue_quintile,
        CUME_DIST() OVER (ORDER BY total_revenue DESC) AS cumulative_dist,
        SUM(total_revenue) OVER () AS grand_total_revenue
        
    FROM product_performance
)
SELECT 
    product_name,
    category,
    ROUND(unit_price, 2) AS list_price,
    stock_quantity,
    times_ordered,
    total_units_sold,
    ROUND(total_revenue, 2) AS total_revenue,
    revenue_quintile,
    
    CASE revenue_quintile
        WHEN 1 THEN 'Star Products - Top 20%'
        WHEN 2 THEN 'Strong Performers - 21-40%'
        WHEN 3 THEN 'Average Performers - 41-60%'
        WHEN 4 THEN 'Weak Performers - 61-80%'
        WHEN 5 THEN 'Consider Discontinuation - Bottom 20%'
    END AS product_classification,
    
    ROUND(100 * cumulative_dist::numeric, 2) AS cumulative_pct,
    ROUND(100.0 * total_revenue / NULLIF(grand_total_revenue, 0), 2) AS pct_of_total_revenue,
    
    CASE 
        WHEN times_ordered = 0 THEN 'Never sold - Discontinue'
        WHEN revenue_quintile = 1 THEN 'Increase stock and feature'
        WHEN revenue_quintile = 2 THEN 'Maintain current strategy'
        WHEN revenue_quintile <= 4 THEN 'Review pricing'
        ELSE 'Phase out or discount'
    END AS strategic_action

FROM product_with_windows

ORDER BY total_revenue DESC;

-- DISTRIBUTION FUNCTIONS: Cross-Regional Analysis

-- Purpose: Compare customer distributions across regions
-- Business Use: Regional equity and resource allocation
-- Functions: NTILE() with regional partitioning



WITH regional_customers AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.region,
        COUNT(DISTINCT o.order_id) AS orders,
        SUM(o.total_amount) AS revenue
        
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    
    GROUP BY c.customer_id, c.customer_name, c.region
)

SELECT 
    region,
    customer_name,
    orders,
    ROUND(revenue, 2) AS total_revenue,
    
    -- Overall quartile (across all regions)
    NTILE(4) OVER (ORDER BY revenue DESC) AS overall_quartile,
    
    -- Regional quartile (within each region)
    NTILE(4) OVER (
        PARTITION BY region 
        ORDER BY revenue DESC
    ) AS regional_quartile,
    
    -- Overall tier
    CASE NTILE(4) OVER (ORDER BY revenue DESC)
        WHEN 1 THEN 'National VIP'
        WHEN 2 THEN 'National Premium'
        WHEN 3 THEN 'National Standard'
        WHEN 4 THEN 'National Basic'
    END AS overall_tier,
    
    -- Regional tier
    CASE NTILE(4) OVER (PARTITION BY region ORDER BY revenue DESC)
        WHEN 1 THEN 'Regional Leader'
        WHEN 2 THEN 'Regional Star'
        WHEN 3 THEN 'Regional Regular'
        WHEN 4 THEN 'Regional Opportunity'
    END AS regional_tier,
    
    -- Regional rank
    RANK() OVER (
        PARTITION BY region 
        ORDER BY revenue DESC
    ) AS rank_in_region,
    
    -- Total customers in region
    COUNT(*) OVER (PARTITION BY region) AS total_in_region

FROM regional_customers

ORDER BY region, revenue DESC;


-- VALIDATION QUERIES (Test All Window Functions Work)

-- Test 1: Ranking functions work
SELECT 
    customer_id, 
    total_amount,
    RANK() OVER (ORDER BY total_amount DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY total_amount DESC) AS dense_rank,
    ROW_NUMBER() OVER (ORDER BY total_amount DESC) AS row_num
FROM (
    SELECT customer_id, SUM(total_amount) AS total_amount 
    FROM orders 
    GROUP BY customer_id
) AS customer_totals
LIMIT 10;

-- Test 2: Aggregate windows work
SELECT 
    month, 
    revenue,
    SUM(revenue) OVER (ORDER BY month) AS cumulative_revenue,
    AVG(revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM (
    SELECT 
        DATE_TRUNC('month', order_date) AS month, 
        SUM(total_amount) AS revenue 
    FROM orders 
    GROUP BY DATE_TRUNC('month', order_date)
) AS monthly_revenue
ORDER BY month;

-- Test 3: Navigation functions work
SELECT 
    month, 
    revenue,
    LAG(revenue, 1) OVER (ORDER BY month) AS prev_month,
    LEAD(revenue, 1) OVER (ORDER BY month) AS next_month
FROM (
    SELECT 
        DATE_TRUNC('month', order_date) AS month, 
        SUM(total_amount) AS revenue 
    FROM orders 
    GROUP BY DATE_TRUNC('month', order_date)
) AS monthly_revenue
ORDER BY month;

-- Test 4: Distribution functions work
SELECT 
    customer_id, 
    revenue,
    NTILE(4) OVER (ORDER BY revenue DESC) AS quartile,
    ROUND(CUME_DIST() OVER (ORDER BY revenue DESC)::numeric, 4) AS percentile
FROM (
    SELECT customer_id, SUM(total_amount) AS revenue 
    FROM orders 
    GROUP BY customer_id
) AS customer_revenue
ORDER BY revenue DESC
LIMIT 10;

-- Test 5: Verify all tables have data
SELECT 
    'Customers' AS table_name, COUNT(*) AS record_count FROM customers
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Orders', COUNT(*) FROM orders
UNION ALL
SELECT 'Order Items', COUNT(*) FROM order_items;

