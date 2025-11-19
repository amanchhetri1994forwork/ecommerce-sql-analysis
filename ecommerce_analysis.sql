-- ecommerce_analysis.sql

DROP TABLE IF EXISTS staging_ecommerce;
DROP TABLE IF EXISTS ecommerce_transactions;

CREATE TABLE staging_ecommerce (
  InvoiceNo TEXT,
  StockCode TEXT,
  Description TEXT,
  Quantity TEXT,
  InvoiceDate TEXT,
  UnitPrice TEXT,
  CustomerID TEXT,
  Country TEXT
);

-- Update this path to your secure_file_priv folder
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ecommerce_transactions.csv'
INTO TABLE staging_ecommerce
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(InvoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, CustomerID, Country);

CREATE TABLE ecommerce_transactions (
  invoice_no VARCHAR(50),
  stock_code VARCHAR(50),
  description TEXT,
  quantity INT,
  invoice_date DATETIME,
  unit_price DECIMAL(10,2),
  customer_id VARCHAR(50),
  country VARCHAR(100),
  total_value DECIMAL(12,2)
);

INSERT INTO ecommerce_transactions
SELECT
  TRIM(InvoiceNo),
  TRIM(StockCode),
  TRIM(Description),
  CAST(Quantity AS SIGNED),
  STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'),
  CAST(UnitPrice AS DECIMAL(10,2)),
  NULLIF(TRIM(CustomerID),''),
  TRIM(Country),
  CAST(UnitPrice AS DECIMAL(10,2)) * CAST(Quantity AS SIGNED)
FROM staging_ecommerce;

ALTER TABLE ecommerce_transactions
  ADD COLUMN order_date DATE,
  ADD COLUMN order_month VARCHAR(10),
  ADD COLUMN order_year INT;

UPDATE ecommerce_transactions
SET order_date = DATE(invoice_date),
    order_month = DATE_FORMAT(invoice_date, '%Y-%m'),
    order_year = YEAR(invoice_date);

CREATE INDEX idx_invoice_date ON ecommerce_transactions(invoice_date);
CREATE INDEX idx_customer_id ON ecommerce_transactions(customer_id);

CREATE VIEW vw_monthly_revenue AS
SELECT order_month, SUM(total_value) AS revenue
FROM ecommerce_transactions
GROUP BY order_month
ORDER BY order_month;

CREATE VIEW vw_top_products AS
SELECT stock_code, description, SUM(quantity) AS total_qty, SUM(total_value) AS revenue
FROM ecommerce_transactions
GROUP BY stock_code, description
ORDER BY revenue DESC;

