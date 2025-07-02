--1. Test Ama�l� Sak�ncal� (Injection'a a��k) Stored Procedure Olu�tur
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

--Normal Kullan�m:
EXEC dbo.usp_InsecureEmployeeSearch @LastName = 'Smith';

--SQL Injection Sald�r�s�: "OR 1=1" sayesinde t�m �al��anlar� d�nd�r�r. Bu klasik bir SQL injection �rne�idir.
EXEC dbo.usp_InsecureEmployeeSearch @LastName = 'Smith'' OR 1=1 --';

--G�venli Versiyon: Parametreli Sorgu Kullan
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

--G�venli kullan�m: Parametre do�rudan SQL'e g�m�lmedi�i i�in injection burada i�e yaramaz.
EXEC dbo.usp_SecureEmployeeSearch @LastName = 'Smith';
EXEC dbo.usp_SecureEmployeeSearch @LastName = 'Smith'' OR 1=1 --';


