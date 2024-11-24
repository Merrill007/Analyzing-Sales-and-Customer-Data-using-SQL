# Analyzing-Sales-and-Customer-Data-using-SQL

## Table of Contents
1. [Introduction](#introduction)
2. [Objective](#objective)
3. [Dataset and Tools](#dataset-and-tools)
4. [SQL Queries](#SQL-Queries)
5. [Insights and Findings](#insights-and-findings)
6. [Conclusions](#conclusions)

---

## Introduction

This project involves analyzing the **AdvantureWorks2019** database to extract insights about sales, customer behaviour, product performance and supplier efficiency. The project uses SQL to query and analyze data, uncovering key patterns, and actionable insights.

--- 

## Objective

The goal of this project are:
1. To identify top customers by revenue.
2. To analyze product performance and popularity.
3. To evaluate sales trend over time.
4. To assess supplier performance and reliability.

---

## Dataset and Tools

The project uses the **AdvantureWorks2019** database.  It contains data related to a ficitious company taht sells bicycles and cycling accessories.

**Data Dictionary**
- **Sales.SalesOrderHeader**: This table contains header information for sales orders, including order ID, order date, customer ID, salesperson ID, and shipping information.
- **Sales.Customer**: This table contains information about customers, including customer ID, name, geographic location, demographic information, and contact information.
- **Sales.SalesPerson**: This table contains information about salespeople, including salesperson ID, name, and demographic information.
- **Sales.SalesTerritory**: This table contains information about sales territories, including territory ID, name, and geographic information.
- **Production.Product**: This table contains information about products, including product ID, name, category, cost, and price.
- **Sales.SalesOrderDetail**: This table contains detailed information about sales orders, including order ID, product ID, quantity, unit price, and discount.
- **Purchasing.PurchaseOrderHeade**r: This table contains header information for purchase orders, including order ID, order date, vendor ID, and shipping information.
- **Purchasing.Vendor**: This table contains information about vendors, including vendor ID, name, and contact information.
- **Purchasing.PurchaseOrderDetail**: This table contains detailed information about purchase orders, including order ID, product ID, quantity, unit price, and discount.
- **Production.WorkOrder**: This table contains information about production work orders, including work order ID, product ID, start and end dates, and status.

![image](https://github.com/user-attachments/assets/c31029cd-67ab-4e34-8880-3b5747618883)\

---

## SQL Queries

1. **What are the most popular products among customers?**

```sql
SELECT TOP 10 Product.Name, SUM(SalesOrderDetail.OrderQty) AS TotalQuantitySold
FROM Production.Product AS Product
JOIN Sales.SalesOrderDetail AS SalesOrderDetail 
ON Product.ProductID = SalesOrderDetail.ProductID
GROUP BY Product.Name
ORDER BY TotalQuantitySold DESC;
```

2. WHAT ARE THE MOST PROFITABLE PRODUCTS?

```sql
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

