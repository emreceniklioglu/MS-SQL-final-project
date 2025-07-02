
-- Adres �zerinde nonclustered index olmadan sorgu
SELECT * FROM [AdventureWorks2022].[Production].[TransactionHistory]
WHERE ProductID = 879;

-- Adres �zerinde nonclustered index olmadan sorgu
SELECT * FROM [AdventureWorks2022].[Production].[TransactionHistory];

-- Adres s�tunu �zerinde nonclustered index olu�turup yap�lan sorgu
CREATE NONCLUSTERED INDEX index_Productid ON [Production].[TransactionHistory] (ProductID);

SELECT * FROM [Production].[TransactionHistory] WHERE ProductID = 879;