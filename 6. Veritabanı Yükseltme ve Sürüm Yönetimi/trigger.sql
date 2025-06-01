CREATE TABLE SchemaChanges (
    ChangeID INT IDENTITY(1,1) PRIMARY KEY,
    EventType NVARCHAR(100),     -- Örn: CREATE_TABLE
    ObjectName NVARCHAR(100),    -- Örn: Customers
    SqlCommand NVARCHAR(MAX),    -- Gerçek SQL komutu
    ChangeDate DATETIME DEFAULT GETDATE(),
    PerformedBy NVARCHAR(100)    -- Kullanýcý adý
);

SELECT * FROM SchemaChanges

CREATE TRIGGER trg_SchemaChangeLogger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
    DECLARE @data XML = EVENTDATA();
    INSERT INTO SchemaChanges (
        EventType,
        ObjectName,
        SqlCommand,
        PerformedBy
    )
    VALUES (
        @data.value('(/EVENT_INSTANCE/EventType)[1]', 'NVARCHAR(100)'),
        @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(100)'),
        @data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'NVARCHAR(MAX)'),
        SYSTEM_USER
    );
END;

CREATE TABLE TestLogTable2 (
    ID INT PRIMARY KEY,
    Name NVARCHAR(50)
);

SELECT * FROM SchemaChanges ORDER BY ChangeDate DESC;

