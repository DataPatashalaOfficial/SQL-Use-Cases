# SQL Capstone Project 2

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

**Answer**  
```sql
WITH MonthlySales AS (
    SELECT 
        rep_id,
        DATE_TRUNC('month', sale_date) AS sale_month,
        SUM(sale_amount) AS total_sales,
        RANK() OVER (
            PARTITION BY DATE_TRUNC('month', sale_date) 
            ORDER BY SUM(sale_amount) DESC
        ) AS sales_rank
    FROM sales
    GROUP BY rep_id, DATE_TRUNC('month', sale_date)
)
SELECT 
    rep_id,
    sale_month,
    total_sales
FROM MonthlySales
WHERE sales_rank <= 2
ORDER BY sale_month, total_sales DESC;
```

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

**Answer**  
```sql
WITH DeptAvg AS (
    SELECT 
        dept_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept_id
)
SELECT 
    e.emp_id,
    e.emp_name,
    e.dept_id,
    e.salary,
    d.avg_salary
FROM employees e
JOIN DeptAvg d ON e.dept_id = d.dept_id
WHERE e.salary > d.avg_salary
ORDER BY e.dept_id, e.salary;
```

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

**Answer**  
```sql
WITH MonthlyOrders AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', order_date) AS order_month,
        LAG(DATE_TRUNC('month', order_date)) OVER (
            PARTITION BY customer_id 
            ORDER BY DATE_TRUNC('month', order_date)
        ) AS prev_month
    FROM orders
)
SELECT DISTINCT customer_id
FROM MonthlyOrders
WHERE prev_month IS NOT NULL
AND order_month = prev_month + INTERVAL '1 month'
ORDER BY customer_id;
```

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

**Answer**  
```sql
WITH RankedProducts AS (
    SELECT 
        product_id,
        product_name,
        category,
        price,
        RANK() OVER (
            PARTITION BY category 
            ORDER BY price DESC
        ) AS price_rank
    FROM products
)
SELECT 
    product_id,
    product_name,
    category,
    price
FROM RankedProducts
WHERE price_rank = 1
ORDER BY category;
```

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

**Answer**  
```sql
SELECT 
    trans_id,
    account_id,
    trans_date,
    amount,
    type,
    SUM(CASE 
            WHEN type = 'D' THEN amount 
            WHEN type = 'W' THEN -amount 
        END) OVER (
        PARTITION BY account_id 
        ORDER BY trans_date, trans_id
    ) AS running_balance
FROM transactions
ORDER BY account_id, trans_date, trans_id;
```

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

**Answer**  
```sql
SELECT 
    student_id,
    AVG(grade) AS avg_grade
FROM students
GROUP BY student_id
HAVING AVG(grade) > 85
ORDER BY student_id;
```

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

**Answer**  
```sql
SELECT 
    e.emp_id,
    e.emp_name AS employee_name,
    m.emp_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id
ORDER BY e.emp_id;
```

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

**Answer**  
```sql
WITH AvgAmount AS (
    SELECT AVG(amount) AS avg_amount
    FROM orders
    WHERE amount IS NOT NULL
)
SELECT 
    order_id,
    customer_id,
    order_date,
    COALESCE(amount, (SELECT avg_amount FROM AvgAmount)) AS amount
FROM orders
ORDER BY order_id;
```

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

**Answer**  
```sql
WITH PairedLogs AS (
    SELECT 
        l1.log_id AS login_id,
        l1.log_time AS login_time,
        MIN(l2.log_time) AS logout_time
    FROM logs l1
    LEFT JOIN logs l2 ON l2.action = 'Logout' AND l2.log_time > l1.log_time
    WHERE l1.action = 'Login'
    GROUP BY l1.log_id, l1.log_time
)
SELECT 
    login_id,
    login_time,
    logout_time,
    EXTRACT(EPOCH FROM (logout_time - login_time))/60 AS session_minutes
FROM PairedLogs
WHERE logout_time IS NOT NULL
ORDER BY login_id;
```

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

**Answer**  
```sql
SELECT 
    product_id,
    COUNT(warehouse_id) AS warehouse_count
FROM inventory
GROUP BY product_id
HAVING COUNT(warehouse_id) > 1
ORDER BY product_id;
```

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

**Answer**  
```sql
SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.dept_id,
    e1.salary
FROM employees e1
JOIN employees e2 ON e1.dept_id = e2.dept_id AND e1.salary = e2.salary AND e1.emp_id != e2.emp_id
ORDER BY e1.dept_id, e1.salary, e1.emp_id;
```

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

**Answer**  
```sql
SELECT customer_id
FROM orders
WHERE status IN ('Shipped', 'Pending')
GROUP BY customer_id
HAVING COUNT(DISTINCT status) = 2
ORDER BY customer_id;
```

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
Write a query to calculate the total call duration between each pair of users (ignoring who initiated the call).

**Answer**  
```sql
SELECT 
    LEAST(caller_id, receiver_id) AS user1,
    GREATEST(caller_id, receiver_id) AS user2,
    SUM(call_duration) AS total_duration
FROM calls
GROUP BY LEAST(caller_id, receiver_id), GREATEST(caller_id, receiver_id)
ORDER BY user1, user2;
```

---

## Question 14
**Sample Data**  
Table: `projects`  
| project_id | emp_id | start_date | end_date   |
|------------|--------|------------|------------|
| 1          | 501    | 2025-01-01 | 2025-03-01 |
| 2          | 501    | 2025-02-15 | 2025-04-15 |
| 3          | 502    | 2025-01-10 | 2025-02-10 |
| 4          | 502    | 2025-03-01 | NULL       |

**Question**  
Write a query to find employees who worked on overlapping projects.

**Answer**  
```sql
SELECT DISTINCT 
    p1.emp_id,
    p1.project_id AS project1,
    p2.project_id AS project2
FROM projects p1
JOIN projects p2 
    ON p1.emp_id = p2.emp_id 
    AND p1.project_id < p2.project_id
WHERE p1.start_date <= COALESCE(p2.end_date, CURRENT_DATE)
AND p2.start_date <= COALESCE(p1.end_date, CURRENT_DATE)
ORDER BY p1.emp_id, p1.project_id;
```

---

## Question 15
**Sample Data**  
Table: `sales`  
| sale_id | product_id | sale_date  | quantity |
|---------|------------|------------|----------|
| 1       | 601        | 2025-01-05 | 10       |
| 2       | 601        | 2025-01-06 | 5        |
| 3       | 602        | 2025-01-07 | 8        |
| 4       | 601        | 2025-01-08 | 12       |

**Question**  
Write a query to calculate the cumulative quantity sold for each product over time.

**Answer**  
```sql
SELECT 
    sale_id,
    product_id,
    sale_date,
    quantity,
    SUM(quantity) OVER (
        PARTITION BY product_id 
        ORDER BY sale_date, sale_id
    ) AS cumulative_quantity
FROM sales
ORDER BY product_id, sale_date, sale_id;
```

---

## Question 16
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary |
|--------|----------|---------|--------|
| 1      | Alice    | 10      | 60000  |
| 2      | Bob      | 10      | 65000  |
| 3      | Charlie  | 20      | 70000  |
| 4      | David    | 20      | 62000  |

**Question**  
Write a query to find the second highest salary in each department.

**Answer**  
```sql
WITH RankedSalaries AS (
    SELECT 
        emp_id,
        emp_name,
        dept_id,
        salary,
        DENSE_RANK() OVER (
            PARTITION BY dept_id 
            ORDER BY salary DESC
        ) AS salary_rank
    FROM employees
)
SELECT 
    emp_id,
    emp_name,
    dept_id,
    salary
FROM RankedSalaries
WHERE salary_rank = 2
ORDER BY dept_id;
```

---

## Question 17
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find the first order date and amount for each customer.

**Answer**  
```sql
SELECT 
    customer_id,
    MIN(order_date) AS first_order_date,
    MIN(amount) KEEP (DENSE_RANK FIRST ORDER BY order_date) AS first_order_amount
FROM orders
GROUP BY customer_id
ORDER BY customer_id;
```

---

## Question 18
**Sample Data**  
Table: `attendance`  
| emp_id | log_date   | status |
|--------|------------|--------|
| 1      | 2025-01-01 | Present|
| 1      | 2025-01-02 | Absent |
| 1      | 2025-01-03 | Present|
| 2      | 2025-01-01 | Present|

**Question**  
Write a query to find employees with at least two consecutive absent days.

**Answer**  
```sql
WITH AbsentDays AS (
    SELECT 
        emp_id,
        log_date,
        status,
        LAG(status) OVER (
            PARTITION BY emp_id 
            ORDER BY log_date
        ) AS prev_status
    FROM attendance
)
SELECT DISTINCT emp_id
FROM AbsentDays
WHERE status = 'Absent' 
AND prev_status = 'Absent'
ORDER BY emp_id;
```

---

## Question 19
**Sample Data**  
Table: `products`  
| product_id | product_name | price | launch_date |
|------------|--------------|-------|-------------|
| 1          | Laptop       | 1000  | 2024-06-01  |
| 2          | Phone        | 600   | 2024-07-01  |
| 3          | Tablet       | 800   | 2024-08-01  |
| 4          | Smartwatch   | 300   | 2024-09-01  |

**Question**  
Write a query to find products launched in the last 6 months from today (2025-05-16).

**Answer**  
```sql
SELECT 
    product_id,
    product_name,
    price,
    launch_date
FROM products
WHERE launch_date >= CURRENT_DATE - INTERVAL '6 months'
ORDER BY launch_date DESC;
```

---

## Question 20
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-01-15 | 150    |
| 3        | 202        | 2025-02-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find the average order amount per customer, excluding their highest order.

**Answer**  
```sql
WITH RankedOrders AS (
    SELECT 
        customer_id,
        amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY amount DESC
        ) AS order_rank
    FROM orders
)
SELECT 
    customer_id,
    AVG(amount) AS avg_amount_excl_highest
FROM RankedOrders
WHERE order_rank > 1
GROUP BY customer_id
HAVING COUNT(*) > 0
ORDER BY customer_id;
```

---

## Question 21
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary | hire_date  |
|--------|----------|---------|--------|------------|
| 1      | Alice    | 10      | 60000  | 2023-05-01 |
| 2      | Bob      | 10      | 65000  | 2022-03-15 |
| 3      | Charlie  | 20      | 70000  | 2024-01-10 |
| 4      | David    | 20      | 62000  | 2023-07-20 |

**Question**  
Write a query to find the longest-serving employee in each department.

**Answer**  
```sql
WITH RankedEmployees AS (
    SELECT 
        emp_id,
        emp_name,
        dept_id,
        hire_date,
        RANK() OVER (
            PARTITION BY dept_id 
            ORDER BY hire_date
        ) AS tenure_rank
    FROM employees
)
SELECT 
    emp_id,
    emp_name,
    dept_id,
    hire_date
FROM RankedEmployees
WHERE tenure_rank = 1
ORDER BY dept_id;
```

---

## Question 22
**Sample Data**  
Table: `sales`  
| sale_id | product_id | sale_date  | quantity |
|---------|------------|------------|----------|
| 1       | 601        | 2025-01-05 | 10       |
| 2       | 601        | 2025-01-06 | 0        |
| 3       | 602        | 2025-01-07 | 8        |
| 4       | 601        | 2025-01-08 | 12       |

**Question**  
Write a query to find days with zero sales for each product.

**Answer**  
```sql
SELECT 
    product_id,
    sale_date
FROM sales
WHERE quantity = 0
ORDER BY product_id, sale_date;
```

---

## Question 23
**Sample Data**  
Table: `users`  
| user_id | signup_date | last_login  |
|---------|-------------|-------------|
| 1       | 2024-01-01  | 2025-01-01  |
| 2       | 2024-02-01  | 2024-06-01  |
| 3       | 2024-03-01  | 2025-02-01  |
| 4       | 2024-04-01  | 2024-05-01  |

**Question**  
Write a query to find users who haven’t logged in for the last 6 months from today (2025-05-16).

**Answer**  
```sql
SELECT 
    user_id,
    signup_date,
    last_login
FROM users
WHERE last_login < CURRENT_DATE - INTERVAL '6 months'
ORDER BY user_id;
```

---

## Question 24
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find customers whose total order amount exceeds the average total order amount across all customers.

**Answer**  
```sql
WITH CustomerTotals AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_amount
    FROM orders
    GROUP BY customer_id
),
AvgTotal AS (
    SELECT AVG(total_amount) AS avg_total
    FROM CustomerTotals
)
SELECT 
    c.customer_id,
    c.total_amount
FROM CustomerTotals c
CROSS JOIN AvgTotal a
WHERE c.total_amount > a.avg_total
ORDER BY c.customer_id;
```

---

## Question 25
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary |
|--------|----------|---------|--------|
| 1      | Alice    | 10      | 60000  |
| 2      | Bob      | 10      | 65000  |
| 3      | Charlie  | 20      | 70000  |
| 4      | David    | NULL    | 62000  |

**Question**  
Write a query to find departments with no employees and employees with no department.

**Answer**  
```sql
-- Assuming a departments table exists
Table: departments
| dept_id | dept_name |
|---------|-----------|
| 10      | HR        |
| 20      | IT        |
| 30      | Finance   |

SELECT 
    d.dept_id,
    d.dept_name,
    'No Employees' AS issue
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL
UNION
SELECT 
    e.dept_id,
    e.emp_name,
    'No Department' AS issue
FROM employees e
WHERE e.dept_id IS NULL
ORDER BY dept_id;
```

---

## Question 26
**Sample Data**  
Table: `sales`  
| sale_id | rep_id | sale_amount | sale_date  |
|---------|--------|-------------|------------|
| 1       | 101    | 5000.00     | 2025-01-15 |
| 2       | 102    | 3000.00     | 2025-01-20 |
| 3       | 101    | 2000.00     | 2025-02-10 |
| 4       | 103    | 4000.00     | 2025-02-15 |

**Question**  
Write a query to find sales reps with no sales in a specific month (e.g., February 2025).

**Answer**  
```sql
SELECT DISTINCT 
    s1.rep_id
FROM sales s1
WHERE NOT EXISTS (
    SELECT 1
    FROM sales s2
    WHERE s2.rep_id = s1.rep_id
    AND DATE_TRUNC('month', s2.sale_date) = '2025-02-01'
)
ORDER BY s1.rep_id;
```

---

## Question 27
**Sample Data**  
Table: `products`  
| product_id | product_name | price |
|------------|--------------|-------|
| 1          | Laptop       | 1000  |
| 2          | Phone        | 600   |
| 3          | Tablet       | NULL  |
| 4          | Smartwatch   | 300   |

**Question**  
Write a query to update NULL prices to the average price of non-NULL products.

**Answer**  
```sql
WITH AvgPrice AS (
    SELECT AVG(price) AS avg_price
    FROM products
    WHERE price IS NOT NULL
)
UPDATE products
SET price = (SELECT avg_price FROM AvgPrice)
WHERE price IS NULL;
```

---

## Question 28
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find the month with the highest total order amount.

**Answer**  
```sql
SELECT 
    DATE_TRUNC('month', order_date) AS order_month,
    SUM(amount) AS total_amount
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY total_amount DESC
LIMIT 1;
```

---

## Question 29
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary | hire_date  |
|--------|----------|---------|--------|------------|
| 1      | Alice    | 10      | 60000  | 2023-05-01 |
| 2      | Bob      | 10      | 65000  | 2022-03-15 |
| 3      | Charlie  | 20      | 70000  | 2024-01-10 |
| 4      | David    | 20      | 62000  | 2023-07-20 |

**Question**  
Write a query to find employees hired in the last 12 months from today (2025-05-16).

**Answer**  
```sql
SELECT 
    emp_id,
    emp_name,
    dept_id,
    hire_date
FROM employees
WHERE hire_date >= CURRENT_DATE - INTERVAL '12 months'
ORDER BY hire_date DESC;
```

---

## Question 30
**Sample Data**  
Table: `transactions`  
| trans_id | account_id | trans_date | amount |
|---------|------------|------------|--------|
| 1       | 301        | 2025-01-05 | 500    |
| 2       | 301        | 2025-01-06 | -200   |
| 3       | 302        | 2025-01-07 | 300    |
| 4       | 301        | 2025-01-08 | -100   |

**Question**  
Write a query to find accounts with negative balance after all transactions.

**Answer**  
```sql
SELECT 
    account_id,
    SUM(amount) AS balance
FROM transactions
GROUP BY account_id
HAVING SUM(amount) < 0
ORDER BY account_id;
```

---

## Question 31
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find customers who placed orders in all months of a specific year (e.g., 2025).

**Answer**  
```sql
WITH Months2025 AS (
    SELECT DISTINCT DATE_TRUNC('month', order_date) AS order_month
    FROM orders
    WHERE EXTRACT(YEAR FROM order_date) = 2025
),
CustomerMonths AS (
    SELECT 
        customer_id,
        COUNT(DISTINCT DATE_TRUNC('month', order_date)) AS month_count
    FROM orders
    WHERE EXTRACT(YEAR FROM order_date) = 2025
    GROUP BY customer_id
),
TotalMonths AS (
    SELECT COUNT(*) AS total_months
    FROM Months2025
)
SELECT 
    c.customer_id
FROM CustomerMonths c
CROSS JOIN TotalMonths t
WHERE c.month_count = t.total_months
ORDER BY c.customer_id;
```

---

## Question 32
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary |
|--------|----------|---------|--------|
| 1      | Alice    | 10      | 60000  |
| 2      | Bob      | 10      | 65000  |
| 3      | Charlie  | 20      | 70000  |
| 4      | David    | 20      | 62000  |

**Question**  
Write a query to find the department with the highest average salary.

**Answer**  
```sql
SELECT 
    dept_id,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY dept_id
ORDER BY avg_salary DESC
LIMIT 1;
```

---

## Question 33
**Sample Data**  
Table: `sales`  
| sale_id | rep_id | sale_amount | sale_date  |
|---------|--------|-------------|------------|
| 1       | 101    | 5000.00     | 2025-01-15 |
| 2       | 102    | 3000.00     | 2025-01-20 |
| 3       | 101    | 2000.00     | 2025-02-10 |
| 4       | 103    | 4000.00     | 2025-02-15 |

**Question**  
Write a query to find sales reps whose total sales amount increased from January to February 2025.

**Answer**  
```sql
WITH MonthlySales AS (
    SELECT 
        rep_id,
        DATE_TRUNC('month', sale_date) AS sale_month,
        SUM(sale_amount) AS total_sales
    FROM sales
    WHERE sale_date BETWEEN '2025-01-01' AND '2025-02-28'
    GROUP BY rep_id, DATE_TRUNC('month', sale_date)
)
SELECT 
    m1.rep_id
FROM MonthlySales m1
JOIN MonthlySales m2 
    ON m1.rep_id = m2.rep_id
    AND m1.sale_month = '2025-01-01'
    AND m2.sale_month = '2025-02-01'
WHERE m2.total_sales > m1.total_sales
ORDER BY m1.rep_id;
```

---

## Question 34
**Sample Data**  
Table: `products`  
| product_id | product_name | category | price |
|------------|--------------|----------|-------|
| 1          | Laptop       | Tech     | 1000  |
| 2          | Phone        | Tech     | 600   |
| 3          | Shirt        | Apparel  | 30    |
| 4          | Jacket       | Apparel  | 80    |

**Question**  
Write a query to find the percentage contribution of each product’s price to its category’s total price.

**Answer**  
```sql
WITH CategoryTotals AS (
    SELECT 
        category,
        SUM(price) AS total_price
    FROM products
    GROUP BY category
)
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    (p.price / c.total_price * 100) AS percentage_contribution
FROM products p
JOIN CategoryTotals c ON p.category = c.category
ORDER BY p.category, p.product_id;
```

---

## Question 35
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find customers whose order amounts are consistently increasing over time.

**Answer**  
```sql
WITH RankedOrders AS (
    SELECT 
        customer_id,
        order_date,
        amount,
        LAG(amount) OVER (
            PARTITION BY customer_id 
            ORDER BY order_date
        ) AS prev_amount
    FROM orders
)
SELECT DISTINCT customer_id
FROM RankedOrders
WHERE prev_amount IS NOT NULL
GROUP BY customer_id
HAVING EVERY(amount > prev_amount)
ORDER BY customer_id;
```

---

## Question 36
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary |
|--------|----------|---------|--------|
| 1      | Alice    | 10      | 60000  |
| 2      | Bob      | 10      | 65000  |
| 3      | Charlie  | 20      | 70000  |
| 4      | David    | 20      | 62000  |

**Question**  
Write a query to find employees whose salary is within 10% of the highest salary in their department.

**Answer**  
```sql
WITH MaxSalaries AS (
    SELECT 
        dept_id,
        MAX(salary) AS max_salary
    FROM employees
    GROUP BY dept_id
)
SELECT 
    e.emp_id,
    e.emp_name,
    e.dept_id,
    e.salary
FROM employees e
JOIN MaxSalaries m ON e.dept_id = m.dept_id
WHERE e.salary >= m.max_salary * 0.9
ORDER BY e.dept_id, e.salary DESC;
```

---

## Question 37
**Sample Data**  
Table: `sales`  
| sale_id | product_id | sale_date  | quantity |
|---------|------------|------------|----------|
| 1       | 601        | 2025-01-05 | 10       |
| 2       | 601        | 2025-01-06 | 5        |
| 3       | 602        | 2025-01-07 | 8        |
| 4       | 601        | 2025-01-08 | 12       |

**Question**  
Write a query to find the moving average of sales quantity for each product over the last 3 sales.

**Answer**  
```sql
SELECT 
    sale_id,
    product_id,
    sale_date,
    quantity,
    AVG(quantity) OVER (
        PARTITION BY product_id 
        ORDER BY sale_date, sale_id
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_quantity
FROM sales
ORDER BY product_id, sale_date, sale_id;
```

---

## Question 38
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find customers who placed orders on the same day as their first order.

**Answer**  
```sql
WITH FirstOrders AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT 
    o.customer_id,
    o.order_id,
    o.order_date,
    o.amount
FROM orders o
JOIN FirstOrders f 
    ON o.customer_id = f.customer_id 
    AND o.order_date = f.first_order_date
ORDER BY o.customer_id, o.order_id;
```

---

## Question 39
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary | hire_date  |
|--------|----------|---------|--------|------------|
| 1      | Alice    | 10      | 60000  | 2023-05-01 |
| 2      | Bob      | 10      | 65000  | 2022-03-15 |
| 3      | Charlie  | 20      | 70000  | 2024-01-10 |
| 4      | David    | 20      | 62000  | 2023-07-20 |

**Question**  
Write a query to find employees who were hired on the same date as another employee.

**Answer**  
```sql
SELECT 
    e1.emp_id,
    e1.emp_name,
    e1.hire_date
FROM employees e1
JOIN employees e2 
    ON e1.hire_date = e2.hire_date 
    AND e1.emp_id != e2.emp_id
ORDER BY e1.hire_date, e1.emp_id;
```

---

## Question 40
**Sample Data**  
Table: `sales`  
| sale_id | rep_id | sale_amount | sale_date  |
|---------|--------|-------------|------------|
| 1       | 101    | 5000.00     | 2025-01-15 |
| 2       | 102    | 3000.00     | 2025-01-20 |
| 3       | 101    | 2000.00     | 2025-02-10 |
| 4       | 103    | 4000.00     | 2025-02-15 |

**Question**  
Write a query to find the top sales rep by total sales amount for each year.

**Answer**  
```sql
WITH YearlySales AS (
    SELECT 
        rep_id,
        EXTRACT(YEAR FROM sale_date) AS sale_year,
        SUM(sale_amount) AS total_sales,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date) 
            ORDER BY SUM(sale_amount) DESC
        ) AS sales_rank
    FROM sales
    GROUP BY rep_id, EXTRACT(YEAR FROM sale_date)
)
SELECT 
    rep_id,
    sale_year,
    total_sales
FROM YearlySales
WHERE sales_rank = 1
ORDER BY sale_year, rep_id;
```

---

## Question 41
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find the average time gap between consecutive orders for each customer.

**Answer**  
```sql
WITH OrderGaps AS (
    SELECT 
        customer_id,
        order_date,
        LAG(order_date) OVER (
            PARTITION BY customer_id 
            ORDER BY order_date
        ) AS prev_order_date
    FROM orders
)
SELECT 
    customer_id,
    AVG(EXTRACT(EPOCH FROM (order_date - prev_order_date))/86400) AS avg_days_gap
FROM OrderGaps
WHERE prev_order_date IS NOT NULL
GROUP BY customer_id
ORDER BY customer_id;
```

---

## Question 42
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary |
|--------|----------|---------|--------|
| 1      | Alice    | 10      | 60000  |
| 2      | Bob      | 10      | 65000  |
| 3      | Charlie  | 20      | 70000  |
| 4      | David    | 20      | 62000  |

**Question**  
Write a query to find the median salary for each department.

**Answer**  
```sql
WITH RankedSalaries AS (
    SELECT 
        dept_id,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY dept_id 
            ORDER BY salary
        ) AS row_num,
        COUNT(*) OVER (PARTITION BY dept_id) AS total_count
    FROM employees
)
SELECT 
    dept_id,
    AVG(salary) AS median_salary
FROM RankedSalaries
WHERE row_num IN (FLOOR((total_count + 1)/2), CEIL((total_count + 1)/2))
GROUP BY dept_id
ORDER BY dept_id;
```

---

## Question 43
**Sample Data**  
Table: `sales`  
| sale_id | product_id | sale_date  | quantity |
|---------|------------|------------|----------|
| 1       | 601        | 2025-01-05 | 10       |
| 2       | 601        | 2025-01-06 | 5        |
| 3       | 602        | 2025-01-07 | 8        |
| 4       | 601        | 2025-01-08 | 12       |

**Question**  
Write a query to find products with sales on all days in a given week (e.g., week of 2025-01-05).

**Answer**  
```sql
WITH WeekDays AS (
    SELECT generate_series(
        '2025-01-05'::date, 
        '2025-01-11'::date, 
        '1 day'::interval
    ) AS sale_date
),
ProductDays AS (
    SELECT DISTINCT 
        s.product_id,
        s.sale_date
    FROM sales s
    WHERE s.sale_date BETWEEN '2025-01-05' AND '2025-01-11'
)
SELECT 
    p.product_id
FROM ProductDays p
GROUP BY p.product_id
HAVING COUNT(DISTINCT p.sale_date) = (SELECT COUNT(*) FROM WeekDays)
ORDER BY p.product_id;
```

---

## Question 44
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find customers whose total order amount doubled from one month to the next.

**Answer**  
```sql
WITH MonthlyTotals AS (
    SELECT 
        customer_id,
        DATE_TRUNC('month', order_date) AS order_month,
        SUM(amount) AS total_amount
    FROM orders
    GROUP BY customer_id, DATE_TRUNC('month', order_date)
),
MonthComparisons AS (
    SELECT 
        customer_id,
        order_month,
        total_amount,
        LAG(total_amount) OVER (
            PARTITION BY customer_id 
            ORDER BY order_month
        ) AS prev_amount
    FROM MonthlyTotals
)
SELECT 
    customer_id,
    order_month,
    total_amount,
    prev_amount
FROM MonthComparisons
WHERE prev_amount IS NOT NULL
AND total_amount >= prev_amount * 2
ORDER BY customer_id, order_month;
```

---

## Question 45
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary |
|--------|----------|---------|--------|
| 1      | Alice    | 10      | 60000  |
| 2      | Bob      | 10      | 65000  |
| 3      | Charlie  | 20      | 70000  |
| 4      | David    | 20      | 62000  |

**Question**  
Write a query to rank employees by salary within each department without gaps in ranking.

**Answer**  
```sql
SELECT 
    emp_id,
    emp_name,
    dept_id,
    salary,
    DENSE_RANK() OVER (
        PARTITION BY dept_id 
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees
ORDER BY dept_id, salary DESC;
```

---

## Question 46
**Sample Data**  
Table: `sales`  
| sale_id | rep_id | sale_amount | sale_date  |
|---------|--------|-------------|------------|
| 1       | 101    | 5000.00     | 2025-01-15 |
| 2       | 102    | 3000.00     | 2025-01-20 |
| 3       | 101    | 2000.00     | 2025-02-10 |
| 4       | 103    | 4000.00     | 2025-02-15 |

**Question**  
Write a query to find sales reps with sales in the top 25% of total sales amount for each month.

**Answer**  
```sql
WITH MonthlySales AS (
    SELECT 
        rep_id,
        DATE_TRUNC('month', sale_date) AS sale_month,
        SUM(sale_amount) AS total_sales,
        PERCENT_RANK() OVER (
            PARTITION BY DATE_TRUNC('month', sale_date) 
            ORDER BY SUM(sale_amount) DESC
        ) AS sales_percent_rank
    FROM sales
    GROUP BY rep_id, DATE_TRUNC('month', sale_date)
)
SELECT 
    rep_id,
    sale_month,
    total_sales
FROM MonthlySales
WHERE sales_percent_rank <= 0.25
ORDER BY sale_month, total_sales DESC;
```

---

## Question 47
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find the longest gap between consecutive orders for each customer.

**Answer**  
```sql
WITH OrderGaps AS (
    SELECT 
        customer_id,
        order_date,
        LAG(order_date) OVER (
            PARTITION BY customer_id 
            ORDER BY order_date
        ) AS prev_order_date
    FROM orders
)
SELECT 
    customer_id,
    MAX(EXTRACT(EPOCH FROM (order_date - prev_order_date))/86400) AS max_days_gap
FROM OrderGaps
WHERE prev_order_date IS NOT NULL
GROUP BY customer_id
ORDER BY customer_id;
```

---

## Question 48
**Sample Data**  
Table: `employees`  
| emp_id | emp_name | dept_id | salary |
|--------|----------|---------|--------|
| 1      | Alice    | 10      | 60000  |
| 2      | Bob      | 10      | 65000  |
| 3      | Charlie  | 20      | 70000  |
| 4      | David    | 20      | 62000  |

**Question**  
Write a query to find employees whose salary is above the 75th percentile of all salaries.

**Answer**  
```sql
WITH SalaryPercentiles AS (
    SELECT 
        emp_id,
        emp_name,
        salary,
        PERCENT_RANK() OVER (
            ORDER BY salary
        ) AS salary_percent_rank
    FROM employees
)
SELECT 
    emp_id,
    emp_name,
    salary
FROM SalaryPercentiles
WHERE salary_percent_rank > 0.75
ORDER BY salary DESC;
```

---

## Question 49
**Sample Data**  
Table: `sales`  
| sale_id | product_id | sale_date  | quantity |
|---------|------------|------------|----------|
| 1       | 601        | 2025-01-05 | 10       |
| 2       | 601        | 2025-01-06 | 5        |
| 3       | 602        | 2025-01-07 | 8        |
| 4       | 601        | 2025-01-08 | 12       |

**Question**  
Write a query to find products with no sales on a specific date (e.g., 2025-01-07).

**Answer**  
```sql
SELECT DISTINCT 
    product_id
FROM sales
WHERE product_id NOT IN (
    SELECT product_id 
    FROM sales 
    WHERE sale_date = '2025-01-07'
)
ORDER BY product_id;
```

---

## Question 50
**Sample Data**  
Table: `orders`  
| order_id | customer_id | order_date | amount |
|----------|------------|------------|--------|
| 1        | 201        | 2025-01-10 | 100    |
| 2        | 201        | 2025-02-15 | 150    |
| 3        | 202        | 2025-01-20 | 200    |
| 4        | 203        | 2025-03-05 | 300    |

**Question**  
Write a query to find customers whose first and last orders have amounts differing by more than 100.

**Answer**  
```sql
WITH FirstLastOrders AS (
    SELECT 
        customer_id,
        MIN(amount) KEEP (DENSE_RANK FIRST ORDER BY order_date) AS first_amount,
        MAX(amount) KEEP (DENSE_RANK LAST ORDER BY order_date) AS last_amount
    FROM orders
    GROUP BY customer_id
)
SELECT 
    customer_id,
    first_amount,
    last_amount
FROM FirstLastOrders
WHERE ABS(last_amount - first_amount) > 100
ORDER BY customer_id;
```
