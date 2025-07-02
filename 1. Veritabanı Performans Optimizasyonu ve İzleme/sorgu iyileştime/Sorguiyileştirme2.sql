-- sorgu
SELECT * FROM [AdventureWorks2022].[Sales].[SalesOrderDetail]
WHERE SalesOrderDetailID = 102482;

-- sorguyu optimizie etmek i�in nonclustered index tan�ml�yoruz
CREATE NONCLUSTERED INDEX index_Productid 
ON [AdventureWorks2022].[Sales].[SalesOrderDetail] (SalesOrderDetailID); 

SELECT * FROM [Sales].[SalesOrderDetail] WHERE SalesOrderDetailID = 102482;