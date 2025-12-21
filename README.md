📊 Customer Segmentation Dashboard (RFM Analysis)

📌 Project Overview

This project implements a Customer Segmentation Dashboard using RFM (Recency, Frequency, Monetary) analysis to identify meaningful customer groups and support data-driven business decisions. The analysis was performed using SQL for data processing and scoring, and Tableau for interactive visualization.

Three raw datasets—customers, products, and orders—were ingested into SQL. From these, a consolidated RFM metrics table and RFM scoring model (1–5) were built and used to segment customers into actionable categories such as Champions, Loyal Customers, Potential Loyalists, Big Spenders, At Risk, Need Attention, Hibernating, and Lost Customers.

🗂 Data Sources

1. Customers – demographic and customer-level details
2. Products – product catalog and attributes
3. Orders – transactional purchase history linking customers and products

These datasets were joined and transformed in SQL to create a clean analytical base.

🧠 Methodology
1. RFM Metrics
2. Recency – days since last purchase
3. Frequency – number of purchases
4. Monetary – total spend

SQL Techniques Used
1. Window functions for R, F, M scoring (1–5)
2. Aggregations and joins across multiple tables
3. CASE logic to assign customer segments based on RFM score combinations

📈 Tableau Dashboard Features
1. Recency, Frequency, and Monetary distribution charts with total sales
2. Customer segmentation bar chart showing segment sizes
3. Frequency vs Monetary scatter plot for value vs engagement analysis
4. RFM heatmap for high-level segmentation insights

Interactive filters allow exploration by segment and RFM score.

🛠 Tools & Technologies
1. SQL – data cleaning, aggregation, window functions, segmentation logic
2. Tableau – dashboard design and visual storytelling

🎯 Key Outcomes

This project demonstrates how raw transactional data can be transformed into actionable customer segments. It highlights practical skills in SQL-based feature engineering, analytical modeling, and business-focused dashboarding, suitable for marketing, CRM, and growth analytics use cases.
