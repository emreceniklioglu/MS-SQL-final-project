-- 1. Master Key oluþtur
USE AdventureWorks2022;
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'StrongMasterKey@123';

-- 2. Sertifika oluþtur
CREATE CERTIFICATE TdeCert WITH SUBJECT = 'TDE Certificate';

-- 3. Database Encryption Key oluþtur
USE AdventureWorks2022;
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE TdeCert;

-- 4. Þifrelemeyi etkinleþtir
ALTER DATABASE AdventureWorks2022 SET ENCRYPTION ON;

-- Tüm veritabanlarýnýn þifreleme durumu
SELECT 
    db.name,
    dek.encryption_state,
    CASE dek.encryption_state
        WHEN 0 THEN 'No encryption'
        WHEN 1 THEN 'Unencrypted'
        WHEN 2 THEN 'Encryption in progress'
        WHEN 3 THEN 'Encrypted'
        WHEN 4 THEN 'Key change in progress'
        WHEN 5 THEN 'Decryption in progress'
        WHEN 6 THEN 'Protection change in progress'
    END AS encryption_state_desc,
    dek.percent_complete,
    dek.key_algorithm,
    dek.key_length
FROM sys.dm_database_encryption_keys dek
JOIN sys.databases db ON dek.database_id = db.database_id;