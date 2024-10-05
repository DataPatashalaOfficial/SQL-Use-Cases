Here are **35 SQL queries** ranging from medium to hard difficulty based on the financial datasets (General Ledger, Financial Statements, Budget Allocation, Cash Flow). These queries will help you perform advanced financial analysis and gain in-depth insights from your financial data.

### **Medium Level SQL Queries**

1. **Query 1: Calculate total revenue and expenses for each department.**
   
   SELECT Department, 
          SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) AS Total_Revenue,
          SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END) AS Total_Expenses
   FROM general_ledger
   GROUP BY Department;
   ```

2. **Query 2: Find the top 5 locations with the highest revenue.**
   
   SELECT Location, SUM(Amount) AS Total_Revenue
   FROM general_ledger
   WHERE Account_Type = 'Revenue'
   GROUP BY Location
   ORDER BY Total_Revenue DESC
   LIMIT 5;
   ```

3. **Query 3: Calculate net profit for each quarter and department.**
   
   SELECT YEAR(Transaction_Date) AS Year, QUARTER(Transaction_Date) AS Quarter, Department,
          SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) -
          SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END) AS Net_Profit
   FROM general_ledger
   GROUP BY YEAR(Transaction_Date), QUARTER(Transaction_Date), Department;
   ```

4. **Query 4: Retrieve all cash flow inflows and outflows for the Finance department.**
   
   SELECT Flow_ID, Cash_Flow_Type, Amount, Direction, Transaction_Date
   FROM cash_flow
   WHERE Department = 'Finance';
   ```

5. **Query 5: Calculate the budget variance (Budget - Actual) for each department.**
   
   SELECT Department, 
          SUM(Budget_Amount) AS Total_Budget, 
          SUM(Actual_Amount) AS Total_Actual, 
          SUM(Budget_Amount) - SUM(Actual_Amount) AS Budget_Variance
   FROM budget_allocation
   GROUP BY Department;
   ```

6. **Query 6: Find the top 3 departments with the highest total cash outflows.**
   
   SELECT Department, SUM(Amount) AS Total_Outflow
   FROM cash_flow
   WHERE Direction = 'Outflow'
   GROUP BY Department
   ORDER BY Total_Outflow DESC
   LIMIT 3;
   ```

7. **Query 7: Calculate the average revenue per transaction for each account type.**
   
   SELECT Account_Type, AVG(Amount) AS Average_Revenue
   FROM general_ledger
   WHERE Account_Type = 'Revenue'
   GROUP BY Account_Type;
   ```

8. **Query 8: Find the departments that have a total budget variance greater than $10,000.**
   
   SELECT Department, 
          SUM(Budget_Amount) - SUM(Actual_Amount) AS Budget_Variance
   FROM budget_allocation
   GROUP BY Department
   HAVING Budget_Variance > 10000;
   ```

9. **Query 9: Calculate the total assets and liabilities for each location.**
   
   SELECT Location, 
          SUM(CASE WHEN Account_Type = 'Assets' THEN Amount ELSE 0 END) AS Total_Assets,
          SUM(CASE WHEN Account_Type = 'Liabilities' THEN Amount ELSE 0 END) AS Total_Liabilities
   FROM general_ledger
   GROUP BY Location;
   ```

10. **Query 10: Calculate the percentage of total revenue contributed by each department.**
    
    SELECT Department, 
           (SUM(Amount) / (SELECT SUM(Amount) FROM general_ledger WHERE Account_Type = 'Revenue')) * 100 AS Revenue_Percentage
    FROM general_ledger
    WHERE Account_Type = 'Revenue'
    GROUP BY Department;
    ```

---

### **Hard Level SQL Queries**

11. **Query 11: Identify departments with cash outflows exceeding inflows in the past 6 months.**
    
    SELECT Department, 
           SUM(CASE WHEN Direction = 'Inflow' THEN Amount ELSE 0 END) AS Total_Inflow,
           SUM(CASE WHEN Direction = 'Outflow' THEN Amount ELSE 0 END) AS Total_Outflow
    FROM cash_flow
    WHERE Transaction_Date >= CURDATE() - INTERVAL 6 MONTH
    GROUP BY Department
    HAVING Total_Outflow > Total_Inflow;
    ```

12. **Query 12: Calculate the rolling 12-month total revenue for each department.**
    
    SELECT Department, Transaction_Date,
           SUM(Amount) OVER (PARTITION BY Department ORDER BY Transaction_Date RANGE BETWEEN INTERVAL 12 MONTH PRECEDING AND CURRENT ROW) AS Rolling_12_Month_Revenue
    FROM general_ledger
    WHERE Account_Type = 'Revenue';
    ```

13. **Query 13: Calculate the cumulative net profit for each department by year and quarter.**
    
    SELECT YEAR(Transaction_Date) AS Year, QUARTER(Transaction_Date) AS Quarter, Department,
           SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) -
           SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END) AS Net_Profit,
           SUM(SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) -
               SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END)) 
           OVER (PARTITION BY Department ORDER BY YEAR(Transaction_Date), QUARTER(Transaction_Date)) AS Cumulative_Net_Profit
    FROM general_ledger
    GROUP BY YEAR(Transaction_Date), QUARTER(Transaction_Date), Department;
    ```

14. **Query 14: Identify the top 5 departments with the highest average cash flow per transaction.**
    
    SELECT Department, AVG(Amount) AS Average_Cash_Flow
    FROM cash_flow
    GROUP BY Department
    ORDER BY Average_Cash_Flow DESC
    LIMIT 5;
    ```

15. **Query 15: Calculate the profit margin for each department where profit margin is defined as `(Total Revenue - Total Expenses) / Total Revenue`.**
    
    SELECT Department,
           SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) AS Total_Revenue,
           SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END) AS Total_Expenses,
           (SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) -
            SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END)) / 
            SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) AS Profit_Margin
    FROM general_ledger
    GROUP BY Department;
    ```

16. **Query 16: Calculate the current ratio for each location, defined as `Total Assets / Total Liabilities`.**
    
    SELECT Location,
           SUM(CASE WHEN Account_Type = 'Assets' THEN Amount ELSE 0 END) AS Total_Assets,
           SUM(CASE WHEN Account_Type = 'Liabilities' THEN Amount ELSE 0 END) AS Total_Liabilities,
           SUM(CASE WHEN Account_Type = 'Assets' THEN Amount ELSE 0 END) /
           SUM(CASE WHEN Account_Type = 'Liabilities' THEN Amount ELSE 0 END) AS Current_Ratio
    FROM general_ledger
    GROUP BY Location;
    ```

17. **Query 17: Find the departments with budget utilization greater than 100% (overspending).**
    
    SELECT Department,
           SUM(Actual_Amount) / SUM(Budget_Amount) * 100 AS Budget_Utilization
    FROM budget_allocation
    GROUP BY Department
    HAVING Budget_Utilization > 100;
    ```

18. **Query 18: Calculate the return on equity (ROE) for each department, defined as `Net Income / Total Equity`.**
    
    SELECT Department,
           SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) - 
           SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END) AS Net_Income,
           SUM(CASE WHEN Account_Type = 'Equity' THEN Amount ELSE 0 END) AS Total_Equity,
           (SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) - 
            SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END)) / 
            SUM(CASE WHEN Account_Type = 'Equity' THEN Amount ELSE 0 END) AS ROE
    FROM general_ledger
    GROUP BY Department;
    ```

19. **Query 19: Calculate the quick ratio for each department, defined as `(Total Current Assets - Inventory) / Total Liabilities`.**
    
    SELECT Department,
           SUM(CASE WHEN Account_Type = 'Current Assets' THEN Amount ELSE 0 END) - 
           SUM(CASE WHEN Account_Type = 'Inventory' THEN Amount ELSE 0 END) AS Quick_Assets,
           SUM(CASE WHEN Account_Type = 'Liabilities' THEN Amount ELSE 0 END) AS Total_Liabilities,
           (SUM(CASE WHEN Account_Type = 'Current Assets' THEN Amount ELSE 0 END) - 
            SUM(CASE WHEN Account_Type = 'Inventory' THEN Amount ELSE 0 END)) / 
            SUM(CASE WHEN Account_Type = 'Liabilities' THEN Amount ELSE 0 END) AS Quick_R

atio
    FROM general_ledger
    GROUP BY Department;
    ```

20. **Query 20: Identify months where cash outflows were greater than cash inflows for the Finance department.**
    
    SELECT DATE_FORMAT(Transaction_Date, '%Y-%m') AS Month,
           SUM(CASE WHEN Direction = 'Inflow' THEN Amount ELSE 0 END) AS Total_Inflow,
           SUM(CASE WHEN Direction = 'Outflow' THEN Amount ELSE 0 END) AS Total_Outflow
    FROM cash_flow
    WHERE Department = 'Finance'
    GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
    HAVING Total_Outflow > Total_Inflow;
    ```

21. **Query 21: Calculate the total variance percentage for each financial statement type.**
    
    SELECT Statement_Type,
           SUM(Amount) AS Total_Amount,
           SUM(Amount) / (SELECT SUM(Amount) FROM financial_statements) * 100 AS Variance_Percentage
    FROM financial_statements
    GROUP BY Statement_Type;
    ```

22. **Query 22: Find departments with negative net cash flow (total cash outflows greater than total cash inflows).**
    
    SELECT Department,
           SUM(CASE WHEN Direction = 'Inflow' THEN Amount ELSE 0 END) AS Total_Inflow,
           SUM(CASE WHEN Direction = 'Outflow' THEN Amount ELSE 0 END) AS Total_Outflow,
           SUM(CASE WHEN Direction = 'Inflow' THEN Amount ELSE 0 END) - 
           SUM(CASE WHEN Direction = 'Outflow' THEN Amount ELSE 0 END) AS Net_Cash_Flow
    FROM cash_flow
    GROUP BY Department
    HAVING Net_Cash_Flow < 0;
    ```

23. **Query 23: Calculate the debt-to-equity ratio for each location, defined as `Total Liabilities / Total Equity`.**
    
    SELECT Location,
           SUM(CASE WHEN Account_Type = 'Liabilities' THEN Amount ELSE 0 END) AS Total_Liabilities,
           SUM(CASE WHEN Account_Type = 'Equity' THEN Amount ELSE 0 END) AS Total_Equity,
           SUM(CASE WHEN Account_Type = 'Liabilities' THEN Amount ELSE 0 END) /
           SUM(CASE WHEN Account_Type = 'Equity' THEN Amount ELSE 0 END) AS Debt_to_Equity_Ratio
    FROM general_ledger
    GROUP BY Location;
    ```

24. **Query 24: Calculate the cumulative budget utilization rate over the past 3 years for each department.**
    
    SELECT Department, Year,
           SUM(Actual_Amount) / SUM(Budget_Amount) AS Budget_Utilization,
           SUM(SUM(Actual_Amount) / SUM(Budget_Amount)) OVER (PARTITION BY Department ORDER BY Year) AS Cumulative_Utilization
    FROM budget_allocation
    GROUP BY Department, Year;
    ```

25. **Query 25: Identify departments that have had a revenue growth rate of more than 10% year-over-year.**
    
    SELECT Department, 
           (SUM(Amount) - LAG(SUM(Amount), 1) OVER (PARTITION BY Department ORDER BY YEAR(Transaction_Date))) / 
           LAG(SUM(Amount), 1) OVER (PARTITION BY Department ORDER BY YEAR(Transaction_Date)) * 100 AS Revenue_Growth_Rate
    FROM general_ledger
    WHERE Account_Type = 'Revenue'
    GROUP BY Department, YEAR(Transaction_Date)
    HAVING Revenue_Growth_Rate > 10;
    ```

26. **Query 26: Find the variance percentage for each account type in the balance sheet.**
    
    SELECT Account_Type,
           SUM(Amount) AS Total_Amount,
           SUM(Amount) / (SELECT SUM(Amount) FROM financial_statements WHERE Statement_Type = 'Balance Sheet') * 100 AS Variance_Percentage
    FROM financial_statements
    WHERE Statement_Type = 'Balance Sheet'
    GROUP BY Account_Type;
    ```

27. **Query 27: Identify the top 3 departments with the highest return on assets (ROA), defined as `Net Income / Total Assets`.**
    
    SELECT Department,
           SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) - 
           SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END) AS Net_Income,
           SUM(CASE WHEN Account_Type = 'Assets' THEN Amount ELSE 0 END) AS Total_Assets,
           (SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) - 
            SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END)) / 
            SUM(CASE WHEN Account_Type = 'Assets' THEN Amount ELSE 0 END) AS ROA
    FROM general_ledger
    GROUP BY Department
    ORDER BY ROA DESC
    LIMIT 3;
    ```

28. **Query 28: Calculate the operating cash flow ratio for each department, defined as `Operating Cash Flow / Current Liabilities`.**
    
    SELECT Department,
           SUM(CASE WHEN Cash_Flow_Type = 'Operating' AND Direction = 'Inflow' THEN Amount ELSE 0 END) AS Operating_Cash_Flow,
           SUM(CASE WHEN Account_Type = 'Current Liabilities' THEN Amount ELSE 0 END) AS Current_Liabilities,
           SUM(CASE WHEN Cash_Flow_Type = 'Operating' AND Direction = 'Inflow' THEN Amount ELSE 0 END) /
           SUM(CASE WHEN Account_Type = 'Current Liabilities' THEN Amount ELSE 0 END) AS Operating_Cash_Flow_Ratio
    FROM cash_flow
    JOIN general_ledger ON cash_flow.Account_ID = general_ledger.Account_ID
    GROUP BY Department;
    ```

29. **Query 29: Identify departments that have exceeded their budget for more than 2 consecutive quarters.**
    
    SELECT Department, Year, Quarter, Budget_Amount, Actual_Amount
    FROM (
        SELECT Department, Year, Quarter,
               Budget_Amount, Actual_Amount,
               LAG(Actual_Amount, 1) OVER (PARTITION BY Department ORDER BY Year, Quarter) AS Previous_Actual,
               LAG(Actual_Amount, 2) OVER (PARTITION BY Department ORDER BY Year, Quarter) AS Two_Quarters_Ago_Actual
        FROM budget_allocation
    ) AS BudgetHistory
    WHERE Actual_Amount > Budget_Amount AND Previous_Actual > Budget_Amount AND Two_Quarters_Ago_Actual > Budget_Amount;
    ```

30. **Query 30: Calculate the average monthly revenue for each department over the past 12 months.**
    
    SELECT Department,
           AVG(SUM(Amount)) OVER (PARTITION BY Department ORDER BY DATE_FORMAT(Transaction_Date, '%Y-%m')) AS Average_Monthly_Revenue
    FROM general_ledger
    WHERE Account_Type = 'Revenue'
    AND Transaction_Date >= CURDATE() - INTERVAL 12 MONTH
    GROUP BY Department, DATE_FORMAT(Transaction_Date, '%Y-%m');
    ```

31. **Query 31: Calculate the percentage change in total expenses for each department compared to the previous year.**
    
    SELECT Department, YEAR(Transaction_Date) AS Year,
           SUM(Amount) AS Total_Expenses,
           (SUM(Amount) - LAG(SUM(Amount), 1) OVER (PARTITION BY Department ORDER BY YEAR(Transaction_Date))) / 
           LAG(SUM(Amount), 1) OVER (PARTITION BY Department ORDER BY YEAR(Transaction_Date)) * 100 AS Expense_Change_Percentage
    FROM general_ledger
    WHERE Account_Type = 'Expenses'
    GROUP BY Department, YEAR(Transaction_Date);
    ```

32. **Query 32: Identify months where the Finance department had a negative operating cash flow.**
    
    SELECT DATE_FORMAT(Transaction_Date, '%Y-%m') AS Month,
           SUM(Amount) AS Operating_Cash_Flow
    FROM cash_flow
    WHERE Department = 'Finance' AND Cash_Flow_Type = 'Operating'
    GROUP BY DATE_FORMAT(Transaction_Date, '%Y-%m')
    HAVING Operating_Cash_Flow < 0;
    ```

33. **Query 33: Calculate the cumulative budget variance over the past 3 years for each department.**
    
    SELECT Department, Year,
           SUM(Budget_Amount) - SUM(Actual_Amount) AS Budget_Variance,
           SUM(SUM(Budget_Amount) - SUM(Actual_Amount)) OVER (PARTITION BY Department ORDER BY Year) AS Cumulative_Budget_Variance
    FROM budget_allocation
    GROUP BY Department, Year;
    ```

34. **Query 34: Calculate the contribution margin for each department, defined as `Total Revenue - Total Variable Costs`.**
    
    SELECT Department,
           SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) AS Total_Revenue,
           SUM(CASE WHEN Account_Type = 'Expenses' AND Account_ID IN ('Variable_Costs') THEN Amount ELSE 0 END) AS Total_Variable_Costs,
           SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) - 
           SUM(CASE WHEN Account_Type = 'Expenses' AND Account_ID IN ('Variable_Costs') THEN Amount ELSE 0 END) AS Contribution_Margin
    FROM general_ledger
    GROUP BY Department;
    ```

35. **Query 35: Calculate the revenue-to-expenses ratio for each department and identify the top 5

 departments with the highest ratios.**
    
    SELECT Department,
           SUM(CASE WHEN Account_Type = 'Revenue' THEN Amount ELSE 0 END) /
           SUM(CASE WHEN Account_Type = 'Expenses' THEN Amount ELSE 0 END) AS Revenue_to_Expenses_Ratio
    FROM general_ledger
    GROUP BY Department
    ORDER BY Revenue_to_Expenses_Ratio DESC
    LIMIT 5;

These queries cover a range of advanced financial analyses, including budget variance analysis, financial ratios, cash flow analysis, and profitability analysis. Let me know if you'd like any specific query breakdown or additional queries!
