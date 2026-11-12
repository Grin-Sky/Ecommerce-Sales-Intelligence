# Project Analysis and Business Insights

**Project:** E-commerce Sales Intelligence  
**Data source:** [UCI Online Retail](https://archive.ics.uci.edu/dataset/352/online+retail)  
**Reporting period:** December 2010–December 9, 2011  
**Tools:** Python, Pandas, Google BigQuery (SQL), Tableau Public

## 1. Executive Summary

This independent portfolio project examines historical transactions from a UK-based online retailer to understand sales performance, product contribution, geographic markets, and customer purchasing behavior.

The analysis identified **£9.84 million in qualifying transaction revenue** across **20,453 distinct orders**. Revenue was heavily concentrated in the **United Kingdom (approximately 84.5%)**, and **November 2011** recorded the highest monthly revenue in the analyzed period. Product rankings and customer rankings also revealed an important distinction: **the greatest revenue contribution does not necessarily come from the highest unit volume or the most frequent purchases**.

These results provide a basis for further business investigation. They describe historical patterns rather than proving why those patterns occurred.

## 2. Analytical Approach

The project followed three connected analytical stages:

1. **Python exploration and preparation:** Inspected missing customer IDs, duplicate rows, cancellation invoices, zero-price records, stock codes, and unusual transactions. Selected cleaning decisions were documented rather than treating every unusual record as invalid.
2. **BigQuery SQL analysis:** Applied a consistent set of qualifying-sales filters and calculated overall KPIs, monthly trends, country performance, product rankings, and identifiable-customer rankings.
3. **Tableau visualization:** Presented headline metrics and interactive comparisons. Selecting a country or product bar updates the monthly revenue trend; clearing the selection returns to **All Sales**.

### Business-metric scope

The final reported metrics use qualifying transaction lines that meet these criteria:

```sql
WHERE InvoiceNo NOT LIKE 'C%'
  AND Quantity > 0
  AND StockCode NOT IN ('POST', 'DOT', 'M', 'm', '23843')
```

The exclusion of stock code `23843` followed investigation of a large positive-quantity record and a corresponding cancellation record. The exclusions define the project's analytical population; they do **not** constitute a complete returns or refunds reconciliation.

Revenue is calculated as `Quantity × UnitPrice`. Orders are distinct qualifying invoice numbers, and customers are distinct non-null customer IDs associated with qualifying transactions. Python's intermediate exploration figures should not be confused with the final SQL-based metrics.

## 3. Key Findings and Interpretation

### 3.1 Overall Sales Performance

| Metric | Result |
|---|---:|
| Qualifying revenue | **£9,844,256.50** |
| Distinct qualifying orders | **20,453** |
| Average order value (AOV) | **£481.31** |
| Identifiable customers | **4,336** |

**Interpretation:** The metrics establish a baseline for the available transactions. AOV measures qualifying revenue per distinct qualifying invoice—not typical spending by each customer or profitability. Some qualifying sales lack a customer ID, so the identifiable-customer count does not represent every purchaser.

### 3.2 Monthly Revenue Trends

**November 2011** was the highest-revenue month in the analyzed results, with **£1,361,604.57** across **2,809** qualifying orders.

**Business implication:** November's performance merits closer investigation for possible changes in order volumes, product mix, or customer activity. It can inform questions about peak-period operations, but one historical cycle is insufficient to establish a repeatable seasonal pattern.

**Reporting caution:** December 2011 includes transactions only through **December 9**. Its lower monthly total should not be interpreted as evidence of declining demand without accounting for the incomplete reporting window.

### 3.3 Country and Market Performance

| Market | Qualifying revenue | Distinct orders |
|---|---:|---:|
| United Kingdom | **£8,315,904.85** | **18,577** |
| Netherlands | **£283,889.34** | **94** |

The United Kingdom accounted for approximately **84.5% of total qualifying revenue**, making it the dominant market in this dataset.

The Netherlands generated substantial revenue from a relatively small number of invoices. This suggests that its **revenue per order warrants investigation**, but the figures alone cannot establish whether the difference reflects larger baskets, wholesale activity, product mix, or another cause.

**Business implication:** Maintain separate views of the UK and international markets. The UK provides the overall scale, while an international-only comparison makes smaller markets easier to evaluate without being visually overwhelmed.

### 3.4 Product Performance

The leading products by qualifying revenue in the SQL results included:

| Product description | Revenue | Units sold |
|---|---:|---:|
| REGENCY CAKESTAND 3 TIER | £169,509.77 | 13,552 |
| WHITE HANGING HEART T-LIGHT HOLDER | £103,498.66 | 37,450 |
| PARTY BUNTING | £99,034.62 | 18,244 |
| JUMBO BAG RED RETROSPOT | £93,690.64 | 48,262 |
| MEDIUM CERAMIC TOP STORAGE JAR | £81,622.20 | 78,001 |

**Interpretation:** `REGENCY CAKESTAND 3 TIER` led by revenue, while `MEDIUM CERAMIC TOP STORAGE JAR` sold substantially more units among these products. High revenue and high unit volume are different measures of product performance.

**Business implication:** Consider both revenue contribution and units sold when reviewing merchandising and inventory priorities. These metrics alone do not indicate margin, stock availability, or replenishment requirements.

*Product SQL rankings use the combination of `StockCode` and `Description`, so naming variations can produce separate groups.*

### 3.5 Customer Value and Purchase Frequency

- **Customer 14646:** Highest qualifying revenue among identifiable customers, at **£279,138.02** across **73** distinct orders.
- **Customer 12748:** Highest order frequency in the analyzed customer ranking, with **206** distinct orders and **£31,650.78** in qualifying revenue.
- **Customer 12346:** Generated **£77,183.60** in a single qualifying order.

**Interpretation:** The customer generating the most revenue is not necessarily the customer placing the most orders. Large one-off purchases can also influence customer rankings.

**Business implication:** Review high-spend and high-frequency customers separately when considering retention or account-management strategies. These historical metrics do not, on their own, establish customer lifetime value or future purchasing behavior.

## 4. Recommendations for Further Business Investigation

| Priority | Recommendation | Evidence or question to investigate |
|---|---|---|
| 1 | **Monitor UK concentration while comparing international markets separately.** | The UK represents approximately 84.5% of qualifying revenue; country-specific trends may reveal different patterns. |
| 2 | **Compare product revenue with unit volume before making inventory decisions.** | Product leaders differ depending on the metric; profit margins and stock information would add necessary context. |
| 3 | **Segment customers by spend and order frequency.** | The highest-spend and highest-frequency customer IDs are different; investigate whether their purchasing patterns require different approaches. |
| 4 | **Investigate November's peak using more detailed order and product breakdowns.** | November 2011 had the highest observed monthly revenue; additional periods would be needed to assess repeatability. |
| 5 | **Examine unusual large orders and high revenue-per-order markets.** | Exceptional invoices and the Netherlands' country-level results warrant closer review before attributing causes. |

These are **proposed analytical follow-ups**, not tested interventions or forecasts.

## 5. Data Limitations

- **Revenue is not profit or reconciled net revenue.** The analysis does not fully account for refunds, returns, operating expenses, or product costs.
- **Customer coverage is incomplete.** Transactions without a `CustomerID` contribute to applicable overall metrics but cannot be attributed to identifiable customers.
- **The reporting period is historical and limited.** Results cannot establish current market conditions, recurring seasonality, or causal relationships.
- **December 2011 is incomplete.** It should not be directly compared with full months without adjusting for coverage.
- **The business case is illustrative.** The intended stakeholders and recommendations are part of an independent portfolio project, not a commissioned client engagement.
- **Product and transaction definitions affect comparisons.** Product analysis groups by stock code and description; excluded transaction types and stock codes change the KPI population.

## 6. Conclusion

The project demonstrates how exploratory data checks, explicit business-metric definitions, SQL analysis, and an interactive dashboard can turn raw transaction records into interpretable sales intelligence.

The strongest findings concern **UK revenue concentration**, **November's observed monthly peak**, and the distinction between **revenue, units sold, and customer order frequency**. The practical value of the analysis lies in identifying where a business might investigate further—not in claiming explanations that the available data cannot support.

## Explore the Analysis

- [Python exploration and data preparation](../03_Python_Analysis/README.md)
- [BigQuery SQL analysis](../04_SQL_Analysis/README.md)
- [Interactive Tableau dashboard and preview](../05_Dashboard/README.md)
- [View the live Tableau dashboard](https://public.tableau.com/views/E-commerceSalesIntelligenceDashboardDevelopment/SalesIntelligenceOverview)
- [UCI Online Retail dataset](https://archive.ics.uci.edu/dataset/352/online+retail)
