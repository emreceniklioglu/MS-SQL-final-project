CREATE PROCEDURE pr_ApplyVersion
    @NewVersion VARCHAR(20),
    @Description NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRAN;

        -- En son versiyonu al
        DECLARE @Current VARCHAR(20);
        SELECT TOP 1 @Current = VersionNumber
        FROM DatabaseVersion
        ORDER BY VersionID DESC;

        -- Yeni versiyon daha büyük olmalý
        IF @Current IS NOT NULL AND @Current >= @NewVersion
        BEGIN
            RAISERROR('Bu versiyon zaten uygulanmýþ veya daha yeni.', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END

        -- Versiyon kaydýný geçici olarak ekle
        INSERT INTO DatabaseVersion (VersionNumber, Description, Status)
        VALUES (@NewVersion, @Description, 'In Progress');

        -- !!! Buraya versiyon deðiþikliði yapýlacak SQL komutlarý yazýlýr !!!

        -- Örnek: ALTER TABLE, CREATE TABLE vs.
        -- Örnek alaný boþ býrakýldý, dýþarýdan çalýþtýrýlýr.

        -- Baþarýlýysa statüyü güncelle
        UPDATE DatabaseVersion
        SET Status = 'Completed'
        WHERE VersionNumber = @NewVersion;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        -- Hata durumunda status'u güncelle
        UPDATE DatabaseVersion
        SET Status = 'Failed - ' + ERROR_MESSAGE()
        WHERE VersionNumber = @NewVersion;

        RAISERROR('Versiyon uygulama baþarýsýz oldu.', 16, 1);
    END CATCH
END;
