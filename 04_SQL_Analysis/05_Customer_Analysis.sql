
-- Project 01: E-commerce Sales Intelligence
-- File: 05_Customer_Analysis.sql
-- Purpose: Analyze customer revenue and purchasing frequency.
-- Platform: Google BigQuery
-- Scope: Qualifying sales only; customers with missing CustomerID are excluded.
-- TotalOrders counts distinct invoice numbers, not individual transaction lines.
-- CustomerRevenue is qualifying sales value (Quantity * UnitPrice), not profit
-- or fully reconciled net revenue after refunds and other costs.


-- 1. Top 50 Customers by Revenue
-- Ranks identifiable customers by qualifying sales value.
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS CustomerRevenue
FROM
    `analytics-studio-510120.ecommerce_sales.sales`
WHERE
    InvoiceNo NOT LIKE 'C%'
    AND Quantity > 0
    AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843')
    AND CustomerID IS NOT NULL
GROUP BY
    CustomerID
ORDER BY
    CustomerRevenue DESC
LIMIT 50;


-- 2. Top 50 Customers by Order Frequency
-- Ranks identifiable customers by the number of distinct qualifying invoices.
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS CustomerRevenue
FROM
    `analytics-studio-510120.ecommerce_sales.sales`
WHERE
    InvoiceNo NOT LIKE 'C%'
    AND Quantity > 0
    AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843')
    AND CustomerID IS NOT NULL
GROUP BY
    CustomerID
ORDER BY
    TotalOrders DESC
LIMIT 50;
