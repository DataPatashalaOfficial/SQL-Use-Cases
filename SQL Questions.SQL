1. Total Sales by Product

SELECT ProductID, SUM(TotalAmount) AS TotalSales
FROM SalesTransactions
GROUP BY ProductID;
