Here are 35   queries designed for Inventory Management using the datasets you provided, ranging from beginner to advanced levels. These queries will cover a variety of tasks including stock monitoring, supplier management, profit analysis, inventory forecasting, and more.

Beginner Level Queries:
Query 1: Display all product information

SELECT * FROM product_information;

Query 2: List all products in the 'Electronics' category

SELECT Product_ID, Product_Name, Category
FROM product_information
WHERE Category = 'Electronics';

Query 3: Find all products that are below the reorder level

SELECT Product_ID, Product_Name, Stock_Level, Reorder_Level
FROM product_information
WHERE Stock_Level < Reorder_Level;

Query 4: Count how many suppliers are available

SELECT COUNT(*) AS total_suppliers
FROM supplier_information;

Query 5: List the top 10 products with the highest price

SELECT Product_ID, Product_Name, Price
FROM product_information
ORDER BY Price DESC
LIMIT 10;

Query 6: Retrieve all transactions for a specific product

SELECT * 
FROM stock_transactions
WHERE Product_ID = 'P1001';

Query 7: Count how many 'Stock In' and 'Stock Out' transactions have occurred

SELECT Transaction_Type, COUNT(*) AS transaction_count
FROM stock_transactions
GROUP BY Transaction_Type;

Query 8: Get all suppliers based in New York

SELECT Supplier_ID, Supplier_Name, Location
FROM supplier_information
WHERE Location LIKE '%New York%';

Query 9: Display total stock received for each product

SELECT Product_ID, SUM(Quantity) AS total_stock_received
FROM stock_transactions
WHERE Transaction_Type = 'Stock In'
GROUP BY Product_ID;

Query 10: Show all products with a stock level of more than 500

SELECT Product_ID, Product_Name, Stock_Level
FROM product_information
WHERE Stock_Level > 500;
Intermediate Level Queries:

Query 11: Retrieve all products and their corresponding suppliers

SELECT p.Product_ID, p.Product_Name, s.Supplier_Name
FROM product_information p
JOIN supplier_information s ON p.Supplier_ID = s.Supplier_ID;

Query 12: Calculate the profit margin for each product (Price - Cost)

SELECT Product_ID, Product_Name, (Price - Cost) AS profit_margin
FROM product_information;

Query 13: Get the average stock level per category

SELECT Category, AVG(Stock_Level) AS avg_stock_level
FROM product_information
GROUP BY Category;

Query 14: List the 5 products with the highest stock turnover (Stock Out transactions)

SELECT Product_ID, SUM(Quantity) AS total_stock_out
FROM stock_transactions
WHERE Transaction_Type = 'Stock Out'
GROUP BY Product_ID
ORDER BY total_stock_out DESC
LIMIT 5;

Query 15: Calculate the total stock cost (Cost * Quantity) for each product in stock

SELECT Product_ID, SUM(Cost * Stock_Level) AS total_stock_value
FROM product_information
GROUP BY Product_ID;

Query 16: Retrieve the total number of transactions that occurred last month

SELECT COUNT(*) AS total_transactions
FROM stock_transactions
WHERE Transaction_Date BETWEEN CURDATE() - INTERVAL 1 MONTH AND CURDATE();

Query 17: List all products with stock levels below 50 and order them by lowest stock first
 
SELECT Product_ID, Product_Name, Stock_Level
FROM product_information
WHERE Stock_Level < 50
ORDER BY Stock_Level ASC;

Query 18: Find the total number of products in each category
 
SELECT Category, COUNT(Product_ID) AS product_count
FROM product_information
GROUP BY Category;

Query 19: Calculate the total value of stock received from each supplier (Stock In transactions only)

SELECT s.Supplier_Name, SUM(t.Quantity * p.Cost) AS total_value
FROM stock_transactions t
JOIN product_information p ON t.Product_ID = p.Product_ID
JOIN supplier_information s ON t.Supplier_ID = s.Supplier_ID
WHERE t.Transaction_Type = 'Stock In'
GROUP BY s.Supplier_Name;

Query 20: Identify all products that have not had any "Stock In" transactions in the past 6 months
 
SELECT p.Product_ID, p.Product_Name
FROM product_information p
WHERE NOT EXISTS (
    SELECT 1
    FROM stock_transactions t
    WHERE t.Product_ID = p.Product_ID
    AND t.Transaction_Type = 'Stock In'
    AND t.Transaction_Date >= CURDATE() - INTERVAL 6 MONTH
);

Advanced Level Queries:

Query 21: Calculate the average profit margin across all products

SELECT AVG(Price - Cost) AS avg_profit_margin
FROM product_information;

Query 22: Find the suppliers that provide the most products (by product count)

SELECT s.Supplier_Name, COUNT(p.Product_ID) AS product_count
FROM supplier_information s
JOIN product_information p ON s.Supplier_ID = p.Supplier_ID
GROUP BY s.Supplier_Name
ORDER BY product_count DESC;

Query 23: Identify the top 3 suppliers based on total stock received

SELECT s.Supplier_Name, SUM(t.Quantity) AS total_stock_received
FROM stock_transactions t
JOIN supplier_information s ON t.Supplier_ID = s.Supplier_ID
WHERE t.Transaction_Type = 'Stock In'
GROUP BY s.Supplier_Name
ORDER BY total_stock_received DESC
LIMIT 3;

Query 24: Calculate the overall stock turnover rate (Stock Out transactions per product)

SELECT Product_ID, SUM(CASE WHEN Transaction_Type = 'Stock Out' THEN Quantity ELSE 0 END) / 
                 SUM(CASE WHEN Transaction_Type = 'Stock In' THEN Quantity ELSE 0 END) AS turnover_rate
FROM stock_transactions
GROUP BY Product_ID;

Query 25: Retrieve all suppliers that provided stock in the last 30 days

SELECT DISTINCT s.Supplier_Name
FROM supplier_information s
JOIN stock_transactions t ON s.Supplier_ID = t.Supplier_ID
WHERE t.Transaction_Type = 'Stock In'
AND t.Transaction_Date >= CURDATE() - INTERVAL 30 DAY;

Query 26: Calculate the reorder frequency for each product (number of Stock In transactions)

SELECT Product_ID, COUNT(*) AS reorder_frequency
FROM stock_transactions
WHERE Transaction_Type = 'Stock In'
GROUP BY Product_ID
ORDER BY reorder_frequency DESC;

Query 27: Calculate the total revenue from products sold (Price * Stock Out Quantity)

SELECT p.Product_ID, SUM(p.Price * t.Quantity) AS total_revenue
FROM product_information p
JOIN stock_transactions t ON p.Product_ID = t.Product_ID
WHERE t.Transaction_Type = 'Stock Out'
GROUP BY p.Product_ID;

Query 28: Find the products with the highest profit margin over the last 3 months

SELECT p.Product_ID, p.Product_Name, (p.Price - p.Cost) AS profit_margin
FROM product_information p
JOIN stock_transactions t ON p.Product_ID = t.Product_ID
WHERE t.Transaction_Date >= CURDATE() - INTERVAL 3 MONTH
GROUP BY p.Product_ID, p.Product_Name
ORDER BY profit_margin DESC
LIMIT 5;

Query 29: Retrieve products where the stock level is expected to drop below the reorder level in the next 30 days

SELECT Product_ID, Product_Name, Stock_Level, Reorder_Level
FROM product_information
WHERE Stock_Level < Reorder_Level
AND Stock_Level / (SELECT AVG(Quantity) 
                   FROM stock_transactions 
                   WHERE Product_ID = product_information.Product_ID 
                   AND Transaction_Type = 'Stock Out') < 30;

Query 30: Calculate the total inventory value (Price * Stock_Level) by category

SELECT Category, SUM(Price * Stock_Level) AS total_inventory_value
FROM product_information
GROUP BY Category;
Expert Level Queries:

Query 31: Rank products based on their profitability (Price - Cost)

SELECT Product_ID, Product_Name, (Price - Cost) AS profit_margin
FROM product_information
ORDER BY profit_margin DESC;

Query 32: Find the total quantity of stock that was ordered but never received (Stock In transactions)

SELECT Supplier_ID, COUNT(*) AS undelivered_orders
FROM stock_transactions
WHERE Transaction_Type = 'Stock In'
AND Quantity = 0
GROUP BY Supplier_ID;

Query 33: Forecast inventory needs by calculating average daily sales (Stock Out transactions) for each product

SELECT Product_ID, AVG(Quantity) AS avg_daily_sales
FROM stock_transactions
WHERE Transaction_Type = 'Stock Out'
GROUP BY Product_ID;

Query 34: Identify products with low inventory but high sales in the last 30 days

SELECT p.Product_ID, p.Product_Name, p.Stock_Level, SUM(t.Quantity) AS total_sales
FROM product_information p
JOIN stock_transactions t ON p.Product_ID = t.Product_ID
WHERE t.Transaction_Type = 'Stock Out'
AND t.Transaction_Date >= CURDATE() - INTERVAL 30 DAY
GROUP BY p.Product_ID, p.Product_Name, p.Stock_Level
HAVING p.Stock_Level < 50
ORDER BY total_sales DESC;

Query 35: Find suppliers that have delivered more stock than ordered (Supplier error)

SELECT s.Supplier_ID, s.Supplier_Name, SUM(t.Quantity) AS delivered_quantity, p.Reorder_Level
FROM stock_transactions t
JOIN supplier_information s ON t.Supplier_ID = s.Supplier_ID
JOIN product_information p ON t.Product_ID = p.Product_ID
WHERE t.Transaction_Type = 'Stock In'
GROUP BY s.Supplier_ID, s.Supplier_Name, p.Reorder_Level
HAVING delivered_quantity > p.Reorder_Level;
