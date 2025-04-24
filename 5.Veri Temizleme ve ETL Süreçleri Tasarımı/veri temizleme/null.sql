SELECT * FROM [AdventureWorks2022].[Person].[Address] WHERE AddressLine2 IS NULL;

-- 1. �nce ba��ml� indeksi sil
DROP INDEX IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode 
ON [AdventureWorks2022].[Person].[Address];

-- 2. S�tunu sili
ALTER TABLE [AdventureWorks2022].[Person].[Address]
DROP COLUMN AddressLine2;

SELECT  top(100)* FROM [AdventureWorks2022].[Person].[Address];
