-- transaction log back up alma
BACKUP LOG [AdventureWorks2022]
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\Transaction.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'AdventureWorks2022-Full Database Backup', STATS = 10
GO

-- transaction back up kontrol
RESTORE HEADERONLY
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\Transaction.bak'
GO