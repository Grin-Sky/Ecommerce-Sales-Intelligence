# Data — E-commerce Sales Intelligence

## Data source

This project uses the [UCI Online Retail dataset](https://archive.ics.uci.edu/dataset/352/online+retail), containing transactions from a UK-based online retailer between December 2010 and December 2011. The original workbook is named `Online_Retail.xlsx`.

The source data is maintained separately from the public GitHub repository. Readers can obtain it from the UCI Machine Learning Repository.

## Local data organization

| Location | File | Description |
|---|---|---|
| `Raw/` | `Online_Retail.xlsx` | Original downloaded source workbook, preserved for reference. |
| `Processed/` | `df_clean.csv` | Data after removal of exact duplicate records. |
| `Processed/` | `df_sales.csv` | Prepared data after selected sales-related exclusions. |
| `Processed/` | `df_orders.csv` | Prepared data excluding cancellation invoices. |
| `Processed/` | `df_revenue.csv` | Positive-quantity transaction data with a calculated `Revenue` column. |

The processed CSV files are outputs of the Python preparation workflow, not separate source datasets. The notebooks documenting these steps are in [Python Analysis Documentation](../03_Python_Analysis/README.md).

## Repository scope

The original Excel workbook and generated CSV files are intentionally excluded from version control because of their size. This README documents the data layout without distributing those files. GitHub may not display the local `Raw/` and `Processed/` folders when they contain only ignored files.

The reported business metrics are defined by the SQL queries in [`04_SQL_Analysis/`](../04_SQL_Analysis/), which apply additional analytical filters. Prepared Python outputs should not be assumed to match the final KPI population without those filters.
