  --Find total revenue from each branch in March 2019.
  SELECT Branch, SUM(Total) as Revenue
  FROM [Portfolio].[dbo].[Supermarket Sales]
  WHERE YEAR(Date)= 2019 and MONTH(Date) = 3
  GROUP BY Branch 
  ORDER BY Revenue DESC

  --Find total revenue of the product category and the rank in 2019
  SELECT [Product line], SUM(Total) as Revenue, RANK() over (ORDER BY SUM(Total) DESC) as Sales_Rank
  FROM [Portfolio].[dbo].[Supermarket Sales]
  GROUP BY [Product line]
  ORDER BY Revenue DESC

  --Find Invoice ID that has the highest Rating
WITH cte_subquery ([Invoice ID], Rating)
AS 
	(SELECT [Invoice ID], Rating 
     FROM [Portfolio].[dbo].[Supermarket Sales]
	 GROUP BY [Invoice ID], Rating)
SELECT * 
FROM cte_subquery
WHERE Rating = 
	 (SELECT max(Rating) 
	  FROM cte_subquery)

  --Find number of transactions in Branch A with the membership
  SELECT count(subq.[Invoice ID]) as '# of Transactions'
  FROM (
		SELECT * FROM [Portfolio].[dbo].[Supermarket Sales]
		 WHERE [Customer type] = 'Member') subq
  WHERE subq.Branch = 'A'