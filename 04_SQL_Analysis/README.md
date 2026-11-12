# SQL Analysis — Google BigQuery

## Overview

This folder contains the Google BigQuery SQL scripts used in the **E-commerce Sales Intelligence** project. They analyze qualifying sales transactions from the [UCI Online Retail dataset](https://archive.ics.uci.edu/dataset/352/online+retail), covering revenue, orders, monthly trends, countries, products, and identifiable customers.

## Tools Used

- Google BigQuery
- SQL (GoogleSQL)

## SQL Scripts

| File | Purpose |
|---|---|
| [`01_KPI_Analysis.sql`](01_KPI_Analysis.sql) | Calculates total revenue, distinct orders, average order value (AOV), and identifiable customers. |
| [`02_Monthly_Sales.sql`](02_Monthly_Sales.sql) | Summarizes monthly revenue and distinct orders. |
| [`03_Country_Analysis.sql`](03_Country_Analysis.sql) | Ranks countries by revenue and calculates monthly AOV by country. |
| [`04_Product_Analysis.sql`](04_Product_Analysis.sql) | Ranks the top 10 and top 50 stock-code/description combinations by revenue, with quantity sold and transaction-line counts. |
| [`05_Customer_Analysis.sql`](05_Customer_Analysis.sql) | Ranks identifiable customers by revenue and distinct-order frequency. |

## Business-Metric Filters

All five scripts use the same core filters:

- Exclude cancellation invoices with invoice numbers beginning with `C`.
- Include only transactions with `Quantity > 0`.
- Exclude stock codes `POST`, `DOT`, `M`, `m`, and `23843`.

These filters define the analytical scope; they do not remove records from the original dataset. Stock code `23843` was excluded after an investigation identified a positive-quantity transaction and a corresponding cancellation-invoice record. This targeted exclusion does not constitute a full reconciliation of returns or refunds.

## Metric Definitions

- **Revenue:** Sum of `Quantity * UnitPrice` for qualifying transaction lines.
- **Total Orders:** Count of distinct qualifying `InvoiceNo` values.
- **Average Order Value (AOV):** Qualifying revenue divided by distinct qualifying orders, using `SAFE_DIVIDE`.
- **Identifiable Customers:** Count of distinct non-null `CustomerID` values among qualifying transactions.
- **Order Frequency:** Count of distinct qualifying invoices per identifiable customer.

The product queries group by both `StockCode` and `Description`; `NoTransactionLines` counts rows, not distinct orders.

## Data Source and Execution

The scripts reference the BigQuery table `analytics-studio-510120.ecommerce_sales.sales`. To execute them in a different BigQuery project, load the appropriately prepared transaction data with the expected column names and update the fully qualified table reference.

For the data preparation workflow, see [Python Data Exploration & Preparation](../03_Python_Analysis/README.md) and [Data Folder README](../02_Data/README.md).

## Interpretation and Limitations

Reported revenue is qualifying transaction value, **not profit** or fully reconciled net revenue after returns, refunds, and business expenses. Customer-based analyses exclude transactions without a customer identifier. **December 2011 is a partial month** because the dataset ends on December 9, 2011; its totals should not be compared directly with complete months.

These queries support descriptive analysis of historical sales patterns. They do not establish why particular products, customers, or countries performed as they did.
