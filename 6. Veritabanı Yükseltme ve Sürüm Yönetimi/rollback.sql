CREATE PROCEDURE pr_RollbackVersion
    @TargetVersion VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        DECLARE @CurrentVersion VARCHAR(20);
        SELECT TOP 1 @CurrentVersion = VersionNumber
        FROM DatabaseVersion
        ORDER BY VersionID DESC;

        IF @CurrentVersion <= @TargetVersion
        BEGIN
            RAISERROR('Rollback versiyonu mevcut versiyondan büyük veya eþit olamaz.', 16, 1);
            ROLLBACK;
            RETURN;
        END

        -- Örnek rollback iþlemi: 'Phone' kolonu varsa kaldýr
        IF EXISTS (
            SELECT * FROM sys.columns
            WHERE object_id = OBJECT_ID('Customers3') AND name = 'Phone'
        )
        BEGIN
            ALTER TABLE Customers3 DROP COLUMN Phone;
        END

        -- Versiyon geçmiþine rollback olarak ekle
        INSERT INTO DatabaseVersion (VersionNumber, Description, Status)
        VALUES (@TargetVersion, 'Rollback to version ' + @TargetVersion, 'Reverted');

        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        UPDATE DatabaseVersion
        SET Status = 'Rollback Failed: ' + ERROR_MESSAGE()
        WHERE VersionNumber = @TargetVersion;

        RAISERROR('Rollback iþlemi baþarýsýz oldu.', 16, 1);
    END CATCH
END;
