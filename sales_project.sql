--Number of ORDERS AND TOTAL SALES BY YEARS
  SELECT YEAR(Order_Date) as Years, SUM(SALES) as 'Sales ($)', COUNT(1) as 'Number of Orders'
  FROM  [Portfolio].[dbo].[Orders]
  GROUP BY YEAR(ORDER_DATE)
  ORDER BY 1

--Number of ORDERS AND TOTAL SALES BY Region
  SELECT Region, SUM(SALES) as 'Sales ($)', COUNT(1) as 'Number of Orders'
  FROM  [Portfolio].[dbo].[Orders]
  GROUP BY Region
  ORDER BY 3 DESC


--Growth SALES BY SUB-CATEGORY between 2011 and 2012
SELECT *,
       ROUND((sales2012-sales2011)*100/sales2012, 1) AS 'growth sales (%)'
FROM(
     SELECT Product_Sub_Category,
	        SUM( IIF( YEAR(ORDER_DATE) = 2011, sales, 0)) AS sales2011,
            SUM( IIF( YEAR(ORDER_DATE) = 2012, sales, 0)) AS sales2012
     FROM [Portfolio].[dbo].[Orders]
     GROUP BY Product_Sub_Category
    ) sub_category
ORDER BY 4 DESC;


--Return rate by year
SELECT YEAR(ord.ORDER_DATE) Years, COUNT(ORD.ORDER_id) 'Total Orders', COUNT(DISTINCT ret.Order_ID) 'Returned Orders',
(CAST(COUNT(DISTINCT ret.Order_ID)  AS DECIMAL))/(CAST(COUNT(ORD.ORDER_id) AS DECIMAL))*100 'Return %'
FROM Portfolio..Orders ord
LEFT JOIN Portfolio..Returns ret
	on ord.Order_ID = ret.Order_ID

GROUP BY YEAR(ord.ORDER_DATE)
ORDER BY 2