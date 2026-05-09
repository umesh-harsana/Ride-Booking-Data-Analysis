# Ride Booking Data Analysis

## Project Overview
This project analyzes ride booking operations of an online ride-hailing platform to identify booking trends, cancellation patterns, revenue performance, and vehicle-wise performance.

The project was built using:
- Excel for initial preprocessing and dataset preparation
- SQL for data cleaning and analysis
- Power BI for dashboard creation and visualization

The main objective of the project is to analyze operational inefficiencies, understand ride demand patterns, and identify factors affecting ride completion and revenue generation.

---

## Tools & Technologies Used
- Microsoft Excel
- MySQL
- Power BI

---

## Dataset Information
The dataset contains ride booking records including:
- Booking details
- Booking status
- Cancellation reasons
- Vehicle types
- Pickup & drop locations
- Ride distance
- Revenue
- Customer & driver ratings
- Day-wise and hour-wise ride activity

Total Records: **20,407**

---

# Project Workflow

## Data Cleaning (SQL)
Performed data cleaning and preprocessing using SQL:
- Removed unnecessary columns
- Trimmed unwanted spaces
- Handled missing values
- Converted blank values to NULL
- Corrected data types
- Cleaned rating columns
- Standardized booking status values

## Data Analysis (SQL)

### Booking Analysis
- Total bookings
- Completed rides
- Cancelled rides
- Incomplete rides
- Completion rate
- Cancellation rate

### Revenue Analysis
- Total revenue generated
- Revenue loss due to cancellations
- Revenue by booking status
- Revenue by vehicle type

### Demand Analysis
- Hour-wise booking trend
- Day-wise booking trend
- Peak demand hours
- Peak revenue hours

### Cancellation Analysis
- Cancellation reasons
- Hour-wise cancellation rate
- Day-wise cancellation rate
- Cancellation rate by vehicle type

### Vehicle Analysis
- Vehicle-wise bookings
- Vehicle-wise revenue
- Average ride distance by vehicle type

### Customer Experience Analysis
- Average customer rating
- Average driver rating

---

## Power BI Dashboard

The Power BI dashboard was divided into multiple analytical sections using page navigation:

### 1. Overall Analysis

![images](dashboard_overall.png)

Includes:
- KPI metrics
- Booking status distribution
- Revenue analysis
- Day-wise booking trend
- Hour-wise booking trend

### 2. Cancellation Analysis

![images](dashboard_cancellation.png)

Includes:
- Cancellation rate analysis
- Hour-wise cancellation trend
- Day-wise cancellation analysis
- Cancellation reasons
- Vehicle-wise cancellation rate

### 3. Vehicle Type Analysis

![images](dashboard_vehicle_type.png)

Includes:
- Vehicle-wise bookings
- Revenue by vehicle type
- Average ride distance by vehicle type

---

# Key Insights

- The platform achieved a **64.9% ride completion rate**.
- Nearly **29.3% of rides were cancelled**, indicating operational inefficiencies during peak demand periods.
- Morning hours showed the highest booking demand and revenue generation.
- Weekdays recorded significantly higher ride demand than weekends.
- Driver-side cancellations contributed more heavily to booking failures.
- Premium vehicle categories generated the highest revenue.
- Customer ratings remained consistently high across vehicle categories.

---

# Business Recommendations

- Improve driver availability during peak demand hours.
- Reduce driver-side cancellations through better allocation strategies.
- Introduce surge balancing during high-demand periods.
- Focus operational improvements on high-cancellation hours.
- Optimize premium vehicle deployment for higher revenue generation.

---

# Dashboard Features

- Interactive slicers
- Multi-page navigation
- Dynamic KPI cards
- Drill-down analysis
- Responsive filtering
- Business-focused visual storytelling

---

# Files Included
- Cleaned Dataset
- SQL Queries
- Power BI Dashboard (.pbix)
- Dashboard Screenshots
- Project Report

---

# Conclusion
This project demonstrates end-to-end data analytics workflow including:
- Data cleaning
- SQL-based analysis
- Business insight generation
- Interactive dashboard development

The project highlights how ride-booking data can be used to identify operational bottlenecks, improve customer experience, and optimize revenue performance.
