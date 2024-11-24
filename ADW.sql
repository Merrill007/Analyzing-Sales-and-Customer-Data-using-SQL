-- DEFINE THE OBJECTIVES OF THE ANALYSIS
-- 

-- EXECUTIVES, BUSINESS MANAGERS, OTHERS

-- GAIN KNOWLEDGE ABOUT CUSTOMER BEHAVIOUR
-- PRODUCT PERFORMANCE 
-- SALES TRENDS

-- SALES
-- PRODUCTS
-- PURCHASE


-- WHAT ARE THE MOST POPULAR PRODUCTS AMONG CUSTOMERS


SELECT TOP 10 Product.Name, SUM(SalesOrderDetail.OrderQty) AS TotalQuantitySold
FROM Production.Product AS Product
JOIN Sales.SalesOrderDetail AS SalesOrderDetail 
ON Product.ProductID = SalesOrderDetail.ProductID
GROUP BY Product.Name
ORDER BY TotalQuantitySold DESC;

-- WHAT ARE THE MOST PROFITABLE PRODUCTS?

SELECT * FROM Sales.SalesOrderDetail;

SELECT * FROM Production.Product;

SELECT TOP 10
    p.Name, 
    SUM(od.LineTotal) AS Total_Sales,
    SUM(od.LineTotal - (od.OrderQty * p.StandardCost)) AS TotalProfit,
    (SUM(od.LineTotal - (od.OrderQty * p.StandardCost)) / SUM(OD.LineTotal)) * 100 AS ProfitMargin
FROM Production.Product AS P
JOIN Sales.SalesOrderDetail od 
ON p.ProductID = od.ProductID
GROUP BY p.Name
ORDER BY ProfitMargin DESC;


-- ARE THERE ANY PATTERNS OR TRENDS IN PRODUCT SALES OVER TIME?

SELECT * FROM Sales.SalesOrderDetail;

SELECT * FROM Sales.SalesOrderHeader;


SELECT 
    CONVERT(date, MAX(SOH.OrderDate)) AS MaxOrderDate,
    YEAR(SOH.OrderDate) AS OrderYear,
    MONTH(SOH.OrderDate) AS OrderMonth,
    SUM(SOD.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader SOH 
JOIN Sales.SalesOrderDetail SOD 
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY YEAR(SOH.OrderDate), MONTH(SOH.OrderDate)
ORDER BY OrderYear, OrderMonth;


-- PRODUCT POPULARITY BY GEOGRAPHIC REGION


SELECT TOP 10 P.Name ProductName, ST.Name TerritoryName, SUM(od.OrderQty) AS TotalQuantitySold
FROM Sales.SalesOrderDetail od 
JOIN Production.Product p ON od.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader oh ON od.SalesOrderID = OH.SalesOrderID
JOIN SALES.SalesTerritory st ON OH.TerritoryID = ST.TerritoryID
GROUP BY p.name, st.Name
ORDER BY TotalQuantitySold DESC;

-- WHICH GEOGRAPHIC REGIONS GENERATE THE MOST SALES

SELECT TOP 10 ST.Name TerritoryName, 
    SUM(OH.TotalDue) AS TotalSales,
    AVG(od.OrderQty) AvgOrderQunatity,
    AVG(OD.LineTotal) AvgOrderValue
FROM Sales.SalesOrderDetail od 
JOIN Production.Product p ON od.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader oh ON od.SalesOrderID = OH.SalesOrderID
JOIN SALES.SalesTerritory st ON OH.TerritoryID = ST.TerritoryID
GROUP BY st.Name
ORDER BY TotalSales DESC;

SELECT TOP 10 ST.[Group] GeographicRegion, SUM(OH.TotalDue) AS TotalSales
FROM Sales.SalesOrderDetail od 
JOIN Production.Product p ON od.ProductID = p.ProductID
JOIN Sales.SalesOrderHeader oh ON od.SalesOrderID = OH.SalesOrderID
JOIN SALES.SalesTerritory st ON OH.TerritoryID = ST.TerritoryID
GROUP BY st.[Group]
ORDER BY TotalSales DESC;

-- HOW HAS SALES VOLUME CHANGED OVER TIME

SELECT YEAR(OrderDate) AS SalesYaer, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY SalesYaer;







