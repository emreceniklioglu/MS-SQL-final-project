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

        -- Yeni versiyon daha b�y�k olmal�
        IF @Current IS NOT NULL AND @Current >= @NewVersion
        BEGIN
            RAISERROR('Bu versiyon zaten uygulanm�� veya daha yeni.', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END

        -- Versiyon kayd�n� ge�ici olarak ekle
        INSERT INTO DatabaseVersion (VersionNumber, Description, Status)
        VALUES (@NewVersion, @Description, 'In Progress');

        -- !!! Buraya versiyon de�i�ikli�i yap�lacak SQL komutlar� yaz�l�r !!!

        -- �rnek: ALTER TABLE, CREATE TABLE vs.
        -- �rnek alan� bo� b�rak�ld�, d��ar�dan �al��t�r�l�r.

        -- Ba�ar�l�ysa stat�y� g�ncelle
        UPDATE DatabaseVersion
        SET Status = 'Completed'
        WHERE VersionNumber = @NewVersion;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        -- Hata durumunda status'u g�ncelle
        UPDATE DatabaseVersion
        SET Status = 'Failed - ' + ERROR_MESSAGE()
        WHERE VersionNumber = @NewVersion;

        RAISERROR('Versiyon uygulama ba�ar�s�z oldu.', 16, 1);
    END CATCH
END;
