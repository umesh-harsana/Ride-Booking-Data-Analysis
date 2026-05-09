-- ==============================================================================================================
-- Ride Booking Data Analysis
-- Author: Umesh Harsana
-- ==============================================================================================================

-- creating database

CREATE DATABASE ride_project;
USE ride_project;

-- ------------------------------------------TABLE---------------------------------------------------------------

-- creating table

CREATE TABLE rides (
    Date VARCHAR(20),
    Day VARCHAR(20),
    Time VARCHAR(20),
    Hour INT,
    Booking_ID VARCHAR(50),
    Booking_Status VARCHAR(50),
    Cancel_Reason VARCHAR(100),
    Customer_ID VARCHAR(50),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    Booking_Value FLOAT,
    Ride_Distance FLOAT,
    Driver_Rating VARCHAR(20),
    Customer_Rating VARCHAR(20)
);

-- importing data

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataset.csv'
INTO TABLE rides
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
Date,
Day,
Time,
Hour,
Booking_ID,
Booking_Status,
Cancel_Reason,
Customer_ID,
Vehicle_Type,
Pickup_Location,
Drop_Location,
Booking_Value,
Ride_Distance,
Driver_Rating,
Customer_Rating
);

-- checking data

SELECT * FROM rides LIMIT 10;

-- ------------------------------------------DATA CLEANING------------------------------------------------------

-- checking duplicate rows

SELECT Booking_ID, COUNT(*)
FROM rides
GROUP BY Booking_ID
HAVING COUNT(*) > 1;
-- NO DUPLICATES FOUND
-- ---------------------

-- checking for missing values in ratings

SELECT Booking_Status, Driver_Rating, Customer_Rating
FROM rides
LIMIT 10;
-- VALUES MISSING FOR CANCELLED AND IMCOMPLETE RIDES

SET SQL_SAFE_UPDATES = 0;

-- removing spaces if any

UPDATE rides
SET Driver_Rating = TRIM(Driver_Rating);

UPDATE rides
SET Customer_Rating = TRIM(Customer_Rating);

-- changing missing values with NULL

UPDATE rides
SET Driver_Rating = NULL
WHERE Driver_Rating = "";

UPDATE rides
SET Customer_Rating = NULL
WHERE Customer_Rating NOT REGEXP '^[0-9.]+$';

-- changing datatype to FLOAT

ALTER TABLE rides
MODIFY Driver_Rating FLOAT;

ALTER TABLE rides
MODIFY Customer_Rating FLOAT;

DESCRIBE rides;
-- --------------------------

-- trimming text columns so they do not contain any unwanted empty spaces

UPDATE rides
SET Booking_Status = TRIM(Booking_Status);

UPDATE rides
SET Cancel_Reason = TRIM(Cancel_Reason);

UPDATE rides
SET Vehicle_Type = TRIM(Vehicle_Type);

UPDATE rides
SET Pickup_Location = TRIM(Pickup_Location);

UPDATE rides
SET Drop_Location = TRIM(Drop_Location);
-- ----------------------------------

-- checking consistency

-- if rating > 5

SELECT COUNT(*)
FROM rides
WHERE Driver_Rating > 5
OR Customer_Rating > 5;

-- if booking value < 0

SELECT COUNT(*)
FROM rides
WHERE Booking_Value < 0;

SELECT DISTINCT Booking_Status
FROM rides;

SELECT DISTINCT Cancel_Reason
FROM rides;
-- MISSING VALUES WHERE BOOKING WAS SUCCESSFUL

-- changing missing values to NULL

UPDATE rides
SET Cancel_Reason = NULL
WHERE Cancel_Reason = "";

SET SQL_SAFE_UPDATES = 1;
-- -------------------------

-- checking NULL counts

SELECT
	SUM(CASE WHEN Driver_Rating IS NULL THEN 1 ELSE 0 END) AS Driver_Rating_Nulls,
	SUM(CASE WHEN Customer_Rating IS NULL THEN 1 ELSE 0 END) AS Customer_Rating_Nulls,
	SUM(CASE WHEN Cancel_Reason IS NULL THEN 1 ELSE 0 END) AS Cancel_Reason_Nulls
FROM rides;

-- ----------------------------------------------ANALYSIS--------------------------------------------------------

-- Total Bookings

SELECT COUNT(*) AS Total_Bookings
FROM rides;
-- 20407

-- Booking Status distribution

SELECT 
    Booking_Status,
    COUNT(*) AS Total_Rides
FROM rides
GROUP BY Booking_Status
ORDER BY Total_Rides DESC;

-- Completion Rate

SELECT 
ROUND(
SUM(CASE WHEN Booking_Status = 'Completed' THEN 1 ELSE 0 END) * 100.0
/ COUNT(*), 2)
AS Completion_Rate
FROM rides;
-- 64.9%

-- Cancellation Rate

SELECT 
ROUND(
SUM(CASE WHEN Booking_Status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0
/ COUNT(*), 2)
AS Cancellation_Rate
FROM rides;
-- 29.3%

-- Hour wise distribution

SELECT 
    Hour,
    COUNT(*) AS Total_Bookings
FROM rides
GROUP BY Hour
ORDER BY Hour;
-- PEAK HOURS: 6 AM to 9 AM

-- Hour vs Booking Status

SELECT 
    Hour,
    Booking_Status,
    COUNT(*) AS Total_Rides
FROM rides
GROUP BY Hour, Booking_Status
ORDER BY Hour;
-- HIGHEST CANCELLATION IN PEAK HOURS
-- SUGGESTING DEMAND-SUPPLY MISMATCH

-- Day wise distribution

SELECT 
    Day,
    COUNT(*) AS Total_Bookings
FROM rides
GROUP BY Day
ORDER BY Total_Bookings DESC;
-- LESS DEMAND DURING WEEKENDS

-- Revenue analysis

SELECT 
    Booking_Status,
    SUM(Booking_Value) AS Total_Revenue
FROM rides
GROUP BY Booking_Status;
-- COMPLETED: 7.2 M, CANCELLED: 3.2 M, ICOMPLETE: 627k
-- REVENUE LOST: 3.8 M

-- Vehicle type booking distribution

SELECT 
    Vehicle_Type,
    COUNT(*) AS Total_Rides
FROM rides
GROUP BY Vehicle_Type
ORDER BY Total_Rides DESC;

-- Vehicle type revenue distribution

SELECT 
    Vehicle_Type,
    SUM(Booking_Value) AS Revenue
FROM rides
GROUP BY Vehicle_Type
ORDER BY Revenue DESC;

-- Vehicle wise avg ride distance

SELECT 
    Vehicle_Type,
    ROUND(AVG(Ride_Distance),2) AS Avg_Distance
FROM rides
GROUP BY Vehicle_Type
ORDER BY Avg_Distance DESC;

-- Vehicle wise rating

SELECT 
    Vehicle_Type,
    ROUND(AVG(Customer_Rating),1) AS Avg_Customer_Rating,
    ROUND(AVG(Driver_Rating),1) AS Avg_Driver_Rating
FROM rides
GROUP BY Vehicle_Type;

-- Cancellation reason

SELECT 
    Cancel_Reason,
    COUNT(*) AS Total_Cancellations
FROM rides
WHERE Cancel_Reason IS NOT NULL
GROUP BY Cancel_Reason
ORDER BY Total_Cancellations DESC;

-- Peak Revenue Hour

SELECT 
    Hour,
    SUM(Booking_Value) AS Revenue
FROM rides
GROUP BY Hour
ORDER BY Revenue DESC;
-- PEAK AT 7 AM

-- top pickup locations

SELECT 
    Pickup_Location,
    COUNT(*) AS Total_Rides
FROM rides
GROUP BY Pickup_Location
ORDER BY Total_Rides DESC
LIMIT 10;

-- top drop locations

SELECT 
    Drop_Location,
    COUNT(*) AS Total_Rides
FROM rides
GROUP BY Drop_Location
ORDER BY Total_Rides DESC
LIMIT 10;

-- top customers by bookings

SELECT 
    Customer_ID,
    COUNT(*) AS Total_Rides
FROM rides
GROUP BY Customer_ID
ORDER BY Total_Rides DESC
LIMIT 10;

-- top customers by revenue

SELECT 
    Customer_ID,
    COUNT(*) AS Total_Rides,
    SUM(Booking_Value) AS Total_Revenue
FROM rides
GROUP BY Customer_ID
ORDER BY Total_Revenue DESC
LIMIT 10;

-- -------------------------------------------------------------------------------------------------------------

-- exporting data

SELECT COUNT(*) FROM rides;
SELECT * FROM rides LIMIT 20407;