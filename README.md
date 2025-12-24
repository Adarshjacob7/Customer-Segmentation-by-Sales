<h1>Customer Segementation dashboard by Sales</h1>

 ### [LINK TO BE UPLOADED](https://youtu.be/7eJexJVCqJo)

<h2>Description</h2>
This project implements a Customer Segmentation Dashboard using RFM (Recency, Frequency, Monetary) analysis to identify meaningful customer groups and support data-driven business decisions. The analysis was performed using SQL for data processing and scoring, and Tableau for interactive visualization.

Three raw datasets—customers, products, and orders—were ingested into SQL. From these, a consolidated RFM metrics table and RFM scoring model (1–5) were built and used to segment customers into actionable categories such as Champions, Loyal Customers, Potential Loyalists, Big Spenders, At Risk, Need Attention, Hibernating, and Lost Customers.

<br />
<h2>Data Sources</h2>

1. Customers – demographic and customer-level details
2. Products – product catalog and attributes
3. Orders – transactional purchase history linking customers and products

These datasets were joined and transformed in SQL to create a clean analytical base.

<br />

<h2>Methodology</h2>

1. RFM Metrics
2. Recency – days since last purchase
3. Frequency – number of purchases
4. Monetary – total spend

<br />

<h2>Languages and Utilities Used</h2>

- <b>SQL – data cleaning, aggregation, window functions, segmentation logic</b> 
- <b>Tableau – dashboard design and visual storytelling</b>

<br />

<h2>SQL Techniques Used</h2>

1. Window functions for R, F, M scoring (1–5)
2. Aggregations and joins across multiple tables
3. CASE logic to assign customer segments based on RFM score combinations

<br />

<h2>Tableau Dashboard Features</h2>

1. Recency, Frequency, and Monetary distribution charts with total sales
2. Customer segmentation bar chart showing segment sizes
3. Frequency vs Monetary scatter plot for value vs engagement analysis
4. RFM heatmap for high-level segmentation insights

Interactive filters allow exploration by segment and RFM score.

<br />

<h2>Key Outcomes </h2>

This project demonstrates how raw transactional data can be transformed into actionable customer segments. It highlights practical skills in SQL-based feature engineering, analytical modeling, and business-focused dashboarding, suitable for marketing, CRM, and growth analytics use cases.

<br />

<h2>TABLEAU SNAPSHOTS:</h2>



<p align="center">
Tableau Dashboard: <br/>
<img width="1244" height="843" alt="Screenshot (545)" src="https://github.com/user-attachments/assets/7a338219-99db-4bfb-8ff3-1816d7a99ae1" />
<br />
<br />
Filtering by Segment- for Champions:  <br/>
<img width="1234" height="814" alt="Screenshot (554)" src="https://github.com/user-attachments/assets/a99b445a-5025-4b58-aaae-08f95cec3fef" />
<br />
<br />
Adjusting the scale for Recency of purchase: <br/>
<img width="1223" height="808" alt="Screenshot (551)" src="https://github.com/user-attachments/assets/25a50491-3651-4a42-b204-5eec9090de06" />
<br />
<br />
Adjusting the scale for Frequency of purchase:  <br/>
<img width="1217" height="808" alt="Screenshot (552)" src="https://github.com/user-attachments/assets/5c7733d4-439a-4334-b783-7260592b41a6" />
<br />
<br />
Adjusting the scale for Monetary Value of purchase:  <br/>
<img width="1227" height="814" alt="Screenshot (553)" src="https://github.com/user-attachments/assets/ab80cf98-7bab-4037-836d-608ae3b2e8ce" />
<br />

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>


