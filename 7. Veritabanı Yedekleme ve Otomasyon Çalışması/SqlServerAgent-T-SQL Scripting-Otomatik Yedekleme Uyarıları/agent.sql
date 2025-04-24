BACKUP DATABASE [AdventureWorks2022] TO  DISK = N'C:\projeler\AdventureWorks2022.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'AdventureWorks2022-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

-- T-SQL Scripting ile yedekleme raporlar� olu�turma.
SELECT 
    'AdventureWorks2022' AS DatabaseName,
    MAX(b.backup_finish_date) AS LastBackupDate,
    DATEDIFF(HOUR, MAX(b.backup_finish_date), GETDATE()) AS HoursSinceLastBackup
FROM msdb.dbo.backupset b
WHERE b.database_name = 'AdventureWorks2022' AND b.type = 'D';
