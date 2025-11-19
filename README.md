# E-Commerce SQL Analysis Project (Kaggle Dataset)

A complete **SQL-only** analytics project using the Kaggle dataset: **E-Commerce Transactions Dataset**.

This project demonstrates:
- SQL-only data cleaning
- SQL feature engineering
- SQL analytics (Revenue, AOV, Repeat rate, Top products/customers)
- SQL views for dashboards

---

## 📁 Repository Structure
```
ecommerce_sql_project/
├── README.md
├── data/
│   └── ecommerce_transactions.csv   (Place your Kaggle CSV here)
└── sql/
    └── ecommerce_analysis.sql
```

---

## 🚀 How to Use

### 1. Create Database
```sql
CREATE DATABASE ecommerce_sql_proj;
USE ecommerce_sql_proj;
```

### 2. Move CSV to secure_file_priv folder
Check folder:
```sql
SHOW VARIABLES LIKE 'secure_file_priv';
```

Place CSV there.

### 3. Run SQL script
Open:
```
sql/ecommerce_analysis.sql
```
Run entire script.

---

## 🔗 LinkedIn Post
**🚀 New Project: SQL-Only E-Commerce Transactions Analysis (Kaggle Dataset)**

I completed an end-to-end E-Commerce analytics project entirely using **SQL (MySQL)**.

### 🔍 What I built:
- Cleaned + transformed raw CSV using SQL staging tables
- Engineered features like *order_month*, *total_value*, *AOV*, and *CLV*
- Designed analytical SQL queries (top products, top customers, revenue trends)
- Created dashboard-ready views for BI tools

### 🛠 Tools Used:
MySQL • SQL Views • Aggregations • Window Functions • Data Cleaning

🔗 GitHub Repo: *your repo link here*
