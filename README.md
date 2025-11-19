# E-Commerce SQL Analysis Project (Kaggle Dataset)

A complete **SQL-only** analytics project using the Kaggle dataset: **E-Commerce Transactions Dataset**.

This project demonstrates:
- SQL-only data cleaning
- SQL feature engineering
- SQL analytics (Revenue, AOV, Repeat rate, Top products/customers)
- SQL views for dashboards

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
