# E‑Commerce SQL Analysis Project (Kaggle Dataset)

A complete **SQL‑only** analytics project using the Kaggle dataset: **E‑Commerce Transactions Dataset**.

This project demonstrates an end‑to‑end workflow using **only SQL (MySQL)** — including data ingestion, cleaning, transformation, feature engineering, analytics queries, and creation of dashboard‑ready SQL views.

---

## 📁 Repository Structure
```
Ecommerce-SQL-Analysis/
├── README.md
├── data/
│   └── ecommerce_transactions.csv
└── sql/
    └── ecommerce_analysis.sql
```

---

## 📦 Dataset
Source: Kaggle — *E‑Commerce Transactions Dataset*  
https://www.kaggle.com/datasets/smayanj/e-commerce-transactions-dataset

This dataset contains:
- InvoiceNo
- StockCode
- Description
- Quantity
- InvoiceDate
- UnitPrice
- CustomerID
- Country

---

# 🔧 Tools Used
- **MySQL 8.0+**
- **Pure SQL (DDL, DML, Aggregations, Window Functions, Views)**
- **MySQL Workbench** (recommended)

No Python. No Excel. No BI tools required (optional).

---

# 🚀 Project Highlights

### ✔ SQL‑Only Data Pipeline
- Created **staging tables** to safely load CSV data
- Cleaned & normalized messy string fields
- Converted price, quantity, and date fields into proper SQL datatypes

### ✔ Feature Engineering
- `total_value = quantity * unit_price`
- Extracted `order_month`, `order_year`, `order_date`
- Calculated revenue‑based metrics for customers & products

### ✔ Business Insights from SQL
- Top 10 products by quantity sold
- Top revenue‑generating customers
- Monthly revenue trend
- Repeat purchase rate
- Average order value (AOV)
- Revenue by country

### ✔ Dashboard‑Ready SQL Views
- `vw_monthly_revenue`
- `vw_top_products`

---

# 🗂 How to Run the Project

### **1. Create Database**
```sql
CREATE DATABASE ecommerce_sql_proj;
USE ecommerce_sql_proj;
```

### **2. Load CSV into MySQL**  
(Place CSV inside the MySQL `secure_file_priv` folder or use Workbench Import Wizard.)

```sql
SHOW VARIABLES LIKE 'secure_file_priv';
```

Move your CSV there and run the `LOAD DATA INFILE` command inside `sql/ecommerce_analysis.sql`.

### **3. Run the Full SQL Script**
Open **`sql/ecommerce_analysis.sql`** in MySQL Workbench → Execute All.

The script will:
- Create staging table
- Load raw CSV
- Clean & convert columns
- Create final fact table
- Add engineered columns
- Create indexes
- Generate dashboard SQL views
- Run analytics queries

### **4. Validate Results**
```sql
SELECT COUNT(*) FROM ecommerce_transactions;
SELECT * FROM ecommerce_transactions LIMIT 20;
```

---

# 📊 Analytics Queries (Included in SQL File)

### **Top 10 Products by Sales Quantity**
```sql
SELECT stock_code, description, SUM(quantity) AS total_qty
FROM ecommerce_transactions
GROUP BY stock_code, description
ORDER BY total_qty DESC
LIMIT 10;
```

### **Top Customers by Lifetime Value**
```sql
SELECT customer_id, SUM(total_value) AS lifetime_value
FROM ecommerce_transactions
WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY lifetime_value DESC
LIMIT 10;
```

### **Monthly Revenue Trend**
```sql
SELECT order_month, SUM(total_value) AS revenue
FROM ecommerce_transactions
GROUP BY order_month
ORDER BY order_month;
```

### **Repeat Purchase Rate**
```sql
WITH customer_orders AS (
  SELECT customer_id, COUNT(DISTINCT invoice_no) AS orders
  FROM ecommerce_transactions
  WHERE customer_id IS NOT NULL
  GROUP BY customer_id
)
SELECT ROUND(COUNT(CASE WHEN orders > 1 THEN 1 END) / COUNT(*) * 100, 2) AS repeat_rate_percent
FROM customer_orders;
```

### **Average Order Value (AOV)**
```sql
SELECT AVG(order_total) AS avg_order_value
FROM (
  SELECT invoice_no, SUM(total_value) AS order_total
  FROM ecommerce_transactions
  GROUP BY invoice_no
) t;
```

---

# 📈 SQL Views for Dashboards

### **Monthly Revenue View**
```sql
CREATE VIEW vw_monthly_revenue AS
SELECT order_month, SUM(total_value) AS revenue
FROM ecommerce_transactions
GROUP BY order_month
ORDER BY order_month;
```

### **Top Products View**
```sql
CREATE VIEW vw_top_products AS
SELECT stock_code, description, SUM(quantity) AS total_qty, SUM(total_value) AS revenue
FROM ecommerce_transactions
GROUP BY stock_code, description
ORDER BY revenue DESC;
```

---
