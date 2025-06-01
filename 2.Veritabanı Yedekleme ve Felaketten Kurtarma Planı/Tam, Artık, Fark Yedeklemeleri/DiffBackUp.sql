-- differantial back up alma
BACKUP DATABASE [AdventureWorks2022] 
TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\diff.bak' 
WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'AdventureWorks2022-Full Database Backup', STATS = 10
GO

-- differantial back up kontrol
RESTORE HEADERONLY
FROM DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\diff.bak'
GO