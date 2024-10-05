Here’s the complete set of **100 SQL queries** for the **Marketing Campaign Effectiveness Analysis** project, ranging from **easy**, **medium**, and **hard** levels. These queries cover a variety of use cases for campaign analysis, customer engagement, performance metrics, and customer responses.

### **Easy Level Queries (1-25)**

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

16. **Retrieve all campaigns that ended after 2021-01-01.**
  
    SELECT Campaign_Name, End_Date 
    FROM marketing_campaign_information 
    WHERE End_Date > '2021-01-01';
    ```

17. **Find the campaigns that were not successful.**
  
    SELECT Campaign_Name 
    FROM marketing_campaign_information 
    WHERE Campaign_Success = 'No';
    ```

18. **Show the distinct target audiences in the campaigns.**
  
    SELECT DISTINCT Target_Audience 
    FROM marketing_campaign_information;
    ```

19. **Retrieve campaigns that had the same budget and actual spending.**
  
    SELECT Campaign_Name 
    FROM marketing_campaign_information 
    WHERE Budget = Actual_Spending;
    ```

20. **Find campaigns that started and ended in the same year.**
  
    SELECT Campaign_Name, Start_Date, End_Date 
    FROM marketing_campaign_information 
    WHERE YEAR(Start_Date) = YEAR(End_Date);
    ```

21. **List the campaigns that had engagement on or after 2022-01-01.**
  
    SELECT DISTINCT Campaign_ID 
    FROM customer_engagement 
    WHERE Engagement_Date >= '2022-01-01';
    ```

22. **Retrieve campaigns that have no engagements.**
  
    SELECT Campaign_Name 
    FROM marketing_campaign_information 
    WHERE Campaign_ID NOT IN (SELECT DISTINCT Campaign_ID FROM customer_engagement);
    ```

23. **Count the number of campaigns for each region that were successful.**
  
    SELECT Region, COUNT(*) AS Successful_Campaigns 
    FROM marketing_campaign_information 
    WHERE Campaign_Success = 'Yes' 
    GROUP BY Region;
    ```

24. **Find the campaigns with more than 500 clicks but less than 1000 conversions.**
  
    SELECT Campaign_ID, Clicks, Conversions 
    FROM campaign_performance 
    WHERE Clicks > 500 AND Conversions < 1000;
    ```

25. **Show all campaigns with a negative ROI.**
  
    SELECT Campaign_ID, ROI 
    FROM campaign_performance 
    WHERE ROI < 1.0;
    ```

### **Medium Level Queries (26-60)**

26. **Find campaigns that were successful and had a budget utilization greater than 0.8.**
  
    SELECT Campaign_Name, Budget, Actual_Spending, 
           (Actual_Spending / Budget) AS Budget_Utilization 
    FROM marketing_campaign_information 
    WHERE Campaign_Success = 'Yes' 
    AND (Actual_Spending / Budget) > 0.8;
    ```

27. **Calculate the total spending for each campaign type.**
  
    SELECT Campaign_Type, SUM(Actual_Spending) AS Total_Spending 
    FROM marketing_campaign_information 
    GROUP BY Campaign_Type;
    ```

28. **Find the average purchase amount for each engagement channel.**
  
    SELECT Engagement_Channel, AVG(Purchase_Amount) AS Average_Purchase 
    FROM customer_engagement 
    GROUP BY Engagement_Channel;
    ```

29. **Find campaigns with more than 1,000 engagements and a positive response rate greater than 70%.**
  
    SELECT c.Campaign_ID, COUNT(e.Engagement_ID) AS Total_Engagements, 
           (SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) / COUNT(e.Engagement_ID)) AS Positive_Response_Rate 
    FROM marketing_campaign_information c 
    JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
    JOIN customer_response r ON e.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Campaign_ID 
    HAVING COUNT(e.Engagement_ID) > 1000 AND Positive_Response_Rate > 0.7;
    ```

30. **List campaigns that had no customer responses.**
  
    SELECT Campaign_Name 
    FROM marketing_campaign_information 
    WHERE Campaign_ID NOT IN (SELECT DISTINCT Campaign_ID FROM customer_response);
    ```

31. **Find the top 5 campaigns by ROI and their total impressions.**
  
    SELECT p.Campaign_ID, m.Campaign_Name, p.ROI, p.Impressions 
    FROM campaign_performance p 
    JOIN marketing_campaign_information m ON p.Campaign_ID = m.Campaign_ID 
    ORDER BY p.ROI DESC 
    LIMIT 5;
    ```

32. **Calculate the total number of clicks for each campaign type.**
  
    SELECT c.Campaign_Type, SUM(p.Clicks) AS Total_Clicks 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    GROUP BY c.Campaign_Type;
    ```

33. **Find the campaigns that generated more than 5,000 conversions but less than 20,000 clicks.**
  
    SELECT Campaign_ID, Conversions, Clicks 
    FROM campaign_performance 
    WHERE Conversions > 5000 AND Clicks < 20000;
    ```

34. **Calculate the average cost per conversion for each campaign type.**
  
    SELECT c.Campaign_Type, AVG(p.Cost_per_Conversion) AS Average_Cost_per_Conversion 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    GROUP BY c.Campaign_Type;
    ```

35. **Find the campaigns with the highest satisfaction scores by region.**
  
    SELECT c.Region, c.Campaign_Name, MAX(r.Customer_Satisfaction) AS Max_Satisfaction 
    FROM marketing_campaign

36. **Find campaigns with an average cost per click greater than $2 and a total budget utilization greater than 90%.**
   
    SELECT c.Campaign_Name, p.Cost_per_Click, 
           (c.Actual_Spending / c.Budget) AS Budget_Utilization 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    WHERE p.Cost_per_Click > 2 AND (c.Actual_Spending / c.Budget) > 0.9;
    ```

37. **Calculate the total impressions and clicks for campaigns that targeted 'Adults'.**
   
    SELECT c.Campaign_Name, SUM(p.Impressions) AS Total_Impressions, SUM(p.Clicks) AS Total_Clicks 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    WHERE c.Target_Audience = 'Adults' 
    GROUP BY c.Campaign_Name;
    ```

38. **List campaigns that had a negative response rate higher than 50%.**
   
    SELECT c.Campaign_Name, 
           (SUM(CASE WHEN r.Response_Type = 'Negative' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) AS Negative_Response_Rate 
    FROM marketing_campaign_information c 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Campaign_Name 
    HAVING Negative_Response_Rate > 0.5;
    ```

39. **Identify campaigns that had an ROI greater than 2 but a satisfaction score lower than 3.**
   
    SELECT c.Campaign_Name, p.ROI, AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Campaign_Name, p.ROI 
    HAVING p.ROI > 2 AND Average_Satisfaction < 3;
    ```

40. **Calculate the overall engagement rate for campaigns with over 50,000 impressions.**
   
    SELECT c.Campaign_Name, 
           (COUNT(e.Engagement_ID) / SUM(p.Impressions)) * 100 AS Engagement_Rate 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
    GROUP BY c.Campaign_Name 
    HAVING SUM(p.Impressions) > 50000;
    ```

41. **List campaigns that targeted multiple audiences (e.g., 'Teens' and 'Adults').**
   
    SELECT c.Campaign_Name, c.Target_Audience 
    FROM marketing_campaign_information c 
    WHERE c.Target_Audience IN ('Teens', 'Adults');
    ```

42. **Find campaigns with more than 100 positive customer responses and less than 20 negative responses.**
   
    SELECT c.Campaign_Name, 
           SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) AS Positive_Responses, 
           SUM(CASE WHEN r.Response_Type = 'Negative' THEN 1 ELSE 0 END) AS Negative_Responses 
    FROM marketing_campaign_information c 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Campaign_Name 
    HAVING Positive_Responses > 100 AND Negative_Responses < 20;
    ```

43. **Calculate the average satisfaction score for campaigns by region.**
   
    SELECT c.Region, AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
    FROM marketing_campaign_information c 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Region;
    ```

44. **Find campaigns that had more than 5000 engagements and a conversion rate greater than 30%.**
   
    SELECT c.Campaign_Name, COUNT(e.Engagement_ID) AS Total_Engagements, 
           (SUM(p.Conversions) / COUNT(e.Engagement_ID)) * 100 AS Conversion_Rate 
    FROM marketing_campaign_information c 
    JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    GROUP BY c.Campaign_Name 
    HAVING Total_Engagements > 5000 AND Conversion_Rate > 30;
    ```

45. **Retrieve campaigns that had no clicks but generated impressions.**
   
    SELECT c.Campaign_Name, p.Impressions 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    WHERE p.Clicks = 0 AND p.Impressions > 0;
    ```

46. **Calculate the total spending by campaign type and region.**
   
    SELECT c.Campaign_Type, c.Region, SUM(c.Actual_Spending) AS Total_Spending 
    FROM marketing_campaign_information c 
    GROUP BY c.Campaign_Type, c.Region;
    ```

47. **Identify campaigns with an average engagement duration longer than 3 minutes.**
   
    SELECT c.Campaign_Name, AVG(e.Engagement_Duration_Seconds) AS Average_Engagement_Duration 
    FROM marketing_campaign_information c 
    JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
    GROUP BY c.Campaign_Name 
    HAVING Average_Engagement_Duration > 180;
    ```

48. **Calculate the percentage of successful campaigns for each region.**
   
    SELECT c.Region, 
           (SUM(CASE WHEN c.Campaign_Success = 'Yes' THEN 1 ELSE 0 END) / COUNT(c.Campaign_ID)) * 100 AS Success_Rate 
    FROM marketing_campaign_information c 
    GROUP BY c.Region;
    ```

49. **Find campaigns that had more positive than negative responses but a satisfaction score below 3.**
   
    SELECT c.Campaign_Name, 
           SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) AS Positive_Responses, 
           SUM(CASE WHEN r.Response_Type = 'Negative' THEN 1 ELSE 0 END) AS Negative_Responses, 
           AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
    FROM marketing_campaign_information c 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Campaign_Name 
    HAVING Positive_Responses > Negative_Responses AND Average_Satisfaction < 3;
    ```

50. **Calculate the overall average cost per conversion for campaigns in the 'North' region.**
   
    SELECT AVG(p.Cost_per_Conversion) AS Average_Cost_per_Conversion 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    WHERE c.Region = 'North';
    ```

51. **List campaigns that had both a positive response rate higher than 60% and an ROI greater than 2.**
   
    SELECT c.Campaign_Name, 
           (SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) * 100 AS Positive_Response_Rate, 
           p.ROI 
    FROM marketing_campaign_information c 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    GROUP BY c.Campaign_Name, p.ROI 
    HAVING Positive_Response_Rate > 60 AND p.ROI > 2;
    ```

52. **Retrieve campaigns that had more than 2,000 clicks but less than 500 conversions.**
   
    SELECT Campaign_ID, Clicks, Conversions 
    FROM campaign_performance 
    WHERE Clicks > 2000 AND Conversions < 500;
    ```

53. **Calculate the average satisfaction score for campaigns by target audience.**
   
    SELECT c.Target_Audience, AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
    FROM marketing_campaign_information c 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Target_Audience;
    ```

54. **Identify campaigns that targeted 'Seniors' but had a satisfaction score less than 2.**
   
    SELECT c.Campaign_Name, AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
    FROM marketing_campaign_information c 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    WHERE c.Target_Audience = 'Seniors' 
    GROUP BY c.Campaign_Name 
    HAVING Average_Satisfaction < 2;
    ```

55. **List campaigns with a click-through rate (CTR) higher than 5%.**
   
    SELECT c.Campaign_Name, 
           (p.Clicks / p.Impressions) * 100 AS Click_Through_Rate 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    WHERE (p.Clicks / p.Impressions) > 0.05;
    ```

56. **Find campaigns that generated more than 10,000 conversions and less than 1,000 negative responses.**
   
    SELECT c.Campaign_Name, SUM(p.Conversions) AS Total_Conversions, 
           SUM(CASE WHEN r.Response_Type = 'Negative' THEN 1 ELSE 0 END) AS Total_Negative_Responses 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Campaign_Name 
    HAVING Total_Conversions > 10000 AND Total_Negative_Responses < 1000;
    ```

57. **Calculate the conversion rate for campaigns targeting 'Teens' by region.**
   
    SELECT c.Region, 
           (SUM(p.Conversions) / SUM(p.Clicks)) * 100 AS Conversion_Rate 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    WHERE c.Target_Audience = 'Teens' 
    GROUP BY c.Region;
    ```

58. **Find campaigns that had the highest satisfaction score in each region.**
   
    SELECT c.Region, c.Campaign_Name, MAX(r.Customer_Satisfaction) AS Max_Satisfaction 
    FROM marketing_campaign_information c 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Region, c.Campaign_Name 
    ORDER BY c.Region;
    ```

59. **Calculate the average satisfaction score for each campaign type by region.**
   
    SELECT c.Campaign_Type, c.Region, AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
    FROM marketing_campaign_information c 
    JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
    GROUP BY c.Campaign_Type, c.Region;
    ```

60. **Retrieve campaigns with a cost per conversion higher than the average cost per conversion for that region.**
   
    SELECT c.Campaign_Name, c.Region, p.Cost_per_Conversion 
    FROM marketing_campaign_information c 
    JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
    WHERE p.Cost_per_Conversion > (SELECT AVG(p2.Cost_per_Conversion) 
                                   FROM campaign_performance p2 
                                   JOIN marketing_campaign_information c2 ON p2.Campaign_ID = c2.Campaign_ID 
                                   WHERE c2.Region = c.Region);
    ```

Sure! I’ll continue with the remaining SQL queries from query number 61 and go up to 100, ensuring a good mix of hard-level scenarios for advanced analysis. 

### **Hard Level Queries (61-100)**

61. **Calculate the engagement-to-impressions ratio and conversion-to-engagement ratio for campaigns targeting 'Adults'.**
  
   SELECT c.Campaign_Name, 
          (COUNT(e.Engagement_ID) / SUM(p.Impressions)) * 100 AS Engagement_to_Impressions, 
          (SUM(p.Conversions) / COUNT(e.Engagement_ID)) * 100 AS Conversion_to_Engagement 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   WHERE c.Target_Audience = 'Adults' 
   GROUP BY c.Campaign_Name;
   ```

62. **Identify campaigns that had both high customer satisfaction and low engagement.**
  
   SELECT c.Campaign_Name, AVG(r.Customer_Satisfaction) AS Average_Satisfaction, 
          COUNT(e.Engagement_ID) AS Total_Engagements 
   FROM marketing_campaign_information c 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Average_Satisfaction > 4 AND Total_Engagements < 100;
   ```

63. **Calculate the engagement rate, click-through rate, and conversion rate for campaigns that were successful in the 'West' region.**
  
   SELECT c.Campaign_Name, 
          (COUNT(e.Engagement_ID) / SUM(p.Impressions)) * 100 AS Engagement_Rate, 
          (SUM(p.Clicks) / SUM(p.Impressions)) * 100 AS Click_Through_Rate, 
          (SUM(p.Conversions) / SUM(p.Clicks)) * 100 AS Conversion_Rate 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   WHERE c.Region = 'West' AND c.Campaign_Success = 'Yes' 
   GROUP BY c.Campaign_Name;
   ```

64. **List campaigns that had a positive response rate higher than 75% and a click-through rate lower than 5%.**
  
   SELECT c.Campaign_Name, 
          (SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) * 100 AS Positive_Response_Rate, 
          (SUM(p.Clicks) / SUM(p.Impressions)) * 100 AS Click_Through_Rate 
   FROM marketing_campaign_information c 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Positive_Response_Rate > 75 AND Click_Through_Rate < 5;
   ```

65. **Find campaigns with the highest ROI in each campaign type and region.**
  
   SELECT c.Campaign_Type, c.Region, c.Campaign_Name, MAX(p.ROI) AS Max_ROI 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Type, c.Region, c.Campaign_Name 
   ORDER BY Max_ROI DESC;
   ```

66. **Identify campaigns that had a high number of conversions but low satisfaction scores.**
  
   SELECT c.Campaign_Name, SUM(p.Conversions) AS Total_Conversions, AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Total_Conversions > 1000 AND Average_Satisfaction < 2;
   ```

67. **Calculate the average cost per click for campaigns with high satisfaction scores.**
  
   SELECT c.Campaign_Name, AVG(p.Cost_per_Click) AS Average_Cost_per_Click 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING AVG(r.Customer_Satisfaction) > 4;
   ```

68. **Find campaigns that had engagement channels with a satisfaction score lower than 3.**
  
   SELECT c.Campaign_Name, e.Engagement_Channel, AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
   FROM marketing_campaign_information c 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   JOIN customer_response r ON e.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name, e.Engagement_Channel 
   HAVING Average_Satisfaction < 3;
   ```

69. **Calculate the conversion rate for campaigns targeting different age groups (Teens, Adults, Seniors).**
  
   SELECT c.Target_Audience, 
          (SUM(p.Conversions) / SUM(p.Clicks)) * 100 AS Conversion_Rate 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Target_Audience;
   ```

70. **Identify campaigns with both high engagement rates and low conversion rates.**
  
   SELECT c.Campaign_Name, 
          (COUNT(e.Engagement_ID) / SUM(p.Impressions)) * 100 AS Engagement_Rate, 
          (SUM(p.Conversions) / COUNT(e.Engagement_ID)) * 100 AS Conversion_Rate 
   FROM marketing_campaign_information c 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Engagement_Rate > 50 AND Conversion_Rate < 10;
   ```

71. **Find campaigns that generated the highest positive response rate for each engagement channel.**
  
   SELECT e.Engagement_Channel, c.Campaign_Name, 
          (SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) * 100 AS Positive_Response_Rate 
   FROM marketing_campaign_information c 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY e.Engagement_Channel, c.Campaign_Name 
   ORDER BY Positive_Response_Rate DESC;
   ```

72. **Calculate the ROI for campaigns targeting multiple regions.**
  
   SELECT c.Campaign_Name, COUNT(DISTINCT c.Region) AS Total_Regions, AVG(p.ROI) AS Average_ROI 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Total_Regions > 1;
   ```

73. **List campaigns with an engagement duration longer than 5 minutes and more than 200 clicks.**
  
   SELECT c.Campaign_Name, AVG(e.Engagement_Duration_Seconds) AS Average_Engagement_Duration, SUM(p.Clicks) AS Total_Clicks 
   FROM marketing_campaign_information c 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Average_Engagement_Duration > 300 AND Total_Clicks > 200;
   ```

74. **Calculate the satisfaction score variance for campaigns targeting 'Teens'.**
  
   SELECT c.Campaign_Name, VAR(r.Customer_Satisfaction) AS Satisfaction_Variance 
   FROM marketing_campaign_information c 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   WHERE c.Target_Audience = 'Teens' 
   GROUP BY c.Campaign_Name;
   ```

75. **Find campaigns that generated at least 50 positive responses through 'Social Media' but had a budget utilization below 60%.**
  
   SELECT c.Campaign_Name, SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) AS Positive_Responses, 
          (c.Actual_Spending / c.Budget) * 100 AS Budget_Utilization 
   FROM marketing_campaign_information c 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   WHERE e.Engagement_Channel = 'Social Media' 
   GROUP BY c.Campaign_Name 
   HAVING Positive_Responses >= 50 AND Budget_Utilization < 60;
   ```

### **Advanced SQL Queries (76-100)**

76. **Identify campaigns that targeted multiple audience types and had a positive response rate higher than 80%.**
  
   SELECT c.Campaign_Name, c.Target_Audience, 
          (SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) * 100 AS Positive_Response_Rate 
   FROM marketing_campaign_information c 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name, c.Target_Audience 
   HAVING Positive_Response_Rate > 80 AND c.Target_Audience IN ('Teens', 'Adults', 'Seniors');
   ```

77. **Calculate the average satisfaction score for campaigns with a click-through rate higher than 7%.**
  
   SELECT c.Campaign_Name, AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING (SUM(p.Clicks) / SUM(p.Impressions)) * 100 > 7;
   ```

78. **Find campaigns that had more than 5,000 engagements but fewer than 1,000 positive responses.**
  
   SELECT c.Campaign_Name, COUNT(e.Engagement_ID) AS Total_Engagements, 
          SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) AS Positive_Responses 
   FROM marketing_campaign_information c 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Total_Engagements > 5000 AND Positive_Responses < 1000;
   ```

79. **Calculate the engagement-to-conversion ratio for campaigns in the 'South' region.**
  
   SELECT c.Campaign_Name, 
          (SUM(p.Conversions) / COUNT(e.Engagement_ID)) * 100 AS Engagement_to_Conversion 
   FROM marketing_campaign_information c 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   WHERE c.Region = 'South' 
   GROUP BY c.Campaign_Name;
   ```

80. **List campaigns that had a higher ROI than the average ROI of campaigns in their region.**
  
   SELECT c.Campaign_Name, c.Region, p.ROI 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   WHERE p.ROI > (SELECT AVG(p2.ROI) 
                  FROM campaign_performance p2 
                  JOIN marketing_campaign_information c2 ON p2.Campaign_ID = c2.Campaign_ID 
                  WHERE c2.Region = c.Region);
   ```

81. **Identify campaigns that targeted 'Adults' and had a negative satisfaction rate higher than 20%.**
  
   SELECT c.Campaign_Name, c.Target_Audience, 
          (SUM(CASE WHEN r.Response_Type = 'Negative' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) * 100 AS Negative_Response_Rate 
   FROM marketing_campaign_information c 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name, c.Target_Audience 
   HAVING Negative_Response_Rate > 20 AND c.Target_Audience = 'Adults';
   ```

82. **Calculate the overall success rate of campaigns in each region.**
  
   SELECT c.Region, 
          (SUM(CASE WHEN c.Campaign_Success = 'Yes' THEN 1 ELSE 0 END) / COUNT(c.Campaign_ID)) * 100 AS Success_Rate 
   FROM marketing_campaign_information c 
   GROUP BY c.Region;
   ```

83. **Find campaigns that had more than 10,000 impressions but generated fewer than 500 clicks.**
  
   SELECT c.Campaign_Name, SUM(p.Impressions) AS Total_Impressions, SUM(p.Clicks) AS Total_Clicks 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Total_Impressions > 10000 AND Total_Clicks < 500;
   ```

84. **Calculate the average purchase amount for campaigns that had a conversion rate higher than 10%.**
  
   SELECT c.Campaign_Name, AVG(e.Purchase_Amount) AS Average_Purchase 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING (SUM(p.Conversions) / SUM(p.Clicks)) * 100 > 10;
   ```

85. **Identify campaigns with an average engagement duration lower than 2 minutes but a high number of purchases.**
  
   SELECT c.Campaign_Name, AVG(e.Engagement_Duration_Seconds) AS Average_Engagement_Duration, 
          SUM(e.Purchase_Amount) AS Total_Purchases 
   FROM marketing_campaign_information c 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Average_Engagement_Duration < 120 AND Total_Purchases > 5000;
   ```

86. **Calculate the positive response rate for campaigns with a budget utilization lower than 50%.**
  
   SELECT c.Campaign_Name, 
          (SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) * 100 AS Positive_Response_Rate 
   FROM marketing_campaign_information c 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING (c.Actual_Spending / c.Budget) < 0.5;
   ```

87. **List campaigns that had more than 3,000 conversions and a satisfaction score higher than 4.**
  
   SELECT c.Campaign_Name, SUM(p.Conversions) AS Total_Conversions, 
          AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Total_Conversions > 3000 AND Average_Satisfaction > 4;
   ```

88. **Find campaigns that generated more than 10,000 negative responses.**
  
   SELECT c.Campaign_Name, 
          SUM(CASE WHEN r.Response_Type = 'Negative' THEN 1 ELSE 0 END) AS Total_Negative_Responses 
   FROM marketing_campaign_information c 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Total_Negative_Responses > 10000;
   ```

89. **Calculate the conversion rate and satisfaction score for campaigns with a low budget utilization.**
  
   SELECT c.Campaign_Name, 
          (SUM(p.Conversions) / SUM(p.Clicks)) * 100 AS Conversion_Rate, 
          AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING (c.Actual_Spending / c.Budget) < 0.6;
   ```

90. **Identify campaigns with the highest cost per conversion in each campaign type.**
  
   SELECT c.Campaign_Type, c.Campaign_Name, MAX(p.Cost_per_Conversion) AS Max_Cost_per_Conversion 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Type, c.Campaign_Name 
   ORDER BY Max_Cost_per_Conversion DESC;
   ```

91. **Find campaigns that had an engagement rate higher than the average engagement rate for campaigns in the same region.**
  
   SELECT c.Campaign_Name, c.Region, 
          (COUNT(e.Engagement_ID) / SUM(p.Impressions)) * 100 AS Engagement_Rate 
   FROM marketing_campaign_information c 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Name, c.Region 
   HAVING Engagement_Rate > (SELECT AVG((COUNT(e2.Engagement_ID) / SUM(p2.Impressions)) * 100) 
                             FROM marketing_campaign_information c2 
                             JOIN customer_engagement e2 ON c2.Campaign_ID = e2.Campaign_ID 
                             JOIN campaign_performance p2 ON c2.Campaign_ID = p2.Campaign_ID 
                             WHERE c2.Region = c.Region);
   ```

92. **Calculate the average cost per click for campaigns that had a negative response rate lower than 5%.**
  
   SELECT c.Campaign_Name, AVG(p.Cost_per

_Click) AS Average_Cost_per_Click 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING (SUM(CASE WHEN r.Response_Type = 'Negative' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) < 0.05;
   ```

93. **Find campaigns that had a higher positive response rate than conversion rate.**
  
   SELECT c.Campaign_Name, 
          (SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) * 100 AS Positive_Response_Rate, 
          (SUM(p.Conversions) / SUM(p.Clicks)) * 100 AS Conversion_Rate 
   FROM marketing_campaign_information c 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Positive_Response_Rate > Conversion_Rate;
   ```

94. **Calculate the engagement rate for campaigns that generated fewer than 1,000 negative responses.**
  
   SELECT c.Campaign_Name, 
          (COUNT(e.Engagement_ID) / SUM(p.Impressions)) * 100 AS Engagement_Rate 
   FROM marketing_campaign_information c 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING SUM(CASE WHEN r.Response_Type = 'Negative' THEN 1 ELSE 0 END) < 1000;
   ```

95. **List campaigns that had a click-through rate higher than 10% and a positive response rate higher than 70%.**
  
   SELECT c.Campaign_Name, 
          (SUM(p.Clicks) / SUM(p.Impressions)) * 100 AS Click_Through_Rate, 
          (SUM(CASE WHEN r.Response_Type = 'Positive' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) * 100 AS Positive_Response_Rate 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Click_Through_Rate > 10 AND Positive_Response_Rate > 70;
   ```

96. **Identify campaigns with an ROI higher than the ROI for campaigns targeting the same audience type.**
  
   SELECT c.Campaign_Name, c.Target_Audience, p.ROI 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   WHERE p.ROI > (SELECT AVG(p2.ROI) 
                  FROM marketing_campaign_information c2 
                  JOIN campaign_performance p2 ON c2.Campaign_ID = p2.Campaign_ID 
                  WHERE c2.Target_Audience = c.Target_Audience);
   ```

97. **Find campaigns with more than 1,000 clicks but a click-to-conversion rate lower than 5%.**
  
   SELECT c.Campaign_Name, SUM(p.Clicks) AS Total_Clicks, 
          (SUM(p.Conversions) / SUM(p.Clicks)) * 100 AS Click_to_Conversion_Rate 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Total_Clicks > 1000 AND Click_to_Conversion_Rate < 5;
   ```

98. **Calculate the average satisfaction score and negative response rate for campaigns in the 'East' region.**
  
   SELECT c.Campaign_Name, AVG(r.Customer_Satisfaction) AS Average_Satisfaction, 
          (SUM(CASE WHEN r.Response_Type = 'Negative' THEN 1 ELSE 0 END) / COUNT(r.Response_ID)) * 100 AS Negative_Response_Rate 
   FROM marketing_campaign_information c 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   WHERE c.Region = 'East' 
   GROUP BY c.Campaign_Name;
   ```

99. **List campaigns that generated fewer than 5,000 impressions but more than 1,000 conversions.**
  
   SELECT c.Campaign_Name, SUM(p.Impressions) AS Total_Impressions, SUM(p.Conversions) AS Total_Conversions 
   FROM marketing_campaign_information c 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING Total_Impressions < 5000 AND Total_Conversions > 1000;
   ```

100. **Calculate the click-through rate and satisfaction score for campaigns with an engagement duration longer than 4 minutes.**
  
   SELECT c.Campaign_Name, 
          (SUM(p.Clicks) / SUM(p.Impressions)) * 100 AS Click_Through_Rate, 
          AVG(r.Customer_Satisfaction) AS Average_Satisfaction 
   FROM marketing_campaign_information c 
   JOIN customer_engagement e ON c.Campaign_ID = e.Campaign_ID 
   JOIN campaign_performance p ON c.Campaign_ID = p.Campaign_ID 
   JOIN customer_response r ON c.Campaign_ID = r.Campaign_ID 
   GROUP BY c.Campaign_Name 
   HAVING AVG(e.Engagement_Duration_Seconds) > 240;
