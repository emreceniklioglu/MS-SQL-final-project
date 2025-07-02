-- Full back up oluþturma
BACKUP DATABASE [AdventureWorks2022] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\FullBackUp.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'AdventureWorks2022-Full Database Backup', 
STATS = 10
GO
-- Full back up kontrol
RESTORE HEADERONLY
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\FullBackUp.bak'
GO
