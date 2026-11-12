-- Project 01: E-commerce Sales Intelligence
-- File: 02_Monthly_Sales.sql
-- Purpose: Calculate monthly qualifying revenue and distinct order counts.
-- Platform: Google BigQuery
-- Revenue is qualifying transaction value, not net profit or fully reconciled refunds.
-- December 2011 is incomplete: the source data ends on 9 December 2011.

SELECT
    DATE_TRUNC(InvoiceDate, MONTH) AS SalesMonth,
    ROUND(SUM(Quantity * UnitPrice), 2) AS MonthlyRevenue,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM
    `analytics-studio-510120.ecommerce_sales.sales`
WHERE
    InvoiceNo NOT LIKE 'C%'
    AND Quantity > 0
    AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843')
GROUP BY
    SalesMonth
ORDER BY
    SalesMonth;
