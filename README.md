# Music Store Sales Analysis (SQL)

A SQL Server analysis of the **Chinook** sample database, a digital music store with customers, invoices, tracks, albums and genres. The script answers common business questions about revenue, top customers, best-selling tracks and month-over-month growth.

## Files

| File | Description |
|------|-------------|
| `music-store-sales-analysis.sql` | All queries, in order, ready to run in SSMS or Azure Data Studio |

## Requirements

- Microsoft SQL Server (T-SQL syntax: `TOP`, `LAG`, `NULLIF`)
- The [Chinook database](https://github.com/lerocha/chinook-database) installed as `Chinook`

## Database Tables Used

- `Customer`: customer details and country
- `Invoice`: invoices with date and total
- `InvoiceLine`: line items (track, quantity) per invoice
- `Track`: track name, album, genre and unit price

## Analyses

| # | Question | Techniques |
|---|----------|-----------|
| 0 | Explore the data: preview customers and list all base tables | `TOP`, `INFORMATION_SCHEMA` |
| 1 | **Revenue by country**: which markets generate the most revenue? | `INNER JOIN`, `SUM`, `GROUP BY` |
| 2 | **Track preview**: sample of 10 tracks with album, genre and price | `TOP` |
| 3 | **Units sold per track**: how many times was each track sold? | `SUM`, `GROUP BY`, `ORDER BY` |
| 4 | **Top 10 customers by spending** | `JOIN`, aggregation, `TOP` |
| 5 | **Monthly revenue**: revenue per year and month (first 20 months) | `YEAR()`, `MONTH()`, `GROUP BY` |
| 6 | **Month-over-month growth**: revenue change and percent change vs. the previous month | CTEs, `LAG()` window function, `NULLIF` (avoids division by zero) |

## How to Run

1. Install the Chinook database on your SQL Server instance.
2. Open `music-store-sales-analysis.sql` in SSMS or Azure Data Studio.
3. Run the whole script, or highlight one query at a time to see each result.

## Skills Demonstrated

- Multi-table joins and aggregation
- Common Table Expressions (CTEs)
- Window functions (`LAG`) for time-series analysis
- Safe calculations (`NULLIF`) and rounding
- Business-oriented analysis: revenue, customer value, growth trends

## Possible Next Steps

- Rank top-selling tracks by units sold and join `Track`, `Album` and `Artist` for readable names
- Revenue by genre and by artist
- Customer segmentation (e.g. by spend or purchase frequency)
- Visualize monthly revenue and growth in Power BI or Python
