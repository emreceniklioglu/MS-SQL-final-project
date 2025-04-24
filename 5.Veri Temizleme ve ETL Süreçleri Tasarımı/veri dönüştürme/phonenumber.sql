
 SELECT * FROM [AdventureWorks2022].[Person].[PersonPhone] WHERE LEN(PhoneNumber) != 12;

UPDATE [AdventureWorks2022].[Person].[PersonPhone]
SET PhoneNumber = LTRIM(SUBSTRING(PhoneNumber, CHARINDEX(')', PhoneNumber) + 1, LEN(PhoneNumber)))
WHERE PhoneNumber LIKE '1 (%)%' AND LEN(PhoneNumber) != 12;

SELECT * FROM [AdventureWorks2022].[Person].[PersonPhone] WHERE LEN(PhoneNumber) != 12;


