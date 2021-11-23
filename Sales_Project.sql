
--Find Max quantity sold in a transaction
SELECT MAX(Quantity) as 'max(Quantity)', count(*) as count
  FROM [Portfolio].[dbo].[OrderDetails$]

--Find Unique Products where quantity is 3 in all the transactions
SELECT DISTINCT(PRODUCTID), Quantity
FROM [Portfolio].[dbo].[OrderDetails$]
WHERE Quantity = 3
ORDER BY ProductID asc, Quantity desc

--Find the product category that has maximum products
SELECT PRODUCTCATEGORY, COUNT(*) AS count
FROM [Portfolio].[dbo].[Products$]
GROUP BY PRODUCTCATEGORY
ORDER BY 2 DESC

--Find the state where most stores are present
SELECT PropertyState, count(*) as count
FROM [Portfolio].[dbo].[PropertyInfo$]
GROUP BY PropertyState 
ORDER BY 2 DESC

--Find the top 3 Product IDs that did maximum sales in terms of quantity
SELECT TOP 3 ProductID, sum(Quantity) as 'Total Quanity'
FROM [Portfolio].[dbo].[OrderDetails$]
GROUP BY ProductID
ORDER BY 2 DESC

--Find top 5 product names that did maximum sales in terms of quantity
SELECT TOP 5 PRO.ProductName, sum(DET.Quantity) as 'Total Quanity'
FROM [Portfolio].[dbo].[OrderDetails$] DET
LEFT JOIN [Portfolio].[dbo].[PRODUCTS$] PRO
	ON DET.ProductID = PRO.ProductID
GROUP BY PRO.ProductName
ORDER BY 2 DESC

--Find top 3 cities that did maximum sales
SELECT TOP 3 INFO.PropertyCity, SUM(PRO.PRICE * DET.QUANTITY) AS SALES 
FROM [Portfolio].[dbo].[OrderDetails$] DET
LEFT JOIN [Portfolio].[dbo].[PRODUCTS$] PRO
	ON DET.ProductID = PRO.ProductID
LEFT JOIN [Portfolio].[dbo].[PropertyInfo$] INFO
	ON DET.PropertyID = INFO.[Prop ID]
GROUP BY INFO.PropertyCity
ORDER BY 2 DESC

--Find top 3 products in a city 'Arlington'
SELECT TOP 3 PRO.ProductName, INFO.PropertyCity, SUM(PRO.PRICE * DET.QUANTITY) AS SALES 
FROM [Portfolio].[dbo].[OrderDetails$] DET
LEFT JOIN [Portfolio].[dbo].[PRODUCTS$] PRO
	ON DET.ProductID = PRO.ProductID
LEFT JOIN [Portfolio].[dbo].[PropertyInfo$] INFO
	ON DET.PropertyID = INFO.[Prop ID]
WHERE INFO.PropertyCity = 'Arlington'
GROUP BY INFO.PropertyCity, PRO.ProductName
ORDER BY SALES DESC
