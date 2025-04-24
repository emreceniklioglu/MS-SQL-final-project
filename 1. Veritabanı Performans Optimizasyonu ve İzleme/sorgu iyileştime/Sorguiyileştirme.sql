-- sorgu
SELECT * FROM [AdventureWorks2022].[Production].[WorkOrder]
WHERE ProductID = 3;

-- sorguyu optimizie etmek i�in nonclustered index tan�ml�yoruz
CREATE NONCLUSTERED INDEX index_Productid 
ON [AdventureWorks2022].[Production].[WorkOrder] (ProductID); 

SELECT * FROM [AdventureWorks2022].[Production].[WorkOrder] WHERE ProductID= 3;
