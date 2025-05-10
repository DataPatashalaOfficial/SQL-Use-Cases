# SQL Capstone Project: Airline Operations Analytics

## Project Description
The **Airline Operations Analytics** capstone project is designed to deepen SQL proficiency by analyzing a comprehensive dataset of Delta Air Lines flights from December 6, 2018. Sourced from the attached CSV (`untitled_report-dataset-dc11942a8bc1-2025-05-10-10-19-30.csv`) and aligned with Mode.com's flights dataset, this project simulates real-world airline data analytics tasks. The dataset captures critical metrics such as flight times, delays, distances, and airport details, enabling insights into operational efficiency, delay patterns, and route performance.

This project includes 100 SQL interview questions, spanning Medium to Very High difficulty levels, to prepare candidates for analytics and data engineering roles. The questions cover essential SQL concepts (filtering, grouping, joins), advanced techniques (window functions, CTEs, subqueries), and optimization strategies, reflecting 2025 industry trends. By working through these questions, users will develop skills to handle complex datasets, optimize queries, and derive actionable business insights. The project avoids using temporary tables, ensuring compatibility with environments where such functionality is restricted.

## Dataset Description
The dataset contains 100 rows of flight records for Delta Air Lines on December 6, 2018, with metrics like departure/arrival times, delays, and airport information. It is stored in the `tutorial.flights` table, accessible via Mode.com or a SQL database.

### Table Structure
The schema for `tutorial.flights`, inferred from the CSV, is:

```sql
CREATE TABLE tutorial.flights (
    actual_arrival_time FLOAT, -- Arrival time in HHMM format (e.g., 1339.0 for 1:39 PM)
    actual_flight_time FLOAT, -- Actual flight duration in minutes
    actual_departure_time FLOAT, -- Departure time in HHMM format
    air_time FLOAT, -- Time in air in minutes
    air_traffic_delay FLOAT, -- Delay due to air traffic control in minutes
    airline_code VARCHAR(10), -- Airline code (e.g., 'DL')
    airline_name VARCHAR(50), -- Airline name (e.g., 'Delta Air Lines Inc.')
    arrival_delay FLOAT, -- Arrival delay in minutes (negative for early)
    cancellation_reason VARCHAR(50), -- Reason for cancellation (empty if not cancelled)
    carrier_delay FLOAT, -- Delay due to carrier in minutes
    day DATETIME, -- Flight date (e.g., '2018-12-06')
    departure_delay FLOAT, -- Departure delay in minutes
    destination_airport VARCHAR(10), -- Destination airport code (e.g., 'ATL')
    destination_city VARCHAR(50), -- Destination city
    destination_state VARCHAR(50), -- Destination state
    distance FLOAT, -- Flight distance in miles
    flight_number FLOAT, -- Flight number
    late_aircraft_delay FLOAT, -- Delay due to late aircraft in minutes
    origin_airport VARCHAR(10), -- Origin airport code
    origin_city VARCHAR(50), -- Origin city
    origin_state VARCHAR(50), -- Origin state
    scheduled_arrival_time FLOAT, -- Scheduled arrival time in HHMM format
    scheduled_departure_time FLOAT, -- Scheduled departure time in HHMM format
    scheduled_flight_time FLOAT, -- Scheduled flight time in minutes
    security_delay FLOAT, -- Delay due to security in minutes
    was_cancelled VARCHAR(10), -- 'true' or 'false'
    weather_delay FLOAT, -- Delay due to weather in minutes
    wheels_off_time FLOAT, -- Wheels off time in HHMM format
    wheels_on_time FLOAT, -- Wheels on time in HHMM format
    day_of_week VARCHAR(20) -- Day of the week (e.g., 'Thursday')
);
```


## 100 SQL Interview Questions and Answers
Below are 100 practical SQL interview questions, categorized by difficulty (Medium: 30, Intermediate: 30, High: 20, Very High: 20), with answers based on the `tutorial.flights` dataset. These questions are designed for analytics interviews, covering data exploration, aggregations, joins, window functions, and optimization. No temporary tables are used, as requested.

### Medium Level (30 Questions)
These questions test foundational SQL skills with practical applications like filtering, grouping, and basic joins.

1. **List all flights with a departure delay greater than 30 minutes.**
   - **Query**:
     ```sql
     SELECT flight_number, origin_airport, destination_airport, departure_delay
     FROM tutorial.flights
     WHERE departure_delay > 30;
     ```
   - **Answer**: Filters flights where `departure_delay` exceeds 30 minutes.

2. **Count the number of flights per destination city.**
   - **Query**:
     ```sql
     SELECT destination_city, COUNT(*) AS flight_count
     FROM tutorial.flights
     GROUP BY destination_city
     ORDER BY flight_count DESC;
     ```
   - **Answer**: Groups flights by `destination_city` and counts occurrences.

3. **Find flights that arrived early (arrival delay < 0).**
   - **Query**:
     ```sql
     SELECT flight_number, origin_city, destination_city, arrival_delay
     FROM tutorial.flights
     WHERE arrival_delay < 0;
     ```
   - **Answer**: Filters flights with negative `arrival_delay`.

4. **Calculate the average flight distance.**
   - **Query**:
     ```sql
     SELECT AVG(distance) AS avg_distance
     FROM tutorial.flights;
     ```
   - **Answer**: Computes the average `distance` in miles.

5. **List the top 5 origin airports by flight count.**
   - **Query**:
     ```sql
     SELECT origin_airport, COUNT(*) AS flight_count
     FROM tutorial.flights
     GROUP BY origin_airport
     ORDER BY flight_count DESC
     LIMIT 5;
     ```
   - **Answer**: Groups by `origin_airport`, counts flights, and limits to top 5.

6. **Find flights with air traffic control delays.**
   - **Query**:
     ```sql
     SELECT flight_number, origin_city, destination_city, air_traffic_delay
     FROM tutorial.flights
     WHERE air_traffic_delay > 0;
     ```
   - **Answer**: Filters flights where `air_traffic_delay` is positive.

7. **Calculate the total actual flight time for all flights.**
   - **Query**:
     ```sql
     SELECT SUM(actual_flight_time) AS total_flight_time_minutes
     FROM tutorial.flights;
     ```
   - **Answer**: Sums `actual_flight_time` across all flights.

8. **List flights with a distance less than 500 miles.**
   - **Query**:
     ```sql
     SELECT flight_number, origin_city, destination_city, distance
     FROM tutorial.flights
     WHERE distance < 500;
     ```
   - **Answer**: Filters flights with `distance` under 500 miles.

9. **Find the flight with the longest actual flight time.**
   - **Query**:
     ```sql
     SELECT flight_number, origin_city, destination_city, actual_flight_time
     FROM tutorial.flights
     WHERE actual_flight_time = (SELECT MAX(actual_flight_time) FROM tutorial.flights);
     ```
   - **Answer**: Identifies the flight with the maximum `actual_flight_time`.

10. **Count flights by destination state.**
    - **Query**:
      ```sql
      SELECT destination_state, COUNT(*) AS flight_count
      FROM tutorial.flights
      GROUP BY destination_state
      ORDER BY flight_count DESC;
      ```
    - **Answer**: Groups flights by `destination_state` and counts occurrences.

11. **List flights where the actual flight time differs from the scheduled flight time by more than 10 minutes.**
    - **Query**:
      ```sql
      SELECT flight_number, actual_flight_time, scheduled_flight_time
      FROM tutorial.flights
      WHERE ABS(actual_flight_time - scheduled_flight_time) > 10;
      ```
    - **Answer**: Filters flights with a significant difference between actual and scheduled times.

12. **Find flights with no delays (both departure and arrival delays are 0 or negative).**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city
      FROM tutorial.flights
      WHERE departure_delay <= 0 AND arrival_delay <= 0;
      ```
    - **Answer**: Filters flights with no positive delays.

13. **Calculate the average arrival delay per origin airport.**
    - **Query**:
      ```sql
      SELECT origin_airport, AVG(arrival_delay) AS avg_arrival_delay
      FROM tutorial.flights
      GROUP BY origin_airport;
      ```
    - **Answer**: Computes the average `arrival_delay` per `origin_airport`.

14. **List flights with a carrier delay greater than 0.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, carrier_delay
      FROM tutorial.flights
      WHERE carrier_delay > 0;
      ```
    - **Answer**: Filters flights with positive `carrier_delay`.

15. **Find the shortest scheduled flight time.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, scheduled_flight_time
      FROM tutorial.flights
      WHERE scheduled_flight_time = (SELECT MIN(scheduled_flight_time) FROM tutorial.flights);
      ```
    - **Answer**: Identifies the flight with the minimum `scheduled_flight_time`.

16. **List flights with a positive arrival delay.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, arrival_delay
      FROM tutorial.flights
      WHERE arrival_delay > 0;
      ```
    - **Answer**: Filters flights delayed on arrival.

17. **Count flights by origin state.**
    - **Query**:
      ```sql
      SELECT origin_state, COUNT(*) AS flight_count
      FROM tutorial.flights
      GROUP BY origin_state
      ORDER BY flight_count DESC;
      ```
    - **Answer**: Groups flights by `origin_state` and counts occurrences.

18. **Find flights with a distance greater than 2000 miles.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, distance
      FROM tutorial.flights
      WHERE distance > 2000;
      ```
    - **Answer**: Filters flights with `distance` over 2000 miles.

19. **Calculate the maximum arrival delay.**
    - **Query**:
      ```sql
      SELECT MAX(arrival_delay) AS max_arrival_delay
      FROM tutorial.flights;
      ```
    - **Answer**: Finds the maximum `arrival_delay`.

20. **List flights with no cancellation.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city
      FROM tutorial.flights
      WHERE was_cancelled = 'false';
      ```
    - **Answer**: Filters non-cancelled flights.

21. **Calculate the average air time per flight.**
    - **Query**:
      ```sql
      SELECT AVG(air_time) AS avg_air_time
      FROM tutorial.flights;
      ```
    - **Answer**: Computes the average `air_time` in minutes.

22. **Find flights with a scheduled departure time before 8 AM.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, scheduled_departure_time
      FROM tutorial.flights
      WHERE scheduled_departure_time < 800;
      ```
    - **Answer**: Filters flights departing before 8:00 AM.

23. **Count flights per airline code.**
    - **Query**:
      ```sql
      SELECT airline_code, COUNT(*) AS flight_count
      FROM tutorial.flights
      GROUP BY airline_code;
      ```
    - **Answer**: Groups flights by `airline_code` (all 'DL' in this dataset).

24. **List flights with a late aircraft delay greater than 0.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, late_aircraft_delay
      FROM tutorial.flights
      WHERE late_aircraft_delay > 0;
      ```
    - **Answer**: Filters flights with positive `late_aircraft_delay`.

25. **Calculate the total distance flown.**
    - **Query**:
      ```sql
      SELECT SUM(distance) AS total_distance
      FROM tutorial.flights;
      ```
    - **Answer**: Sums `distance` across all flights.

26. **Find flights with a scheduled arrival time after 10 PM.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, scheduled_arrival_time
      FROM tutorial.flights
      WHERE scheduled_arrival_time > 2200;
      ```
    - **Answer**: Filters flights arriving after 10:00 PM.

27. **List flights with a flight number between 2450 and 2500.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city
      FROM tutorial.flights
      WHERE flight_number BETWEEN 2450 AND 2500;
      ```
    - **Answer**: Filters flights within the specified `flight_number` range.

28. **Calculate the average departure delay.**
    - **Query**:
      ```sql
      SELECT AVG(departure_delay) AS avg_departure_delay
      FROM tutorial.flights;
      ```
    - **Answer**: Computes the average `departure_delay`.

29. **Find flights with a security delay greater than 0.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, security_delay
      FROM tutorial.flights
      WHERE security_delay > 0;
      ```
    - **Answer**: Filters flights with positive `security_delay`.

30. **List flights sorted by distance in descending order.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, distance
      FROM tutorial.flights
      ORDER BY distance DESC;
      ```
    - **Answer**: Sorts flights by `distance` from longest to shortest.

### Intermediate Level (30 Questions)
These questions involve joins, subqueries, and date/time manipulations.

31. **What is a self-join, and when would you use it?**
    - **Answer**: A self-join joins a table to itself, useful for comparing rows within the same table (e.g., finding round-trip flights). It uses aliases to distinguish table instances.

32. **Find round-trip flights (same origin and destination airports).**
    - **Query**:
      ```sql
      SELECT f1.flight_number, f1.origin_airport, f1.destination_airport
      FROM tutorial.flights f1
      INNER JOIN tutorial.flights f2
      ON f1.origin_airport = f2.destination_airport
      AND f1.destination_airport = f2.origin_airport
      WHERE f1.flight_number < f2.flight_number;
      ```
    - **Answer**: Uses a self-join to find flights where the origin of one matches the destination of another.

33. **Calculate the average departure delay by destination city.**
    - **Query**:
      ```sql
      SELECT destination_city, AVG(departure_delay) AS avg_departure_delay
      FROM tutorial.flights
      GROUP BY destination_city
      ORDER BY avg_departure_delay DESC;
      ```
    - **Answer**: Groups flights by `destination_city` and computes average `departure_delay`.

34. **List flights with a late aircraft delay and their total delay.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city,
             (arrival_delay + departure_delay) AS total_delay,
             late_aircraft_delay
      FROM tutorial.flights
      WHERE late_aircraft_delay > 0;
      ```
    - **Answer**: Filters flights with positive `late_aircraft_delay` and sums delays.

35. **Find the top 3 routes (origin to destination) by flight count.**
    - **Query**:
      ```sql
      SELECT origin_airport, destination_airport, COUNT(*) AS flight_count
      FROM tutorial.flights
      GROUP BY origin_airport, destination_airport
      ORDER BY flight_count DESC
      LIMIT 3;
      ```
    - **Answer**: Groups by route and limits to the top 3 by count.

36. **Calculate the percentage of flights delayed (arrival delay > 0).**
    - **Query**:
      ```sql
      SELECT ROUND(COUNT(CASE WHEN arrival_delay > 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS delayed_percentage
      FROM tutorial.flights;
      ```
    - **Answer**: Computes the percentage of flights with positive `arrival_delay`.

37. **List flights where the air time is less than 90% of the actual flight time.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, air_time, actual_flight_time
      FROM tutorial.flights
      WHERE air_time < 0.9 * actual_flight_time;
      ```
    - **Answer**: Filters flights where `air_time` is significantly less than `actual_flight_time`.

38. **Find flights with a weather delay and their origin state.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, origin_state, weather_delay
      FROM tutorial.flights
      WHERE weather_delay > 0;
      ```
    - **Answer**: Filters flights with positive `weather_delay`.

39. **Calculate the total distance flown by flights originating from Atlanta.**
    - **Query**:
      ```sql
      SELECT SUM(distance) AS total_distance
      FROM tutorial.flights
      WHERE origin_city = 'Atlanta';
      ```
    - **Answer**: Sums `distance` for flights from Atlanta.

40. **List flights where the actual arrival time is earlier than the scheduled arrival time.**
    - **Query**:
      ```sql
      SELECT flight_number, actual_arrival_time, scheduled_arrival_time
      FROM tutorial.flights
      WHERE actual_arrival_time < scheduled_arrival_time;
      ```
    - **Answer**: Filters flights arriving earlier than scheduled.

41. **Find the average flight time for flights over 1000 miles.**
    - **Query**:
      ```sql
      SELECT AVG(actual_flight_time) AS avg_flight_time
      FROM tutorial.flights
      WHERE distance > 1000;
      ```
    - **Answer**: Computes average `actual_flight_time` for long-distance flights.

42. **List flights with the same origin and destination state.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, origin_state
      FROM tutorial.flights
      WHERE origin_state = destination_state;
      ```
    - **Answer**: Filters flights within the same state.

43. **Calculate the maximum departure delay per origin airport.**
    - **Query**:
      ```sql
      SELECT origin_airport, MAX(departure_delay) AS max_departure_delay
      FROM tutorial.flights
      GROUP BY origin_airport;
      ```
    - **Answer**: Finds the maximum `departure_delay` per `origin_airport`.

44. **Find flights with a security delay.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, security_delay
      FROM tutorial.flights
      WHERE security_delay > 0;
      ```
    - **Answer**: Filters flights with positive `security_delay`.

45. **List flights sorted by total delay (arrival + departure).**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city,
             (arrival_delay + departure_delay) AS total_delay
      FROM tutorial.flights
      ORDER BY total_delay DESC;
      ```
    - **Answer**: Sums `arrival_delay` and `departure_delay` and sorts descending.

46. **Find flights with a departure delay but no arrival delay.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, departure_delay
      FROM tutorial.flights
      WHERE departure_delay > 0 AND arrival_delay <= 0;
      ```
    - **Answer**: Filters flights delayed on departure but not on arrival.

47. **Calculate the average distance by origin city.**
    - **Query**:
      ```sql
      SELECT origin_city, AVG(distance) AS avg_distance
      FROM tutorial.flights
      GROUP BY origin_city;
      ```
    - **Answer**: Computes average `distance` per `origin_city`.

48. **List flights with actual flight time less than scheduled flight time.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, actual_flight_time, scheduled_flight_time
      FROM tutorial.flights
      WHERE actual_flight_time < scheduled_flight_time;
      ```
    - **Answer**: Filters flights that took less time than scheduled.

49. **Find the top 5 destination airports by total distance flown.**
    - **Query**:
      ```sql
      SELECT destination_airport, SUM(distance) AS total_distance
      FROM tutorial.flights
      GROUP BY destination_airport
      ORDER BY total_distance DESC
      LIMIT 5;
      ```
    - **Answer**: Groups by `destination_airport` and sums `distance`.

50. **Calculate the percentage of flights with any delay type.**
    - **Query**:
      ```sql
      SELECT ROUND(COUNT(CASE WHEN carrier_delay + weather_delay + late_aircraft_delay + air_traffic_delay + security_delay > 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS delayed_percentage
      FROM tutorial.flights;
      ```
    - **Answer**: Computes percentage of flights with any delay type.

51. **List flights with a wheels-off time after scheduled departure.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, wheels_off_time, scheduled_departure_time
      FROM tutorial.flights
      WHERE wheels_off_time > scheduled_departure_time;
      ```
    - **Answer**: Filters flights where takeoff occurred after scheduled departure.

52. **Find flights with the same origin and destination city.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city
      FROM tutorial.flights
      WHERE origin_city = destination_city;
      ```
    - **Answer**: Filters flights within the same city (none in this dataset).

53. **Calculate the total air traffic delay by destination state.**
    - **Query**:
      ```sql
      SELECT destination_state, SUM(air_traffic_delay) AS total_air_traffic_delay
      FROM tutorial.flights
      GROUP BY destination_state;
      ```
    - **Answer**: Sums `air_traffic_delay` per `destination_state`.

54. **List flights with a flight number divisible by 2.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city
      FROM tutorial.flights
      WHERE MOD(flight_number, 2) = 0;
      ```
    - **Answer**: Filters flights with even `flight_number`.

55. **Find flights with a departure delay greater than the average departure delay.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, departure_delay
      FROM tutorial.flights
      WHERE departure_delay > (SELECT AVG(departure_delay) FROM tutorial.flights);
      ```
    - **Answer**: Compares `departure_delay` to the overall average.

56. **Calculate the minimum actual flight time per origin airport.**
    - **Query**:
      ```sql
      SELECT origin_airport, MIN(actual_flight_time) AS min_flight_time
      FROM tutorial.flights
      GROUP BY origin_airport;
      ```
    - **Answer**: Finds the minimum `actual_flight_time` per `origin_airport`.

57. **List flights with a wheels-on time before actual arrival time.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, wheels_on_time, actual_arrival_time
      FROM tutorial.flights
      WHERE wheels_on_time < actual_arrival_time;
      ```
    - **Answer**: Filters flights where landing occurred before arrival.

58. **Find flights with a distance less than the average distance.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, distance
      FROM tutorial.flights
      WHERE distance < (SELECT AVG(distance) FROM tutorial.flights);
      ```
    - **Answer**: Filters flights below the average `distance`.

59. **Calculate the total carrier delay by origin city.**
    - **Query**:
      ```sql
      SELECT origin_city, SUM(carrier_delay) AS total_carrier_delay
      FROM tutorial.flights
      GROUP BY origin_city;
      ```
    - **Answer**: Sums `carrier_delay` per `origin_city`.

60. **List flights with a scheduled flight time greater than 3 hours.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, scheduled_flight_time
      FROM tutorial.flights
      WHERE scheduled_flight_time > 180;
      ```
    - **Answer**: Filters flights with `scheduled_flight_time` over 180 minutes.

### High Level (20 Questions)
These questions involve window functions, CTEs, and complex aggregations.

61. **What are window functions, and how do they differ from aggregate functions?**
    - **Answer**: Window functions perform calculations across a set of rows related to the current row, preserving row structure. Aggregate functions (e.g., SUM, AVG) collapse rows into a single result. Example: `RANK()` assigns ranks within a partition.

62. **Rank flights by arrival delay within each origin airport.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_airport, destination_city, arrival_delay,
             RANK() OVER (PARTITION BY origin_airport ORDER BY arrival_delay DESC) AS delay_rank
      FROM tutorial.flights;
      ```
    - **Answer**: Uses `RANK()` to rank flights by `arrival_delay` per `origin_airport`.

63. **Calculate the running total of flight distances by flight number.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, distance,
             SUM(distance) OVER (ORDER BY flight_number) AS running_distance
      FROM tutorial.flights;
      ```
    - **Answer**: Uses a window function to compute cumulative `distance`.

64. **Find the top 3 flights by departure delay per destination state.**
    - **Query**:
      ```sql
      WITH RankedFlights AS (
          SELECT flight_number, origin_city, destination_state, departure_delay,
                 RANK() OVER (PARTITION BY destination_state ORDER BY departure_delay DESC) AS rank
          FROM tutorial.flights
      )
      SELECT flight_number, origin_city, destination_state, departure_delay
      FROM RankedFlights
      WHERE rank <= 3;
      ```
    - **Answer**: Uses a CTE and `RANK()` to identify top 3 delayed flights per state.

65. **Calculate the average arrival delay for flights departing within 1 hour of each flight.**
    - **Query**:
      ```sql
      SELECT flight_number, actual_departure_time, arrival_delay,
             AVG(arrival_delay) OVER (
                 ORDER BY actual_departure_time
                 RANGE BETWEEN 60 PRECEDING AND 60 FOLLOWING
             ) AS avg_delay_nearby
      FROM tutorial.flights;
      ```
    - **Answer**: Uses a window function with a time range to average `arrival_delay`.

66. **Find flights with above-average arrival delays for their origin airport.**
    - **Query**:
      ```sql
      WITH AirportDelays AS (
          SELECT origin_airport, AVG(arrival_delay) AS avg_delay
          FROM tutorial.flights
          GROUP BY origin_airport
      )
      SELECT f.flight_number, f.origin_airport, f.arrival_delay
      FROM tutorial.flights f
      INNER JOIN AirportDelays ad ON f.origin_airport = ad.origin_airport
      WHERE f.arrival_delay > ad.avg_delay;
      ```
    - **Answer**: Compares each flight’s `arrival_delay` to its airport’s average.

67. **Calculate the percentage contribution of each flight’s distance to the total distance.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, distance,
             ROUND(distance / SUM(distance) OVER () * 100, 2) AS distance_percentage
      FROM tutorial.flights;
      ```
    - **Answer**: Computes each flight’s `distance` as a percentage of the total.

68. **Find the 5th longest flight by actual flight time.**
    - **Query**:
      ```sql
      SELECT flight_number, actual_flight_time
      FROM (
          SELECT flight_number, actual_flight_time,
                 DENSE_RANK() OVER (ORDER BY actual_flight_time DESC) AS rank
          FROM tutorial.flights
      ) ranked
      WHERE rank = 5;
      ```
    - **Answer**: Uses `DENSE_RANK()` to find the 5th longest `actual_flight_time`.

69. **List flights with consecutive departure times within 30 minutes from the same airport.**
    - **Query**:
      ```sql
      WITH OrderedFlights AS (
          SELECT flight_number, origin_airport, actual_departure_time,
                 LAG(actual_departure_time) OVER (
                     PARTITION BY origin_airport ORDER BY actual_departure_time
                 ) AS prev_departure
          FROM tutorial.flights
      )
      SELECT flight_number, origin_airport, actual_departure_time
      FROM OrderedFlights
      WHERE ABS(actual_departure_time - prev_departure) <= 30;
      ```
    - **Answer**: Uses `LAG()` to find flights with close departure times.

70. **Calculate the month-over-month delay trend (assuming more data).**
    - **Query**:
      ```sql
      WITH MonthlyDelays AS (
          SELECT DATE_FORMAT(day, '%Y-%m') AS month,
                 AVG(arrival_delay) AS avg_delay
          FROM tutorial.flights
          GROUP BY DATE_FORMAT(day, '%Y-%m')
      )
      SELECT month, avg_delay,
             avg_delay - LAG(avg_delay) OVER (ORDER BY month) AS delay_change
      FROM MonthlyDelays;
      ```
    - **Answer**: Uses `LAG()` to compare delays across months (single-day dataset, but scalable).

71. **Rank flights by distance within each destination city.**
    - **Query**:
      ```sql
      SELECT flight_number, destination_city, distance,
             RANK() OVER (PARTITION BY destination_city ORDER BY distance DESC) AS distance_rank
      FROM tutorial.flights;
      ```
    - **Answer**: Uses `RANK()` to rank flights by `distance` per `destination_city`.

72. **Calculate the cumulative arrival delay by origin airport.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_airport, arrival_delay,
             SUM(arrival_delay) OVER (PARTITION BY origin_airport ORDER BY flight_number) AS cumulative_delay
      FROM tutorial.flights;
      ```
    - **Answer**: Uses a window function to compute cumulative `arrival_delay`.

73. **Find flights with the highest departure delay in each origin state.**
    - **Query**:
      ```sql
      WITH RankedFlights AS (
          SELECT flight_number, origin_state, departure_delay,
                 RANK() OVER (PARTITION BY origin_state ORDER BY departure_delay DESC) AS rank
          FROM tutorial.flights
      )
      SELECT flight_number, origin_state, departure_delay
      FROM RankedFlights
      WHERE rank = 1;
      ```
    - **Answer**: Uses `RANK()` to identify the most delayed flight per state.

74. **Calculate the moving average of air time for the last 5 flights.**
    - **Query**:
      ```sql
      SELECT flight_number, air_time,
             AVG(air_time) OVER (
                 ORDER BY flight_number
                 ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
             ) AS moving_avg_air_time
      FROM tutorial.flights;
      ```
    - **Answer**: Uses a window function to compute a 5-flight moving average of `air_time`.

75. **List flights with below-average distance for their destination airport.**
    - **Query**:
      ```sql
      WITH AirportDistances AS (
          SELECT destination_airport, AVG(distance) AS avg_distance
          FROM tutorial.flights
          GROUP BY destination_airport
      )
      SELECT f.flight_number, f.destination_airport, f.distance
      FROM tutorial.flights f
      INNER JOIN AirportDistances ad ON f.destination_airport = ad.destination_airport
      WHERE f.distance < ad.avg_distance;
      ```
    - **Answer**: Compares each flight’s `distance` to its airport’s average.

76. **Find the 3rd shortest flight by scheduled flight time.**
    - **Query**:
      ```sql
      SELECT flight_number, scheduled_flight_time
      FROM (
          SELECT flight_number, scheduled_flight_time,
                 DENSE_RANK() OVER (ORDER BY scheduled_flight_time ASC) AS rank
          FROM tutorial.flights
      ) ranked
      WHERE rank = 3;
      ```
    - **Answer**: Uses `DENSE_RANK()` to find the 3rd shortest `scheduled_flight_time`.

77. **Calculate the difference in arrival delay from the previous flight at the same airport.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_airport, arrival_delay,
             arrival_delay - LAG(arrival_delay) OVER (
                 PARTITION BY origin_airport ORDER BY actual_departure_time
             ) AS delay_difference
      FROM tutorial.flights;
      ```
    - **Answer**: Uses `LAG()` to compute the difference in `arrival_delay`.

78. **List flights with the top 10% of distances.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, distance
      FROM (
          SELECT flight_number, origin_city, destination_city, distance,
                 NTILE(10) OVER (ORDER BY distance DESC) AS distance_decile
          FROM tutorial.flights
      ) ranked
      WHERE distance_decile = 1;
      ```
    - **Answer**: Uses `NTILE()` to identify the top 10% of flights by `distance`.

79. **Calculate the median departure delay (approximate).**
    - **Query**:
      ```sql
      SELECT AVG(departure_delay) AS median_delay
      FROM (
          SELECT departure_delay,
                 ROW_NUMBER() OVER (ORDER BY departure_delay) AS row_num,
                 COUNT(*) OVER () AS total_rows
          FROM tutorial.flights
      ) ranked
      WHERE row_num IN (FLOOR((total_rows + 1)/2), CEIL((total_rows + 1)/2));
      ```
    - **Answer**: Approximates the median `departure_delay` using `ROW_NUMBER()`.

80. **Find flights with a rank in the top 5 by air time per origin city.**
    - **Query**:
      ```sql
      WITH RankedFlights AS (
          SELECT flight_number, origin_city, air_time,
                 RANK() OVER (PARTITION BY origin_city ORDER BY air_time DESC) AS rank
          FROM tutorial.flights
      )
      SELECT flight_number, origin_city, air_time
      FROM RankedFlights
      WHERE rank <= 5;
      ```
    - **Answer**: Uses `RANK()` to find top 5 flights by `air_time` per `origin_city`.

### Very High Level (20 Questions)
These questions test advanced database concepts, optimization, and complex scenarios.

81. **What is query optimization, and how can you improve performance for this dataset?**
    - **Answer**: Query optimization minimizes execution time and resource usage. Techniques:
      - Index `origin_airport`, `destination_airport`, `actual_departure_time`, and `flight_number`.
      - Avoid SELECT *; specify needed columns.
      - Use EXPLAIN to analyze query plans.
      - Replace subqueries with JOINs or CTEs.
      - Partition large datasets by `day`.

82. **Write a stored procedure to flag flights with excessive delays (>60 minutes).**
    - **Query**:
      ```sql
      CREATE PROCEDURE FlagExcessiveDelays()
      BEGIN
          CREATE TABLE IF NOT EXISTS delayed_flights AS
          SELECT flight_number, origin_city, destination_city, arrival_delay
          FROM tutorial.flights
          WHERE arrival_delay > 60;
      END;
      -- Execute: CALL FlagExcessiveDelays();
      ```
    - **Answer**: Creates a table for flights with `arrival_delay` over 60 minutes.

83. **Create a trigger to log flights with weather delays.**
    - **Query**:
      ```sql
      CREATE TABLE delay_log (
          log_id INT AUTO_INCREMENT PRIMARY KEY,
          flight_number FLOAT,
          weather_delay FLOAT,
          log_time TIMESTAMP
      );

      CREATE TRIGGER LogWeatherDelays
      AFTER INSERT ON tutorial.flights
      FOR EACH ROW
      BEGIN
          IF NEW.weather_delay > 0 THEN
              INSERT INTO delay_log (flight_number, weather_delay, log_time)
              VALUES (NEW.flight_number, NEW.weather_delay, NOW());
          END IF;
      END;
      ```
    - **Answer**: Logs flights with positive `weather_delay` into a separate table.

84. **Optimize a slow query for average delays by route.**
    - **Original Query**:
      ```sql
      SELECT origin_airport, destination_airport, AVG(arrival_delay)
      FROM tutorial.flights
      WHERE YEAR(day) = 2018
      GROUP BY origin_airport, destination_airport;
      ```
    - **Optimized Query**:
      ```sql
      SELECT origin_airport, destination_airport, AVG(arrival_delay) AS avg_delay
      FROM tutorial.flights
      WHERE day = '2018-12-06'
      GROUP BY origin_airport, destination_airport;
      ```
    - **Answer**: Uses precise date filtering and ensures indexes on `day`, `origin_airport`, and `destination_airport`.

85. **Find duplicate flights (same origin, destination, and departure time).**
    - **Query**:
      ```sql
      SELECT origin_airport, destination_airport, actual_departure_time, COUNT(*) AS duplicate_count
      FROM tutorial.flights
      GROUP BY origin_airport, destination_airport, actual_departure_time
      HAVING COUNT(*) > 1;
      ```
    - **Answer**: Identifies flights with identical origin, destination, and departure time.

86. **Pivot delay types by origin airport.**
    - **Query**:
      ```sql
      SELECT origin_airport,
             AVG(carrier_delay) AS avg_carrier_delay,
             AVG(weather_delay) AS avg_weather_delay,
             AVG(late_aircraft_delay) AS avg_late_aircraft_delay
      FROM tutorial.flights
      GROUP BY origin_airport;
      ```
    - **Answer**: Aggregates average delays by type per `origin_airport`. (Note: Use PIVOT if supported.)

87. **Analyze long-haul flights (>1500 miles) without using a temporary table.**
    - **Query**:
      ```sql
      WITH LongHaulFlights AS (
          SELECT flight_number, origin_city, destination_city, distance
          FROM tutorial.flights
          WHERE distance > 1500
      )
      SELECT flight_number, origin_city, destination_city, distance
      FROM LongHaulFlights;
      ```
    - **Answer**: Uses a CTE to analyze flights with `distance` over 1500 miles.

88. **Analyze flight efficiency (air time vs. actual flight time).**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city,
             air_time / actual_flight_time AS efficiency_ratio
      FROM tutorial.flights
      WHERE actual_flight_time > 0
      ORDER BY efficiency_ratio DESC;
      ```
    - **Answer**: Computes the ratio of `air_time` to `actual_flight_time`.

89. **Detect outlier flights (delays > 3 standard deviations).**
    - **Query**:
      ```sql
      WITH DelayStats AS (
          SELECT AVG(arrival_delay) AS avg_delay,
                 STDDEV(arrival_delay) AS stddev_delay
          FROM tutorial.flights
      )
      SELECT flight_number, origin_city, destination_city, arrival_delay
      FROM tutorial.flights, DelayStats
      WHERE arrival_delay > (avg_delay + 3 * stddev_delay);
      ```
    - **Answer**: Flags flights with `arrival_delay` exceeding 3 standard deviations.

90. **Find flights with high taxi times (wheels off - departure or arrival - wheels on).**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city,
             (actual_departure_time - wheels_off_time + actual_arrival_time - wheels_on_time) AS total_taxi_time
      FROM tutorial.flights
      WHERE actual_departure_time >= wheels_off_time
      AND actual_arrival_time >= wheels_on_time
      ORDER BY total_taxi_time DESC;
      ```
    - **Answer**: Calculates taxi times (HHMM format may need conversion).

91. **Calculate the correlation between distance and arrival delay.**
    - **Query**:
      ```sql
      SELECT
          (COUNT(*) * SUM(distance * arrival_delay) - SUM(distance) * SUM(arrival_delay)) /
          SQRT((COUNT(*) * SUM(distance * distance) - POW(SUM(distance), 2)) * 
               (COUNT(*) * SUM(arrival_delay * arrival_delay) - POW(SUM(arrival_delay), 2))) AS correlation
      FROM tutorial.flights;
      ```
    - **Answer**: Computes Pearson correlation between `distance` and `arrival_delay`.

92. **Find flights with multiple delay types.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city,
             (carrier_delay > 0) + (weather_delay > 0) + (late_aircraft_delay > 0) + 
             (air_traffic_delay > 0) + (security_delay > 0) AS delay_type_count
      FROM tutorial.flights
      WHERE (carrier_delay > 0) + (weather_delay > 0) + (late_aircraft_delay > 0) + 
            (air_traffic_delay > 0) + (security_delay > 0) >= 2;
      ```
    - **Answer**: Counts and filters flights with multiple delay types.

93. **Identify flights with inconsistent air time (air time > actual flight time).**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city, air_time, actual_flight_time
      FROM tutorial.flights
      WHERE air_time > actual_flight_time;
      ```
    - **Answer**: Filters flights where `air_time` exceeds `actual_flight_time` (data quality issue).

94. **Calculate the average delay by flight number range (e.g., 2450-2475, 2476-2500).**
    - **Query**:
      ```sql
      SELECT
          CASE
              WHEN flight_number BETWEEN 2450 AND 2475 THEN '2450-2475'
              WHEN flight_number BETWEEN 2476 AND 2500 THEN '2476-2500'
              ELSE 'Other'
          END AS flight_range,
          AVG(arrival_delay) AS avg_delay
      FROM tutorial.flights
      GROUP BY flight_range;
      ```
    - **Answer**: Groups flights by `flight_number` ranges and computes average `arrival_delay`.

95. **Find flights with a significant schedule deviation (actual vs. scheduled times).**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city,
             ABS(actual_arrival_time - scheduled_arrival_time) AS arrival_deviation
      FROM tutorial.flights
      WHERE ABS(actual_arrival_time - scheduled_arrival_time) > 60;
      ```
    - **Answer**: Filters flights with arrival time deviations over 60 minutes.

96. **Calculate the variance of departure delays by origin airport.**
    - **Query**:
      ```sql
      SELECT origin_airport,
             VARIANCE(departure_delay) AS delay_variance
      FROM tutorial.flights
      GROUP BY origin_airport;
      ```
    - **Answer**: Computes the variance of `departure_delay` per `origin_airport`.

97. **Find flights with a high proportion of carrier delay to total delay.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city,
             carrier_delay / (carrier_delay + weather_delay + late_aircraft_delay + air_traffic_delay + security_delay) AS carrier_proportion
      FROM tutorial.flights
      WHERE carrier_delay > 0
      AND (carrier_delay + weather_delay + late_aircraft_delay + air_traffic_delay + security_delay) > 0
      ORDER BY carrier_proportion DESC;
      ```
    - **Answer**: Computes the proportion of `carrier_delay` to total delay.

98. **Identify flights with a significant gap between wheels-off and departure time.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city,
             ABS(wheels_off_time - actual_departure_time) AS taxi_out_time
      FROM tutorial.flights
      WHERE ABS(wheels_off_time - actual_departure_time) > 30;
      ```
    - **Answer**: Filters flights with taxi-out times over 30 minutes.

99. **Calculate the average delay for flights with specific delay types.**
    - **Query**:
      ```sql
      SELECT
          CASE
              WHEN carrier_delay > 0 THEN 'Carrier'
              WHEN weather_delay > 0 THEN 'Weather'
              WHEN late_aircraft_delay > 0 THEN 'Late Aircraft'
              WHEN air_traffic_delay > 0 THEN 'Air Traffic'
              WHEN security_delay > 0 THEN 'Security'
              ELSE 'None'
          END AS delay_type,
          AVG(arrival_delay) AS avg_delay
      FROM tutorial.flights
      GROUP BY delay_type;
      ```
    - **Answer**: Groups flights by delay type and computes average `arrival_delay`.

100. **Find flights with a high ratio of air time to distance.**
    - **Query**:
      ```sql
      SELECT flight_number, origin_city, destination_city,
             air_time / distance AS time_per_mile
      FROM tutorial.flights
      WHERE distance > 0
      ORDER BY time_per_mile DESC;
      ```
    - **Answer**: Computes the ratio of `air_time` to `distance` to assess efficiency.

## Conclusion
The **Airline Operations Analytics** capstone project provides a robust platform to master SQL through 100 interview questions, leveraging the `tutorial.flights` dataset. Covering foundational to advanced concepts, the project prepares users for analytics roles by simulating real-world airline data challenges. To extend this project, consider integrating external datasets (e.g., weather or airport traffic) or practicing on platforms like Mode.com, LeetCode, or HackerRank. The absence of temporary tables ensures compatibility with restricted environments, enhancing practical applicability.
