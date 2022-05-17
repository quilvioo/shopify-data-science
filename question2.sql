-- a. How many orders were shipped by Speedy Express in total?

SELECT s.ShipperName as [Shipper Name], COUNT(*) as [Orders Shipped]
FROM [Orders] o
LEFT JOIN [Shippers] s ON o.ShipperID=s.ShipperID
WHERE s.ShipperName = 'Speedy Express'
;

-- 54

-----------------------------------------------------------------

-- b. What is the last name of the employee with the most orders?

SELECT e.LastName as [Employee Last Name], COUNT(*) as [Orders Count]
FROM [Orders] o
LEFT JOIN [Employees] e ON o.EmployeeID=e.EmployeeID
GROUP BY o.EmployeeID
ORDER BY [Orders Count] DESC
LIMIT 1
;

-- Peacock

-----------------------------------------------------------------

-- c. What product was ordered the most by customers in Germany?

WITH german_purchases AS (
    SELECT p.ProductName, od.Quantity
    FROM [OrderDetails] od
    LEFT JOIN [Orders] o ON od.OrderID=o.OrderID
    LEFT JOIN [Products] p ON od.ProductID=p.ProductID
    LEFT JOIN [Customers] c ON o.CustomerID=c.CustomerID
    WHERE c.Country = 'Germany'
)

SELECT ProductName as [Product Name], SUM(Quantity) as [Units Sold]
FROM german_purchases
GROUP BY ProductName
ORDER BY [Units Sold] DESC
LIMIT 1
;

-- Boston Crab Meat