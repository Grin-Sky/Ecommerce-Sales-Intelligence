-- Project 01: E-commerce Sales Intelligence
-- File: 01_KPI_Analysis.sql
-- Purpose: Calculate the core business performance KPIs.
-- Platform: Google BigQuery
-- Scope: Qualifying transactions exclude cancellation invoices, non-positive
-- quantities, and StockCodes POST, DOT, M, m, and 23843.
-- Revenue is qualifying transaction value (Quantity * UnitPrice),
-- not fully reconciled net revenue or profit.
-- Identifiable customers exclude NULL CustomerID values by definition.

-- 1. Total Revenue
SELECT
    ROUND(SUM(Quantity * UnitPrice), 2) AS TotalRevenue
FROM
    `analytics-studio-510120.ecommerce_sales.sales`
WHERE
    InvoiceNo NOT LIKE 'C%'
    AND Quantity > 0
    AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843');


-- 2. Total Orders
SELECT
    COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM
    `analytics-studio-510120.ecommerce_sales.sales`
WHERE
    InvoiceNo NOT LIKE 'C%'
    AND Quantity > 0
    AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843');


-- 3. Average Order Value (AOV)
SELECT
    ROUND(
        SAFE_DIVIDE(
            SUM(Quantity * UnitPrice),
            COUNT(DISTINCT InvoiceNo)
        ),
        2
    ) AS AverageOrderValue
FROM
    `analytics-studio-510120.ecommerce_sales.sales`
WHERE
    InvoiceNo NOT LIKE 'C%'
    AND Quantity > 0
    AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843');


-- 4. Number of Identifiable Customers
SELECT
    COUNT(DISTINCT CustomerID) AS IdentifiableCustomers
FROM
    `analytics-studio-510120.ecommerce_sales.sales`
WHERE
    InvoiceNo NOT LIKE 'C%'
    AND Quantity > 0
    AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843');
