
-- Adres üzerinde nonclustered index olmadan sorgu
SELECT * FROM [AdventureWorks2022].[Production].[TransactionHistory]
WHERE ProductID = 879;

-- Adres üzerinde nonclustered index olmadan sorgu
SELECT * FROM [AdventureWorks2022].[Production].[TransactionHistory];

-- Adres sütunu üzerinde nonclustered index oluþturup yapýlan sorgu
CREATE NONCLUSTERED INDEX index_Productid ON [Production].[TransactionHistory] (ProductID);

SELECT * FROM [Production].[TransactionHistory] WHERE ProductID = 879;