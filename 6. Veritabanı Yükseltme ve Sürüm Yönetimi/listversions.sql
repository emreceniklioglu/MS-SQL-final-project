CREATE PROCEDURE pr_ListVersions
AS
BEGIN
    SELECT * FROM DatabaseVersion ORDER BY VersionID DESC;
END;
