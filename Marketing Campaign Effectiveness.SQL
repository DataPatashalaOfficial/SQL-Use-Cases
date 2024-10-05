Certainly! Here are **100 SQL queries** based on the **Marketing Campaign Effectiveness Analysis** datasets, divided into **easy**, **medium**, and **hard** levels. The queries will cover a range of analysis scenarios, including basic data exploration, campaign performance analysis, and advanced analytics.

### **Easy Level Queries**

1. **Retrieve all campaigns and their budget amounts.**
   
   SELECT Campaign_Name, Budget 
   FROM marketing_campaign_information;
   ```

2. **List the distinct types of campaigns.**
   
   SELECT DISTINCT Campaign_Type 
   FROM marketing_campaign_information;
   ```

3. **Count the number of campaigns for each campaign type.**
   
   SELECT Campaign_Type, COUNT(*) AS Total_Campaigns 
   FROM marketing_campaign_information 
   GROUP BY Campaign_Type;
   ```

4. **Show the top 5 campaigns with the highest actual spending.**
   
   SELECT Campaign_Name, Actual_Spending 
   FROM marketing_campaign_information 
   ORDER BY Actual_Spending DESC 
   LIMIT 5;
   ```

5. **Find the campaigns that target 'Teens'.**
   
   SELECT Campaign_Name 
   FROM marketing_campaign_information 
   WHERE Target_Audience = 'Teens';
   ```

6. **List campaigns that had more than $50,000 budget.**
   
   SELECT Campaign_Name, Budget 
   FROM marketing_campaign_information 
   WHERE Budget > 50000;
   ```

7. **Retrieve all customer engagements and their engagement types.**
   
   SELECT Customer_ID, Engagement_Type 
   FROM customer_engagement;
   ```

8. **Count the total number of engagements for each engagement type.**
   
   SELECT Engagement_Type, COUNT(*) AS Total_Engagements 
   FROM customer_engagement 
   GROUP BY Engagement_Type;
   ```

9. **Find the distinct channels through which engagements occurred.**
   
   SELECT DISTINCT Engagement_Channel 
   FROM customer_engagement;
   ```

10. **List the top 3 campaigns by number of engagements.**
    
    SELECT Campaign_ID, COUNT(*) AS Total_Engagements 
    FROM customer_engagement 
    GROUP BY Campaign_ID 
    ORDER BY Total_Engagements DESC 
    LIMIT 3;
    ```

11. **Show all campaign performances with ROI greater than 1.5.**
    
    SELECT Campaign_ID, ROI 
    FROM campaign_performance 
    WHERE ROI > 1.5;
    ```

12. **Find the campaigns that generated more than 10,000 clicks.**
    
    SELECT Campaign_ID, Clicks 
    FROM campaign_performance 
    WHERE Clicks > 10000;
    ```

13. **List the campaigns that had a positive customer response.**
    
    SELECT Campaign_ID 
    FROM customer_response 
    WHERE Response_Type = 'Positive';
    ```

14. **Calculate the average customer satisfaction score for each campaign.**
    
    SELECT Campaign_ID, AVG(Customer_Satisfaction) AS Average_Satisfaction 
    FROM customer_response 
    GROUP BY Campaign_ID;
    ```

15. **Count the number of campaigns by region.**
    
    SELECT Region, COUNT(*) AS Total_Campaigns 
    FROM marketing_campaign_information 
    GROUP BY Region;
    ```

### **Medium Level Queries**

16. **Find campaigns that were successful and had a budget utilization greater than 0.8.**
    
    SELECT Campaign_Name, Budget, Actual_Spending, 
           (Actual_Spending / Budget) AS Budget_Utilization 
    FROM marketing_campaign_information 
    WHERE Campaign_Success = 'Yes' 
    AND (Actual_Spending / Budget) > 0.8;
    ```

17. **Calculate the total spending for each campaign type.**
    
    SELECT Campaign_Type, SUM(Actual_Spending) AS Total_Spending 
    FROM marketing_campaign_information 
    GROUP BY Campaign_Type;
    ```

18. **Find the average purchase amount for each engagement channel.**
    
    SELECT Engagement_Channel, AVG(Purchase_Amount) AS Average_Purchase 
    FROM customer_engagement 
    GROUP BY Engagement_Channel;
    ```

19. **Find campaigns with more than 1,000 engagements and a positive response rate greater than 70%.**
    
    SELECT c.Campaign_ID, COUNT(e.Engagement_ID) AS Total_Engagements, 
           (SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) / COUNT(e.Engagement_ID)) AS Positive_Response_Rate 
    FROM marketing_campaign_information c 
    JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
    JOIN customer_response r ON e.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Campaign_ID 
    HAVING COUNT(e.Engagement_ID) > 1000 AND Positive_Response_Rate > 0.7;
    ```

20. **List campaigns that had no customer responses.**
    
    SELECT Campaign_Name 
    FROM marketing_campaign_information 
    WHERE Campaign_ID NOT IN (SELECT DISTINCT Campaign_ID FROM customer_response);
    ```

21. **Find the top 5 campaigns by ROI and their total impressions.**
    
    SELECT p.Campaign_ID, m.Campaign_Name, p.ROI, p.Impressions 
    FROM campaign_performance p 
    JOIN marketing_campaign_information m ON p.Campaign_ID = m.Campaign_ID 
    ORDER BY p.ROI DESC 
    LIMIT 5;
    ```

22. **Calculate the total number of clicks for each campaign type.**
    
    SELECT c.Campaign_Type, SUM(p.Clicks) AS Total_Clicks 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    GROUP BY c.Campaign_Type;
    ```

23. **Find the campaigns that had more than 5,000 conversions but less than 20,000 clicks.**
    
    SELECT Campaign_ID, Conversions, Clicks 
    FROM campaign_performance 
    WHERE Conversions > 5000 AND Clicks < 20000;
    ```

24. **Calculate the average cost per conversion for each campaign type.**
    
    SELECT c.Campaign_Type, AVG(p.Cost_per_Conversion) AS Average_Cost_per_Conversion 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    GROUP BY c.Campaign_Type;
    ```

25. **Find the campaigns with the highest satisfaction scores by region.**
    
    SELECT c.Region, c.Campaign_Name, MAX(r.Customer_Satisfaction) AS Max_Satisfaction 
    FROM marketing_campaign_information c 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Region, c.Campaign_Name 
    ORDER BY Max_Satisfaction DESC;
    ```

### **Hard Level Queries**

26. **Find campaigns that had the highest ROI in each region.**
    
    SELECT c.Region, c.Campaign_Name, p.ROI 
    FROM campaign_performance p 
    JOIN marketing_campaign_information c ON p.Campaign_ID = c.Campaign_ID 
    WHERE (p.ROI = (SELECT MAX(ROI) FROM campaign_performance p2 WHERE p2.Campaign_ID = c.Campaign_ID)) 
    GROUP BY c.Region, c.Campaign_Name, p.ROI 
    ORDER BY c.Region;
    ```

27. **Analyze the effectiveness of campaigns by calculating the percentage increase in conversions relative to clicks for each campaign type.**
    
    SELECT c.Campaign_Type, 
           SUM(p.Conversions) AS Total_Conversions, 
           SUM(p.Clicks) AS Total_Clicks, 
           ((SUM(p.Conversions) - SUM(p.Clicks)) / SUM(p.Clicks)) * 100 AS Conversion_Percentage_Increase 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    GROUP BY c.Campaign_Type;
    ```

28. **Calculate the average engagement duration and purchase amount for campaigns that were successful vs. unsuccessful.**
    
    SELECT c.Campaign_Success, 
           AVG(e.Engagement_Duration_Seconds) AS Average_Engagement_Duration, 
           AVG(e.Purchase_Amount) AS Average_Purchase_Amount 
    FROM marketing_campaign_information c 
    JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
    GROUP BY c.Campaign_Success;
    ```

29. **Identify campaigns with the highest positive response rate and analyze their budget utilization and ROI.**
    
    SELECT c.Campaign_Name, 
           (SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) AS Positive_Response_Rate, 
           (c.Actual_Spending / c.Budget) AS Budget_Utilization, 
           p.ROI 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Campaign_Name, c.Actual_Spending, c.Budget, p.ROI 
    HAVING Positive_Response_Rate > 0.7;
    ```

30. **Calculate the overall campaign performance score for each campaign by combining various metrics like engagement rate, click-through rate, and conversion rate.**
    
    SELECT c.Campaign_Name, 
           (SUM(e.Engagement_ID) / SUM

(p.Impressions)) * 100 AS Engagement_Rate, 
           (SUM(p.Clicks) / SUM(p.Impressions)) * 100 AS Click_Through_Rate, 
           (SUM(p.Conversions) / SUM(p.Clicks)) * 100 AS Conversion_Rate, 
           ((SUM(e.Engagement_ID) / SUM(p.Impressions)) + (SUM(p.Clicks) / SUM(p.Impressions)) + (SUM(p.Conversions) / SUM(p.Clicks))) / 3 AS Overall_Performance_Score 
    FROM marketing_campaign_information c 
    JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    GROUP BY c.Campaign_Name
