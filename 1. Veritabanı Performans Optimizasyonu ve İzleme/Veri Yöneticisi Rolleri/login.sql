-- Sunucu düzeyinde login oluþtur
CREATE LOGIN berkan WITH PASSWORD = 'berkan1234';

-- Veritabaný içinde kullanýcý oluþtur
USE AdventureWorks2022;
CREATE USER berkan FOR LOGIN berkan;

EXEC sp_addrolemember 'db_datareader', 'berkan';
EXEC sp_addrolemember 'db_denydatawriter', 'berkan';