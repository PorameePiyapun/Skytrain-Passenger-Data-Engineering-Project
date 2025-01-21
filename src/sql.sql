-- CREATE DATABASE sky_train;
-- USE sky_train;
-- CREATE TABLE skytrain_data;
-- SELECT * FROM skytrain_data;

-- //Peak Passenger All Stations
-- SELECT 
--     station,
--     SUM(passengers_entering + passengers_exiting) AS all_passengers
-- FROM 
--     skytrain_data
-- GROUP BY 
--     station
-- ORDER BY 
--     all_passengers DESC;
 

-- // Peak Hours All Stations
-- SELECT 
--     station,
--     HOUR(time) AS hour,
--     SUM(passengers_entering + passengers_exiting) AS total_passengers
-- FROM 
--     skytrain_data
-- GROUP BY 
--     station, hour
-- ORDER BY 
--     total_passengers DESC
-- LIMIT 10; 

-- //Total Passenger by Hours
-- SELECT 
--     HOUR(time) AS hour,
--     SUM(passengers_entering + passengers_exiting) AS total_passengers
-- FROM 
--     skytrain_data
-- GROUP BY 
--     hour
-- ORDER BY 
--     total_passengers DESC
-- LIMIT 10; 

-- //Total Passenger by DayofWeek
-- SELECT 
--     DAYNAME(date) AS day_of_week,
--     SUM(passengers_entering + passengers_exiting) AS total_passengers
-- FROM 
--     skytrain_data
-- GROUP BY 
--     day_of_week
-- ORDER BY 
--     total_passengers DESC;

-- //Total Passenger by DayTime
-- SELECT 
--     CASE
--         WHEN HOUR(time) BETWEEN 5 AND 11 THEN 'Morning'
--         WHEN HOUR(time) BETWEEN 12 AND 16 THEN 'Afternoon'
--         WHEN HOUR(time) BETWEEN 17 AND 21 THEN 'Evening'
--         ELSE 'Night'
--     END AS time_of_day,
--     SUM(passengers_entering + passengers_exiting) AS total_passengers
-- FROM 
--    skytrain_data
-- GROUP BY 
--     time_of_day
-- ORDER BY 
--     total_passengers DESC;



