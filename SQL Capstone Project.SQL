-- Q1: List all flights with a departure delay greater than 30 minutes.
SELECT flight_number, origin_airport, destination_airport, departure_delay
FROM tutorial.flights
WHERE departure_delay > 30;

-- Q2: Count the number of flights per destination city.
SELECT destination_city, COUNT(*) AS flight_count
FROM tutorial.flights
GROUP BY destination_city
ORDER BY flight_count DESC;

-- Q3: Find flights that arrived early (arrival delay < 0).
SELECT flight_number, origin_city, destination_city, arrival_delay
FROM tutorial.flights
WHERE arrival_delay < 0;

-- Q4: Calculate the average flight distance.
SELECT AVG(distance) AS avg_distance
FROM tutorial.flights;

-- Q5: List the top 5 origin airports by flight count.
SELECT origin_airport, COUNT(*) AS flight_count
FROM tutorial.flights
GROUP BY origin_airport
ORDER BY flight_count DESC
LIMIT 5;

-- Q6: Find flights with air traffic control delays.
SELECT flight_number, origin_city, destination_city, air_traffic_delay
FROM tutorial.flights
WHERE air_traffic_delay > 0;

-- Q7: Calculate the total actual flight time for all flights.
SELECT SUM(actual_flight_time) AS total_flight_time_minutes
FROM tutorial.flights;

-- Q8: List flights with a distance less than 500 miles.
SELECT flight_number, origin_city, destination_city, distance
FROM tutorial.flights
WHERE distance < 500;

-- Q9: Find the flight with the longest actual flight time.
SELECT flight_number, origin_city, destination_city, actual_flight_time
FROM tutorial.flights
WHERE actual_flight_time = (SELECT MAX(actual_flight_time) FROM tutorial.flights);

-- Q10: Count flights by destination state.
SELECT destination_state, COUNT(*) AS flight_count
FROM tutorial.flights
GROUP BY destination_state
ORDER BY flight_count DESC;

-- Q11: List flights where the actual flight time differs from the scheduled flight time by more than 10 minutes.
SELECT flight_number, actual_flight_time, scheduled_flight_time
FROM tutorial.flights
WHERE ABS(actual_flight_time - scheduled_flight_time) > 10;

-- Q12: Find flights with no delays (both departure and arrival delays are 0 or negative).
SELECT flight_number, origin_city, destination_city
FROM tutorial.flights
WHERE departure_delay <= 0 AND arrival_delay <= 0;

-- Q13: Calculate the average arrival delay per origin airport.
SELECT origin_airport, AVG(arrival_delay) AS avg_arrival_delay
FROM tutorial.flights
GROUP BY origin_airport;

-- Q14: List flights with a carrier delay greater than 0.
SELECT flight_number, origin_city, destination_city, carrier_delay
FROM tutorial.flights
WHERE carrier_delay > 0;

-- Q15: Find the shortest scheduled flight time.
SELECT flight_number, origin_city, destination_city, scheduled_flight_time
FROM tutorial.flights
WHERE scheduled_flight_time = (SELECT MIN(scheduled_flight_time) FROM tutorial.flights);

-- Q16: List flights with a positive arrival delay.
SELECT flight_number, origin_city, destination_city, arrival_delay
FROM tutorial.flights
WHERE arrival_delay > 0;

-- Q17: Count flights by origin state.
SELECT origin_state, COUNT(*) AS flight_count
FROM tutorial.flights
GROUP BY origin_state
ORDER BY flight_count DESC;

-- Q18: Find flights with a distance greater than 2000 miles.
SELECT flight_number, origin_city, destination_city, distance
FROM tutorial.flights
WHERE distance > 2000;

-- Q19: Calculate the maximum arrival delay.
SELECT MAX(arrival_delay) AS max_arrival_delay
FROM tutorial.flights;

-- Q20: List flights with no cancellation.
SELECT flight_number, origin_city, destination_city
FROM tutorial.flights
WHERE was_cancelled = 'false';

-- Q21: Calculate the average air time per flight.
SELECT AVG(air_time) AS avg_air_time
FROM tutorial.flights;

-- Q22: Find flights with a scheduled departure time before 8 AM.
SELECT flight_number, origin_city, destination_city, scheduled_departure_time
FROM tutorial.flights
WHERE scheduled_departure_time < 800;

-- Q23: Count flights per airline code.
SELECT airline_code, COUNT(*) AS flight_count
FROM tutorial.flights
GROUP BY airline_code;

-- Q24: List flights with a late aircraft delay greater than 0.
SELECT flight_number, origin_city, destination_city, late_aircraft_delay
FROM tutorial.flights
WHERE late_aircraft_delay > 0;

-- Q25: Calculate the total distance flown.
SELECT SUM(distance) AS total_distance
FROM tutorial.flights;

-- Q26: Find flights with a scheduled arrival time after 10 PM.
SELECT flight_number, origin_city, destination_city, scheduled_arrival_time
FROM tutorial.flights
WHERE scheduled_arrival_time > 2200;

-- Q27: List flights with a flight number between 2450 and 2500.
SELECT flight_number, origin_city, destination_city
FROM tutorial.flights
WHERE flight_number BETWEEN 2450 AND 2500;

-- Q28: Calculate the average departure delay.
SELECT AVG(departure_delay) AS avg_departure_delay
FROM tutorial.flights;

-- Q29: Find flights with a security delay greater than 0.
SELECT flight_number, origin_city, destination_city, security_delay
FROM tutorial.flights
WHERE security_delay > 0;

-- Q30: List flights sorted by distance in descending order.
SELECT flight_number, origin_city, destination_city, distance
FROM tutorial.flights
ORDER BY distance DESC;

-- Q32: Find round-trip flights (same origin and destination airports).
SELECT f1.flight_number, f1.origin_airport, f1.destination_airport
FROM tutorial.flights f1
INNER JOIN tutorial.flights f2
ON f1.origin_airport = f2.destination_airport
AND f1.destination_airport = f2.origin_airport
WHERE f1.flight_number < f2.flight_number;

-- Q33: Calculate the average departure delay by destination city.
SELECT destination_city, AVG(departure_delay) AS avg_departure_delay
FROM tutorial.flights
GROUP BY destination_city
ORDER BY avg_departure_delay DESC;

-- Q34: List flights with a late aircraft delay and their total delay.
SELECT flight_number, origin_city, destination_city,
       (arrival_delay + departure_delay) AS total_delay,
       late_aircraft_delay
FROM tutorial.flights
WHERE late_aircraft_delay > 0;

-- Q35: Find the top 3 routes (origin to destination) by flight count.
SELECT origin_airport, destination_airport, COUNT(*) AS flight_count
FROM tutorial.flights
GROUP BY origin_airport, destination_airport
ORDER BY flight_count DESC
LIMIT 3;

-- Q36: Calculate the percentage of flights delayed (arrival delay > 0).
SELECT ROUND(COUNT(CASE WHEN arrival_delay > 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS delayed_percentage
FROM tutorial.flights;

-- Q37: List flights where the air time is less than 90% of the actual flight time.
SELECT flight_number, origin_city, destination_city, air_time, actual_flight_time
FROM tutorial.flights
WHERE air_time < 0.9 * actual_flight_time;

-- Q38: Find flights with a weather delay and their origin state.
SELECT flight_number, origin_city, origin_state, weather_delay
FROM tutorial.flights
WHERE weather_delay > 0;

-- Q39: Calculate the total distance flown by flights originating from Atlanta.
SELECT SUM(distance) AS total_distance
FROM tutorial.flights
WHERE origin_city = 'Atlanta';

-- Q40: List flights where the actual arrival time is earlier than the scheduled arrival time.
SELECT flight_number, actual_arrival_time, scheduled_arrival_time
FROM tutorial.flights
WHERE actual_arrival_time < scheduled_arrival_time;

-- Q41: Find the average flight time for flights over 1000 miles.
SELECT AVG(actual_flight_time) AS avg_flight_time
FROM tutorial.flights
WHERE distance > 1000;

-- Q42: List flights with the same origin and destination state.
SELECT flight_number, origin_city, destination_city, origin_state
FROM tutorial.flights
WHERE origin_state = destination_state;

-- Q43: Calculate the maximum departure delay per origin airport.
SELECT origin_airport, MAX(departure_delay) AS max_departure_delay
FROM tutorial.flights
GROUP BY origin_airport;

-- Q44: Find flights with a security delay.
SELECT flight_number, origin_city, destination_city, security_delay
FROM tutorial.flights
WHERE security_delay > 0;

-- Q45: List flights sorted by total delay (arrival + departure).
SELECT flight_number, origin_city, destination_city,
       (arrival_delay + departure_delay) AS total_delay
FROM tutorial.flights
ORDER BY total_delay DESC;

-- Q46: Find flights with a departure delay but no arrival delay.
SELECT flight_number, origin_city, destination_city, departure_delay
FROM tutorial.flights
WHERE departure_delay > 0 AND arrival_delay <= 0;

-- Q47: Calculate the average distance by origin city.
SELECT origin_city, AVG(distance) AS avg_distance
FROM tutorial.flights
GROUP BY origin_city;

-- Q48: List flights with actual flight time less than scheduled flight time.
SELECT flight_number, origin_city, destination_city, actual_flight_time, scheduled_flight_time
FROM tutorial.flights
WHERE actual_flight_time < scheduled_flight_time;

-- Q49: Find the top 5 destination airports by total distance flown.
SELECT destination_airport, SUM(distance) AS total_distance
FROM tutorial.flights
GROUP BY destination_airport
ORDER BY total_distance DESC
LIMIT 5;

-- Q50: Calculate the percentage of flights with any delay type.
SELECT ROUND(COUNT(CASE WHEN carrier_delay + weather_delay + late_aircraft_delay + air_traffic_delay + security_delay > 0 THEN 1 END) * 100.0 / COUNT(*), 2) AS delayed_percentage
FROM tutorial.flights;

-- Q51: List flights with a wheels-off time after scheduled departure.
SELECT flight_number, origin_city, destination_city, wheels_off_time, scheduled_departure_time
FROM tutorial.flights
WHERE wheels_off_time > scheduled_departure_time;

-- Q52: Find flights with the same origin and destination city.
SELECT flight_number, origin_city, destination_city
FROM tutorial.flights
WHERE origin_city = destination_city;

-- Q53: Calculate the total air traffic delay by destination state.
SELECT destination_state, SUM(air_traffic_delay) AS total_air_traffic_delay
FROM tutorial.flights
GROUP BY destination_state;

-- Q54: List flights with a flight number divisible by 2.
SELECT flight_number, origin_city, destination_city
FROM tutorial.flights
WHERE MOD(flight_number, 2) = 0;

-- Q55: Find flights with a departure delay greater than the average departure delay.
SELECT flight_number, origin_city, destination_city, departure_delay
FROM tutorial.flights
WHERE departure_delay > (SELECT AVG(departure_delay) FROM tutorial.flights);

-- Q56: Calculate the minimum actual flight time per origin airport.
SELECT origin_airport, MIN(actual_flight_time) AS min_flight_time
FROM tutorial.flights
GROUP BY origin_airport;

-- Q57: List flights with a wheels-on time before actual arrival time.
SELECT flight_number, origin_city, destination_city, wheels_on_time, actual_arrival_time
FROM tutorial.flights
WHERE wheels_on_time < actual_arrival_time;

-- Q58: Find flights with a distance less than the average distance.
SELECT flight_number, origin_city, destination_city, distance
FROM tutorial.flights
WHERE distance < (SELECT AVG(distance) FROM tutorial.flights);

-- Q59: Calculate the total carrier delay by origin city.
SELECT origin_city, SUM(carrier_delay) AS total_carrier_delay
FROM tutorial.flights
GROUP BY origin_city;

-- Q60: List flights with a scheduled flight time greater than 3 hours.
SELECT flight_number, origin_city, destination_city, scheduled_flight_time
FROM tutorial.flights
WHERE scheduled_flight_time > 180;

-- Q62: Rank flights by arrival delay within each origin airport.
SELECT flight_number, origin_airport, destination_city, arrival_delay,
       RANK() OVER (PARTITION BY origin_airport ORDER BY arrival_delay DESC) AS delay_rank
FROM tutorial.flights;

-- Q63: Calculate the running total of flight distances by flight number.
SELECT flight_number, origin_city, destination_city, distance,
       SUM(distance) OVER (ORDER BY flight_number) AS running_distance
FROM tutorial.flights;

-- Q64: Find the top 3 flights by departure delay per destination state.
WITH RankedFlights AS (
    SELECT flight_number, origin_city, destination_state, departure_delay,
           RANK() OVER (PARTITION BY destination_state ORDER BY departure_delay DESC) AS rank
    FROM tutorial.flights
)
SELECT flight_number, origin_city, destination_state, departure_delay
FROM RankedFlights
WHERE rank <= 3;

-- Q65: Calculate the average arrival delay for flights departing within 1 hour of each flight.
SELECT flight_number, actual_departure_time, arrival_delay,
       AVG(arrival_delay) OVER (
           ORDER BY actual_departure_time
           RANGE BETWEEN 60 PRECEDING AND 60 FOLLOWING
       ) AS avg_delay_nearby
FROM tutorial.flights;

-- Q66: Find flights with above-average arrival delays for their origin airport.
WITH AirportDelays AS (
    SELECT origin_airport, AVG(arrival_delay) AS avg_delay
    FROM tutorial.flights
    GROUP BY origin_airport
)
SELECT f.flight_number, f.origin_airport, f.arrival_delay
FROM tutorial.flights f
INNER JOIN AirportDelays ad ON f.origin_airport = ad.origin_airport
WHERE f.arrival_delay > ad.avg_delay;

-- Q67: Calculate the percentage contribution of each flight’s distance to the total distance.
SELECT flight_number, origin_city, destination_city, distance,
       ROUND(distance / SUM(distance) OVER () * 100, 2) AS distance_percentage
FROM tutorial.flights;

-- Q68: Find the 5th longest flight by actual flight time.
SELECT flight_number, actual_flight_time
FROM (
    SELECT flight_number, actual_flight_time,
           DENSE_RANK() OVER (ORDER BY actual_flight_time DESC) AS rank
    FROM tutorial.flights
) ranked
WHERE rank = 5;

-- Q69: List flights with consecutive departure times within 30 minutes from the same airport.
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

-- Q70: Calculate the month-over-month delay trend (assuming more data).
WITH MonthlyDelays AS (
    SELECT DATE_FORMAT(day, '%Y-%m') AS month,
           AVG(arrival_delay) AS avg_delay
    FROM tutorial.flights
    GROUP BY DATE_FORMAT(day, '%Y-%m')
)
SELECT month, avg_delay,
       avg_delay - LAG(avg_delay) OVER (ORDER BY month) AS delay_change
FROM MonthlyDelays;

-- Q71: Rank flights by distance within each destination city.
SELECT flight_number, destination_city, distance,
       RANK() OVER (PARTITION BY destination_city ORDER BY distance DESC) AS distance_rank
FROM tutorial.flights;

-- Q72: Calculate the cumulative arrival delay by origin airport.
SELECT flight_number, origin_airport, arrival_delay,
       SUM(arrival_delay) OVER (PARTITION BY origin_airport ORDER BY flight_number) AS cumulative_delay
FROM tutorial.flights;

-- Q73: Find flights with the highest departure delay in each origin state.
WITH RankedFlights AS (
    SELECT flight_number, origin_state, departure_delay,
           RANK() OVER (PARTITION BY origin_state ORDER BY departure_delay DESC) AS rank
    FROM tutorial.flights
)
SELECT flight_number, origin_state, departure_delay
FROM RankedFlights
WHERE rank = 1;

-- Q74: Calculate the moving average of air time for the last 5 flights.
SELECT flight_number, air_time,
       AVG(air_time) OVER (
           ORDER BY flight_number
           ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
       ) AS moving_avg_air_time
FROM tutorial.flights;

-- Q75: List flights with below-average distance for their destination airport.
WITH AirportDistances AS (
    SELECT destination_airport, AVG(distance) AS avg_distance
    FROM tutorial.flights
    GROUP BY destination_airport
)
SELECT f.flight_number, f.destination_airport, f.distance
FROM tutorial.flights f
INNER JOIN AirportDistances ad ON f.destination_airport = ad.destination_airport
WHERE f.distance < ad.avg_distance;

-- Q76: Find the 3rd shortest flight by scheduled flight time.
SELECT flight_number, scheduled_flight_time
FROM (
    SELECT flight_number, scheduled_flight_time,
           DENSE_RANK() OVER (ORDER BY scheduled_flight_time ASC) AS rank
    FROM tutorial.flights
) ranked
WHERE rank = 3;

-- Q77: Calculate the difference in arrival delay from the previous flight at the same airport.
SELECT flight_number, origin_airport, arrival_delay,
       arrival_delay - LAG(arrival_delay) OVER (
           PARTITION BY origin_airport ORDER BY actual_departure_time
       ) AS delay_difference
FROM tutorial.flights;

-- Q78: List flights with the top 10% of distances.
SELECT flight_number, origin_city, destination_city, distance
FROM (
    SELECT flight_number, origin_city, destination_city, distance,
           NTILE(10) OVER (ORDER BY distance DESC) AS distance_decile
    FROM tutorial.flights
) ranked
WHERE distance_decile = 1;

-- Q79: Calculate the median departure delay (approximate).
SELECT AVG(departure_delay) AS median_delay
FROM (
    SELECT departure_delay,
           ROW_NUMBER() OVER (ORDER BY departure_delay) AS row_num,
           COUNT(*) OVER () AS total_rows
    FROM tutorial.flights
) ranked
WHERE row_num IN (FLOOR((total_rows + 1)/2), CEIL((total_rows + 1)/2));

-- Q80: Find flights with a rank in the top 5 by air time per origin city.
WITH RankedFlights AS (
    SELECT flight_number, origin_city, air_time,
           RANK() OVER (PARTITION BY origin_city ORDER BY air_time DESC) AS rank
    FROM tutorial.flights
)
SELECT flight_number, origin_city, air_time
FROM RankedFlights
WHERE rank <= 5;

-- Q82: Write a stored procedure to flag flights with excessive delays (>60 minutes).
DELIMITER //
CREATE PROCEDURE FlagExcessiveDelays()
BEGIN
    CREATE TABLE IF NOT EXISTS delayed_flights AS
    SELECT flight_number, origin_city, destination_city, arrival_delay
    FROM tutorial.flights
    WHERE arrival_delay > 60;
END //
DELIMITER ;

-- Q83: Create a trigger to log flights with weather delays.
CREATE TABLE delay_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    flight_number FLOAT,
    weather_delay FLOAT,
    log_time TIMESTAMP
);

DELIMITER //
CREATE TRIGGER LogWeatherDelays
AFTER INSERT ON tutorial.flights
FOR EACH ROW
BEGIN
    IF NEW.weather_delay > 0 THEN
        INSERT INTO delay_log (flight_number, weather_delay, log_time)
        VALUES (NEW.flight_number, NEW.weather_delay, NOW());
    END IF;
END //
DELIMITER ;

-- Q84: Optimize a slow query for average delays by route.
SELECT origin_airport, destination_airport, AVG(arrival_delay) AS avg_delay
FROM tutorial.flights
WHERE day = '2018-12-06'
GROUP BY origin_airport, destination_airport;

-- Q85: Find duplicate flights (same origin, destination, and departure time).
SELECT origin_airport, destination_airport, actual_departure_time, COUNT(*) AS duplicate_count
FROM tutorial.flights
GROUP BY origin_airport, destination_airport, actual_departure_time
HAVING COUNT(*) > 1;

-- Q86: Pivot delay types by origin airport.
SELECT origin_airport,
       AVG(carrier_delay) AS avg_carrier_delay,
       AVG(weather_delay) AS avg_weather_delay,
       AVG(late_aircraft_delay) AS avg_late_aircraft_delay
FROM tutorial.flights
GROUP BY origin_airport;

-- Q87: Analyze long-haul flights (>1500 miles) without using a temporary table.
WITH LongHaulFlights AS (
    SELECT flight_number, origin_city, destination_city, distance
    FROM tutorial.flights
    WHERE distance > 1500
)
SELECT flight_number, origin_city, destination_city, distance
FROM LongHaulFlights;

-- Q88: Analyze flight efficiency (air time vs. actual flight time).
SELECT flight_number, origin_city, destination_city,
       air_time / actual_flight_time AS efficiency_ratio
FROM tutorial.flights
WHERE actual_flight_time > 0
ORDER BY efficiency_ratio DESC;

-- Q89: Detect outlier flights (delays > 3 standard deviations).
WITH DelayStats AS (
    SELECT AVG(arrival_delay) AS avg_delay,
           STDDEV(arrival_delay) AS stddev_delay
    FROM tutorial.flights
)
SELECT flight_number, origin_city, destination_city, arrival_delay
FROM tutorial.flights, DelayStats
WHERE arrival_delay > (avg_delay + 3 * stddev_delay);

-- Q90: Find flights with high taxi times (wheels off - departure or arrival - wheels on).
SELECT flight_number, origin_city, destination_city,
       (actual_departure_time - wheels_off_time + actual_arrival_time - wheels_on_time) AS total_taxi_time
FROM tutorial.flights
WHERE actual_departure_time >= wheels_off_time
AND actual_arrival_time >= wheels_on_time
ORDER BY total_taxi_time DESC;

-- Q91: Calculate the correlation between distance and arrival delay.
SELECT
    (COUNT(*) * SUM(distance * arrival_delay) - SUM(distance) * SUM(arrival_delay)) /
    SQRT((COUNT(*) * SUM(distance * distance) - POW(SUM(distance), 2)) * 
         (COUNT(*) * SUM(arrival_delay * arrival_delay) - POW(SUM(arrival_delay), 2))) AS correlation
FROM tutorial.flights;

-- Q92: Find flights with multiple delay types.
SELECT flight_number, origin_city, destination_city,
       (carrier_delay > 0) + (weather_delay > 0) + (late_aircraft_delay > 0) + 
       (air_traffic_delay > 0) + (security_delay > 0) AS delay_type_count
FROM tutorial.flights
WHERE (carrier_delay > 0) + (weather_delay > 0) + (late_aircraft_delay > 0) + 
      (air_traffic_delay > 0) + (security_delay > 0) >= 2;

-- Q93: Identify flights with inconsistent air time (air time > actual flight time).
SELECT flight_number, origin_city, destination_city, air_time, actual_flight_time
FROM tutorial.flights
WHERE air_time > actual_flight_time;

-- Q94: Calculate the average delay by flight number range (e.g., 2450-2475, 2476-2500).
SELECT
    CASE
        WHEN flight_number BETWEEN 2450 AND 2475 THEN '2450-2475'
        WHEN flight_number BETWEEN 2476 AND 2500 THEN '2476-2500'
        ELSE 'Other'
    END AS flight_range,
    AVG(arrival_delay) AS avg_delay
FROM tutorial.flights
GROUP BY flight_range;

-- Q95: Find flights with a significant schedule deviation (actual vs. scheduled times).
SELECT flight_number, origin_city, destination_city,
       ABS(actual_arrival_time - scheduled_arrival_time) AS arrival_deviation
FROM tutorial.flights
WHERE ABS(actual_arrival_time - scheduled_arrival_time) > 60;

-- Q96: Calculate the variance of departure delays by origin airport.
SELECT origin_airport,
       VARIANCE(departure_delay) AS delay_variance
FROM tutorial.flights
GROUP BY origin_airport;

-- Q97: Find flights with a high proportion of carrier delay to total delay.
SELECT flight_number, origin_city, destination_city,
       carrier_delay / (carrier_delay + weather_delay + late_aircraft_delay + air_traffic_delay + security_delay) AS carrier_proportion
FROM tutorial.flights
WHERE carrier_delay > 0
AND (carrier_delay + weather_delay + late_aircraft_delay + air_traffic_delay + security_delay) > 0
ORDER BY carrier_proportion DESC;

-- Q98: Identify flights with a significant gap between wheels-off and departure time.
SELECT flight_number, origin_city, destination_city,
       ABS(wheels_off_time - actual_departure_time) AS taxi_out_time
FROM tutorial.flights
WHERE ABS(wheels_off_time - actual_departure_time) > 30;
