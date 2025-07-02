USE master;
GO

CREATE SERVER AUDIT Audit_AdventureWorks
TO FILE (
    FILEPATH = 'C:\AuditLogs2\',  -- Bu klasör gerçekten var olmalý
    MAXSIZE = 10 MB,
    MAX_FILES = 5,
    RESERVE_DISK_SPACE = OFF
)
WITH (
    QUEUE_DELAY = 1000,
    ON_FAILURE = CONTINUE
);
GO

USE AdventureWorks2022;
GO

CREATE DATABASE AUDIT SPECIFICATION Audit_Read_Operations
FOR SERVER AUDIT Audit_AdventureWorks
ADD (SELECT ON SCHEMA::HumanResources BY public),   -- Tüm kullanýcýlar için SELECT
ADD (INSERT ON SCHEMA::HumanResources BY public),   -- Tüm kullanýcýlar için INSERT
ADD (DELETE ON SCHEMA::HumanResources BY public)    -- Tüm kullanýcýlar için DELETE
WITH (STATE = ON);
GO

use master
ALTER SERVER AUDIT Audit_AdventureWorks WITH (STATE = ON);

-- Örneðin bir SELECT iþlemi yap
USE AdventureWorks2022;
SELECT * FROM HumanResources.Employee;

-- INSERT denemesi
INSERT INTO HumanResources.EmployeeDepartmentHistory
(BusinessEntityID, DepartmentID, ShiftID, StartDate)
VALUES (1, 3, 2, GETDATE());


SELECT *
FROM sys.fn_get_audit_file('C:\AuditLogs\Audit_AdventureWorks*.sqlaudit', DEFAULT, DEFAULT);
