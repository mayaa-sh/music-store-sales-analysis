USE Chinook;
GO

SELECT TOP 10*
FROM Customer;


SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE='BASE TABLE'
ORDER BY TABLE_NAME;

USE Chinook;
GO
--1.Revenue by country
SELECT
   c.Country,
   SUM(i.Total) AS TotalRevenue
FROM Customer AS c
INNER JOIN Invoice AS i
  ON c.CustomerId=i.CustomerId
GROUP BY c.Country
ORDER BY TotalRevenue DESC;

USE Chinook;
Go
--2.Track Preview
SELECT TOP 10
   TrackId,
   Name,
   AlbumId,
   GenreId,
   UnitPrice
FROM Track;   

--3.Units sold
USE Chinook;
Go
SELECT 
  TrackId,
  SUM(Quantity) AS TotalSold
FROM InvoiceLine
GROUP BY TrackId
ORDER BY TotalSold DESC;

USE Chinook;
Go
--4.Top 10 customers by spending
SELECT TOP 10
  c.FirstName,
  c.LastName,
  SUM(i.Total) AS TotalSpent
FROM Customer AS c
INNER JOIN Invoice AS i
  ON c.CustomerId=i.CustomerId
GROUP BY c.CustomerId,c.FirstName,c.LastName
ORDER BY TotalSpent DESC;

--5.Monthly Revenue Analysys
USE Chinook;
GO
SELECT top 20
  YEAR(InvoiceDate) AS SalesYear,
  MONTH(InvoiceDate) AS SalesMonth,
  SUM(Total) AS MonthlyRevenue
FROM Invoice
GROUP BY  YEAR(InvoiceDate),
          MONTH(InvoiceDate)
ORDER BY
         SalesYear,
         SalesMonth;

--6.Month-over-MonthRevenueGrowth
USE Chinook;
GO

WITH MonthlySales AS (
    SELECT
        YEAR(InvoiceDate) AS SalesYear,
        MONTH(InvoiceDate) AS SalesMonth,
        SUM(Total) AS MonthlyRevenue
    FROM Invoice
    GROUP BY
        YEAR(InvoiceDate),
        MONTH(InvoiceDate)
),
SalesWithPreviousMonth AS (
    SELECT
        SalesYear,
        SalesMonth,
        MonthlyRevenue,
        LAG(MonthlyRevenue) OVER (
            ORDER BY SalesYear, SalesMonth
        ) AS PreviousMonthRevenue
    FROM MonthlySales
)
SELECT
    SalesYear,
    SalesMonth,
    MonthlyRevenue,
    PreviousMonthRevenue,
    MonthlyRevenue - PreviousMonthRevenue AS RevenueChange,
    ROUND(
        100.0 * (MonthlyRevenue - PreviousMonthRevenue)
        / NULLIF(PreviousMonthRevenue, 0),
        2
    ) AS RevenueChangePercent
FROM SalesWithPreviousMonth
ORDER BY SalesYear, SalesMonth;
