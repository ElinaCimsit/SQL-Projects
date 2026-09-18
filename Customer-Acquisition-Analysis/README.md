# Customer Acquisition Analysis

SQL project focused on customer acquisition, order behavior, revenue performance, and sales channel analysis.

## Project Overview

This learning project demonstrates how SQL and SQLite can be used to create and analyze a relational database, connect customer and order data, compare acquisition channels, and identify revenue patterns.

The project includes database setup, table relationships, indexing, customer segmentation, acquisition channel analysis, order channel analysis, payment method analysis, and monthly revenue dynamics.

## Business Goal

The goal of this project was to:

- Analyze customer acquisition channels
- Compare channel performance by revenue and number of orders
- Analyze acquisition channels among female customers
- Compare order channels
- Analyze payment method performance
- Track monthly order and revenue dynamics
- Identify patterns that can support marketing and sales decisions

## Database Structure

The analysis is based on two related tables.

### customers

Contains customer-level information, including:

- user ID
- first name
- last name
- email
- gender
- age
- city
- acquisition channel
- registration date

### orders

Contains transaction-level information, including:

- order ID
- user ID
- registration date
- order date
- purchase amount
- order channel
- payment method
- items count
- delivery days
- order status

The tables are connected through `user_id`.

A foreign key relationship was created from `orders.user_id` to `customers.user_id`.

Indexes were created on:

- `orders.user_id`
- `orders.order_date`

to improve query performance.

## SQL Skills Used

- CREATE TABLE
- PRIMARY KEY
- FOREIGN KEY
- JOIN
- WHERE
- GROUP BY
- ORDER BY
- LIMIT
- COUNT
- COUNT DISTINCT
- SUM
- AVG
- ROUND
- strftime()
- Index creation
- Data aggregation
- Customer segmentation
- Revenue analysis

## What I Did

- Created the `customers` and `orders` tables
- Defined primary and foreign key relationships
- Added indexes to support query performance
- Imported customer and order datasets into SQLite
- Joined customer and order data
- Analyzed acquisition channel performance
- Segmented female customers for separate channel analysis
- Compared order channel performance
- Analyzed payment methods
- Calculated monthly order and revenue dynamics
- Summarized business findings based on SQL query results

## Business Questions

The analysis answered questions such as:

1. Which acquisition channels generate the highest revenue?
2. Which acquisition channels perform best among female customers?
3. Which channels generate the largest number of orders?
4. How does average order value differ between acquisition channels?
5. Which order channels perform best?
6. Which payment methods generate the most revenue?
7. How do orders and revenue change from month to month?

## Key Insights

### Female Customer Acquisition

Among female customers:

- **Instagram** was the strongest acquisition channel.
- Instagram generated **$190,547.29** in revenue.
- It generated **1,441 orders** from **368 female customers**.
- Facebook ranked second with **$173,199.93** in revenue.
- Google Ads ranked third with **$151,057.28** in revenue.
- Average order value was relatively similar across the leading channels, at approximately **$131–132**.

This indicates that differences in revenue between the leading acquisition channels were driven mainly by customer and order volume rather than by large differences in average order value.

### Monthly Revenue Dynamics

Monthly analysis showed noticeable changes in order volume and revenue throughout 2025.

- Revenue increased from **$71,546.12 in January** to a peak of **$179,603.16 in August**.
- August also had the highest order volume, with **1,409 orders**.
- July was another strong month with **1,299 orders** and **$176,556.40** in revenue.
- Revenue decreased toward the end of the year, reaching **$122,947.42 in December**.
- Average order value remained relatively stable compared with the larger changes in total revenue and order count.

This suggests that monthly revenue performance was influenced more strongly by order volume than by changes in average order value.

## Database Schema

The database contains two related tables and uses a foreign key relationship between customers and orders.

![Database Schema](screenshots/database-schema.png)

## Acquisition Channel Analysis

The following query analyzes the top acquisition channels among female customers using customer count, order count, revenue, and average order value.

![Acquisition Channels Result](screenshots/acquisition-channels-result.png)

## Monthly Revenue Analysis

The following query analyzes monthly order volume, revenue, and average order value.

![Monthly Revenue Result](screenshots/monthly-revenue-result.png)

## Project Files

### SQL

[View the full SQL analysis](sql/customer-acquisition-analysis.sql)

### Datasets

- [customers.csv](data/customers.csv)
- [orders.csv](data/orders.csv)

### SQLite Database

[Open the SQLite database file](database/Store_Database)

