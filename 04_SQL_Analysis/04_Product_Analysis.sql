
-- Project 01: E-commerce Sales Intelligence
-- File: 04_Product_Analysis.sql
-- Purpose: Rank products by qualifying revenue and quantity sold.
-- Platform: Google BigQuery
-- Scope: Excludes cancellation invoices, non-positive quantities, and selected stock codes.
-- Product grouping: StockCode + Description; differing descriptions for the same
-- stock code may appear as separate groups.
-- NoTransactionLines counts qualifying transaction rows, not distinct invoices.
-- ProductRevenue is qualifying transaction value, not profit or fully netted revenue.


-- 1. Top 10 Products by Revenue
WITH BestPerformingProducts AS (
    SELECT
        StockCode,
        Description,
        ROUND(SUM(Quantity * UnitPrice), 2) AS ProductRevenue,
        COUNT(*) AS NoTransactionLines,
        SUM(Quantity) AS TotalQuantitySold
    FROM
        `analytics-studio-510120.ecommerce_sales.sales`
    WHERE
        InvoiceNo NOT LIKE 'C%'
        AND Quantity > 0
        AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843')
    GROUP BY
        StockCode,
        Description
)
SELECT
    StockCode,
    Description,
    ProductRevenue,
    NoTransactionLines,
    TotalQuantitySold
FROM
    BestPerformingProducts
ORDER BY
    ProductRevenue DESC
LIMIT 10;


-- 2. Top 50 Products by Revenue
WITH BestPerformingProducts AS (
    SELECT
        StockCode,
        Description,
        ROUND(SUM(Quantity * UnitPrice), 2) AS ProductRevenue,
        COUNT(*) AS NoTransactionLines,
        SUM(Quantity) AS TotalQuantitySold
    FROM
        `analytics-studio-510120.ecommerce_sales.sales`
    WHERE
        InvoiceNo NOT LIKE 'C%'
        AND Quantity > 0
        AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843')
    GROUP BY
        StockCode,
        Description
)
SELECT
    StockCode,
    Description,
    ProductRevenue,
    NoTransactionLines,
    TotalQuantitySold
FROM
    BestPerformingProducts
ORDER BY
    ProductRevenue DESC
LIMIT 50;
