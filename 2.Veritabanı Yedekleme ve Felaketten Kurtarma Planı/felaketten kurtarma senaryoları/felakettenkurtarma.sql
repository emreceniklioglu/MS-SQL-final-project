SELECT * FROM [AdventureWorks2022].[Sales].[CurrencyRate] where ToCurrencyCode ='ARS'

DELETE FROM [Sales].[CurrencyRate]
      WHERE ToCurrencyCode ='ARS'

-- En sonki ana dönmek için Transaction log back up geri yükleme iþlemi. Bunun için FullBackUp.bak ve diff.bak da gereklidir.
USE master
RESTORE DATABASE [AdventureWorks2022] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\FullBackUp.bak' 
WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5

RESTORE DATABASE [AdventureWorks2022] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\diff.bak' 
WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5

RESTORE LOG [AdventureWorks2022] 
FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\Transaction.bak' 
WITH  FILE = 1,  NOUNLOAD,  STATS = 5

GO
