
SELECT CASE SERVERPROPERTY('IsIntegratedSecurityOnly') 
WHEN 1 THEN 'Windows Authentication Mode' 
WHEN 0 THEN 'Mixed Mode'
END as [Authentication Mode]

--SQL Login olu�tur
-- Veritaban� kullan�c�s� ve yetkiler
CREATE LOGIN user2 WITH PASSWORD = 'Password123';
CREATE USER user2 FOR LOGIN user2;
ALTER ROLE db_datareader ADD MEMBER user2;  -- sadece okuma yetkisi


-- izinleri test etme
SELECT * FROM [AdventureWorks2022].[Sales].[Currency]; -- Ba�ar�l�
DELETE FROM Sales.SalesOrderHeader;   -- Yetki hatas�