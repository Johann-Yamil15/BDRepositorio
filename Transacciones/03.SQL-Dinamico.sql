---store prosedure que visualise de acuerdo a cualquier tabla
use Northwind
go

CREATE OR ALTER PROCEDURE sp_visualizacion
    @tabla AS NVARCHAR(50)
AS
BEGIN
    DECLARE @sql NVARCHAR(50);

    SET @sql = 'SELECT * FROM ' + QUOTENAME(@tabla);

    EXEC sp_executesql @sql;
END
GO

exec sp_visualizacion orders


