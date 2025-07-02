--1. Test Amaçlý Sakýncalý (Injection'a açýk) Stored Procedure Oluþtur
USE AdventureWorks2022;
GO

CREATE PROCEDURE dbo.usp_InsecureEmployeeSearch
    @LastName NVARCHAR(100)
AS
BEGIN
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = 'SELECT BusinessEntityID, FirstName, LastName 
                FROM Person.Person 
                WHERE LastName = ''' + @LastName + '''';

    EXEC sp_executesql @sql;
END;
GO

--Normal Kullaným:
EXEC dbo.usp_InsecureEmployeeSearch @LastName = 'Smith';

--SQL Injection Saldýrýsý: "OR 1=1" sayesinde tüm çalýþanlarý döndürür. Bu klasik bir SQL injection örneðidir.
EXEC dbo.usp_InsecureEmployeeSearch @LastName = 'Smith'' OR 1=1 --';

--Güvenli Versiyon: Parametreli Sorgu Kullan
USE AdventureWorks2022;
GO
CREATE PROCEDURE dbo.usp_SecureEmployeeSearch
    @LastName NVARCHAR(100)
AS
BEGIN
    SELECT BusinessEntityID, FirstName, LastName
    FROM Person.Person
    WHERE LastName = @LastName;
END;
GO

--Güvenli kullaným: Parametre doðrudan SQL'e gömülmediði için injection burada iþe yaramaz.
EXEC dbo.usp_SecureEmployeeSearch @LastName = 'Smith';
EXEC dbo.usp_SecureEmployeeSearch @LastName = 'Smith'' OR 1=1 --';


