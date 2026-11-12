
-- Project 01: E-commerce Sales Intelligence
-- File: 03_Country_Analysis.sql
-- Purpose: Analyze qualifying revenue, order volume, and monthly AOV by country.
-- Platform: Google BigQuery
-- Scope: Qualifying transactions exclude cancellation invoices, non-positive
--        quantities, and stock codes POST, DOT, M, m, and 23843.
-- Note: Revenue is qualifying transaction value, not net revenue or profit.


-- 1. Revenue and Orders by Country
-- Countries are ranked by qualifying revenue, including the United Kingdom.
SELECT
    Country,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    ROUND(SUM(Quantity * UnitPrice), 2) AS CountryRevenue
FROM
    `analytics-studio-510120.ecommerce_sales.sales`
WHERE
    InvoiceNo NOT LIKE 'C%'
    AND Quantity > 0
    AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843')
GROUP BY
    Country
ORDER BY
    CountryRevenue DESC;


-- 2. Monthly Average Order Value by Country
-- MonthlyAOV = qualifying revenue for the country-month / distinct orders
-- for that same country-month; it is not an average of line-item values.
-- December 2011 is partial (data ends December 9); avoid direct comparison
-- with full months.
WITH CountryMonthlyMetrics AS (
    SELECT
        Country,
        DATE_TRUNC(InvoiceDate, MONTH) AS SalesMonth,
        COUNT(DISTINCT InvoiceNo) AS TotalOrders,
        SUM(Quantity * UnitPrice) AS CountryRevenue
    FROM
        `analytics-studio-510120.ecommerce_sales.sales`
    WHERE
        InvoiceNo NOT LIKE 'C%'
        AND Quantity > 0
        AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843')
    GROUP BY
        Country,
        SalesMonth
)
SELECT
    Country,
    SalesMonth,
    TotalOrders,
    ROUND(CountryRevenue, 2) AS MonthlyRevenue,
    ROUND(
        SAFE_DIVIDE(CountryRevenue, TotalOrders),
        2
    ) AS MonthlyAOV
FROM
    CountryMonthlyMetrics
ORDER BY
    Country,
    SalesMonth;
