# Fall 2022 Data Science Intern Challenge


Please complete the following questions, and provide your thought process/work. You can attach your work in a text file, link, etc. on the application page. Please ensure answers are easily visible for reviewers!

## Question 1: Given some sample data, write a program to answer the following: click here to access the required data set
On Shopify, we have exactly 100 sneaker shops, and each of these shops sells only one model of shoe. We want to do some analysis of the average order value (AOV). When we look at orders data over a 30 day window, we naively calculate an AOV of $3145.13. Given that we know these shops are selling sneakers, a relatively affordable item, something seems wrong with our analysis.

a. Think about what could be going wrong with our calculation. Think about a better way to evaluate this data.
- A potential mistake in the team's original calculation of AOV could have been that they did not check for outliers or the data's distribution. Since the arithmatic mean weights each point equally, outliers can drag the mean up or down. In this instance, we have extreme outliers pulling the mean up. 

b. What metric would you report for this dataset?
- I would report a bootstrap sample median as the AOV of this dataset.  

c. What is its value?
- Using bootstrap sample median, we find the AOV to be 284$.

## Question 2: For this question you’ll need to use SQL. Follow this link to access the data set required for the challenge. Please use queries to answer the following questions. Paste your queries along with your final numerical answers below.
1. How many orders were shipped by Speedy Express in total?
- 54 orders were shipped by Speedy Express
2. What is the last name of the employee with the most orders?
- Peacock is the last name of the employee with the most orders with 40 orders.
3. What product was ordered the most by customers in Germany?
- Boston Crab Cakes were ordered the most with 160 units sold.



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
