-- AdventureWorksLT Query Lab (Azure SQL Database)
-- Run a number of queries against AdventureWorksLT
-- Copy/paste into SSMS or Azure Data Studio and execute step by step.

------------------------------------------------------------
-- 0) Confirm current database and SQL version
------------------------------------------------------------
SELECT DB_NAME() AS CurrentDatabase, @@VERSION AS SqlVersion;
GO

------------------------------------------------------------
-- 1) List all tables in the database
------------------------------------------------------------
SELECT s.name AS SchemaName, t.name AS TableName
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
ORDER BY s.name, t.name;
GO

------------------------------------------------------------
-- 2) Top 10 most expensive products
------------------------------------------------------------
SELECT TOP (10)
    ProductID, Name, ProductNumber, ListPrice, StandardCost
FROM SalesLT.Product
ORDER BY ListPrice DESC;
GO

------------------------------------------------------------
-- 3) Customers per city/country (top 10)
------------------------------------------------------------
SELECT TOP (10)
    a.CountryRegion, a.StateProvince, a.City,
    COUNT(DISTINCT c.CustomerID) AS Customers
FROM SalesLT.Customer c
JOIN SalesLT.CustomerAddress ca ON ca.CustomerID = c.CustomerID
JOIN SalesLT.Address a ON a.AddressID = ca.AddressID
GROUP BY a.CountryRegion, a.StateProvince, a.City
ORDER BY Customers DESC, a.CountryRegion, a.City;
GO

------------------------------------------------------------
-- 4) Total order value per customer (top 10)
------------------------------------------------------------
SELECT TOP (10)
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    SUM(soh.TotalDue) AS TotalSpent
FROM SalesLT.Customer c
JOIN SalesLT.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;
GO

------------------------------------------------------------
-- 5) Most sold products by quantity (top 10)
------------------------------------------------------------
SELECT TOP (10)
    p.ProductID, p.Name,
    SUM(sod.OrderQty) AS TotalQty
FROM SalesLT.SalesOrderDetail sod
JOIN SalesLT.Product p ON p.ProductID = sod.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY TotalQty DESC;
GO

------------------------------------------------------------
-- 6) Highest revenue products (top 10)
------------------------------------------------------------
SELECT TOP (10)
    p.ProductID, p.Name,
    SUM(sod.LineTotal) AS Revenue
FROM SalesLT.SalesOrderDetail sod
JOIN SalesLT.Product p ON p.ProductID = sod.ProductID
GROUP BY p.ProductID, p.Name
ORDER BY Revenue DESC;
GO

------------------------------------------------------------
-- 7) Average order value per month
------------------------------------------------------------
SELECT
    DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1) AS OrderMonth,
    COUNT(*) AS Orders,
    AVG(TotalDue) AS AvgOrderValue,
    SUM(TotalDue) AS TotalSales
FROM SalesLT.SalesOrderHeader
GROUP BY DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1)
ORDER BY OrderMonth;
GO

------------------------------------------------------------
-- 8) Customers without any orders
------------------------------------------------------------
SELECT
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.EmailAddress
FROM SalesLT.Customer c
LEFT JOIN SalesLT.SalesOrderHeader soh ON soh.CustomerID = c.CustomerID
WHERE soh.SalesOrderID IS NULL
ORDER BY c.CustomerID;
GO 23

------------------------------------------------------------
-- 9) Show indexes on Product table
------------------------------------------------------------
EXEC sp_helpindex 'SalesLT.Product';
GO

------------------------------------------------------------
-- 10) Performance test (enable statistics in SSMS)
------------------------------------------------------------
-- Uncomment these if you want IO/TIME stats:
-- SET STATISTICS IO ON;
-- SET STATISTICS TIME ON;

SELECT *
FROM SalesLT.SalesOrderDetail
WHERE ProductID = 870;
GO
