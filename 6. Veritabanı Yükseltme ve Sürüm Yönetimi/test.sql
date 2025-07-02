-- TRANSACTION KULLANMA
CREATE TABLE Customers3 (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100)
);

EXEC pr_ApplyVersion '1.2.0', 'Customers1 tablosu oluþturuldu.';


-- 1. Sütun varsa ekleme, yoksa ALTER TABLE çalýþtýr
IF NOT EXISTS (
    SELECT * FROM sys.columns
    WHERE object_id = OBJECT_ID('Customers3') AND name = 'Phone'
)
BEGIN
    ALTER TABLE Customers3 ADD Phone NVARCHAR(20);
END

-- 2. Versiyon kaydýný ekle
EXEC pr_ApplyVersion '1.2.1', 'Customers1 tablosuna Phone sütunu eklendi.';


EXEC pr_ApplyVersion '1.2.1', 'Tekrar deneniyor';

SELECT * FROM DatabaseVersion ORDER BY VersionID DESC;

DELETE FROM DatabaseVersion
WHERE VersionNumber = '1.2.0' AND Status LIKE 'Reverted%';


EXEC pr_RollbackVersion '1.2.0';

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Customers3';

