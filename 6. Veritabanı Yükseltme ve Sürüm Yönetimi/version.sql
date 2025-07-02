CREATE TABLE DatabaseVersion (
    VersionID INT IDENTITY(1,1) PRIMARY KEY,
    VersionNumber VARCHAR(20),
    Description NVARCHAR(500),
    Status VARCHAR(50),
    AppliedDate DATETIME DEFAULT GETDATE()
);

-- Ýlk versiyon kaydý (baþlangýç)
INSERT INTO DatabaseVersion (VersionNumber, Description, Status)
VALUES ('1.0.0', 'Initial setup - version system created', 'Completed');

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100)
);

INSERT INTO DatabaseVersion (VersionNumber, Description, Status)
VALUES ('1.1.0', 'Created Customers table', 'Completed');

SELECT *FROM DatabaseVersion
