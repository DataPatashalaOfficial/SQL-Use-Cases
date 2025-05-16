# 50 Medium to High-Level SQL Interview Questions (Sample Data and Questions Only)

## Question 1
**Sample Data**  
Table: `sales`  
| sale_id | rep_id | sale_amount | sale_date  |
|---------|--------|-------------|------------|
| 1       | 101    | 5000.00     | 2025-01-15 |
| 2       | 102    | 3000.00     | 2025-01-20 |
| 3       | 101    | 2000.00     | 2025-02-10 |
| 4       | 103    | 4000.00     | 2025-02-15 |
| 5       | 102    | 6000.00     | 2025-01-25 |

**Question**  
Write a query to find the top 2 sales reps in terms of total sales amount for each month.

---

## Question 2
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary | hire_date  |
|--------|----------|---------|--------|------------|
| 1      | Alice    | 10      | 60000  | 2023-05-01 |
| 2      | Bob      | 10      | 65000  | 2022-03-15 |
| 3      | Charlie  | 20      | 70000  | 2024-01-10 |
| 4      | David    | 20      | 62000  | 2023-07-20 |

**Question**  
Write a query to find employees who earn more than the average salary of their department.

---

## Question 3
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find customers who placed orders in consecutive months.

---

## Question 4
**Sample Data**  
Table: `products`  
| product_id | product_name | category | price |
|------------|--------------|----------|-------|
| 1          | Laptop       | Tech     | 1000  |
| 2          | Phone        | Tech     | 600   |
| 3          | Shirt        | Apparel  | 30    |
| 4          | Jacket       | Apparel  | 80    |

**Question**  
Write a query to find the top 1 product by price in each category.

---

## Question 5
**Sample Data**  
Table: `transactions`  
| trans_id | account_id | trans_date | amount | type |
|----------|------------|------------|--------|------|
| 1        | 301        | 2025-01-05 | 500    | D    |
| 2        | 301        | 2025-01-06 | 200    | W    |
| 3        | 302        | 2025-01-07 | 300    | D    |
| 4        | 301        | 2025-01-08 | 100    | W    |

**Question**  
Write a query to calculate the running balance for each account after each transaction (D = Deposit, W = Withdrawal).

---

## Question 6
**Sample Data**  
Table: `students`  
| student_id | course_id | grade |
|------------|-----------|-------|
| 1          | 101       | 85    |
| 1          | 102       | 90    |
| 2          | 101       | 78    |
| 2          | 103       | 92    |

**Question**  
Write a query to find students who have an average grade above 85 across all their courses.

---

## Question 7
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | manager_id |
|--------|----------|------------|
| 1      | Alice    | NULL       |
| 2      | Bob      | 1          |
| 3      | Charlie  | 1          |
| 4      | David    | 2          |

**Question**  
Write a query to list each employee and their manager’s name (self-join).

---

## Question 8
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-01-15 | NULL   |
| 3        | 202        | 2025-02-20 | 200    |
| 4        | 203        | 2025-03-05 | NULL   |

**Question**  
Write a query to replace NULL amounts with the average amount of non-NULL orders.

---

## Question 9
**Sample Data**  
Table: `logs`  
| log_id | action | log_time            |
|--------|--------|---------------------|
| 1      | Login  | 2025-01-10 08:00:00 |
| 2      | Logout | 2025-01-10 08:30:00 |
| 3      | Login  | 2025-01-10 09:00:00 |
| 4      | Logout | 2025-01-10 09:45:00 |

**Question**  
Write a query to calculate the total session time (from Login to Logout) for each session.

---

## Question 10
**Sample Data**  
Table: `inventory`  
| product_id | warehouse_id | quantity |
|------------|--------------|----------|
| 1          | 1001         | 50       |
| 1          | 1002         | 30       |
| 2          | 1001         | 20       |
| 2          | 1003         | 40       |

**Question**  
Write a query to find products that are stored in multiple warehouses.

---

## Question 11
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary | hire_date  |
|--------|----------|---------|--------|------------|
| 1      | Alice    | 10      | 60000  | 2023-05-01 |
| 2      | Bob      | 10      | 60000  | 2022-03-15 |
| 3      | Charlie  | 20      | 70000  | 2024-01-10 |
| 4      | David    | 20      | 70000  | 2023-07-20 |

**Question**  
Write a query to find employees with the same salary within the same department.

---

## Question 12
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | status |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | Shipped|
| 2        | 201        | 2025-02-15 | Pending|
| 3        | 202        | 2025-01-20 | Shipped|
| 4        | 203        | 2025-03-05 | Pending|

**Question**  
Write a query to find customers who have both ‘Shipped’ and ‘Pending’ orders.

---

## Question 13
**Sample Data**  
Table: `calls`  
| call_id | caller_id | receiver_id | call_duration |
|---------|-----------|-------------|---------------|
| 1       | 401       | 402         | 300           |
| 2       | 402       | 401         | 200           |
| 3       | 401       | 403         | 500           |
| 4       | 403       | 402         | 100           |

**Question**  
Write a query to calculate the total call duration between each pair of users (