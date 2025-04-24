-- Sunucu d�zeyinde login olu�tur
CREATE LOGIN berkan WITH PASSWORD = 'berkan1234';

-- Veritaban� i�inde kullan�c� olu�tur
USE AdventureWorks2022;
CREATE USER berkan FOR LOGIN berkan;

EXEC sp_addrolemember 'db_datareader', 'berkan';
EXEC sp_addrolemember 'db_denydatawriter', 'berkan';