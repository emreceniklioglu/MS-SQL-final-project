--Yede�in bozuk olup olmad���n� kontrol eder (geri y�klemeden).
RESTORE VERIFYONLY
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\FullBackUp.bak'
RESTORE VERIFYONLY
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\diff.bak' 
RESTORE VERIFYONLY
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\Transaction.bak' 

-- Manuel olarak geri y�kleme kontrol testi 
USE [AdventureWorks2022]
GO
SELECT *
  FROM [AdventureWorks2022].[Sales].[CurrencyRate] where ToCurrencyCode = 'BRL'

DELETE FROM [Sales].[CurrencyRate]
WHERE ToCurrencyCode = 'BRL'

USE [master]
RESTORE DATABASE [AdventureWorks2022]�
FROM� DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\FullBackUp.bak'�
WITH� FILE = 1,� NORECOVERY,� NOUNLOAD,� REPLACE,� STATS = 5
RESTORE DATABASE [AdventureWorks2022]�
FROM� DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\diff.bak'
WITH� FILE = 1,� RECOVERY,� NOUNLOAD,� STATS = 5
GO