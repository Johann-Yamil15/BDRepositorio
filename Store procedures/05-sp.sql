--store prosedure(parametros de salida)
-- Crear un store prosedure que calcule el area de un circulo
create or alter Procedure sp_calcular_area_circulo
@radio float, --parametro de entrad
@area float OUTPUT --Parametro de salida
AS
Begin
set @area = PI() * @radio * @radio
end
go

DECLARE @resultado FLOAT;
EXEC sp_calcular_area_circulo @radio = 22.3, @area = @resultado OUTPUT;

PRINT 'El valor del área es: ' + CAST(@resultado AS VARCHAR);
go

CREATE OR ALTER PROCEDURE sp_obtener_informacion_empleado
    @empleadoid INT = -1,
    @apellido NVARCHAR(20) OUTPUT,
    @nombre NVARCHAR(10) OUTPUT
AS
BEGIN
    IF @empleadoid <> -1
    BEGIN
        SELECT @nombre = FirstName, @apellido = LastName
        FROM Employees
        WHERE EmployeeID = @empleadoid;
    END
    ELSE
    BEGIN
        PRINT 'El valor del empleado no es válido';
    END
END;


DECLARE @firsname NVARCHAR(10),
        @lasname NVARCHAR(20);

EXEC sp_obtener_informacion_empleado  @apellido = @lasname OUTPUT, @nombre = @firsname OUTPUT;

PRINT 'El nombre es: ' + @firsname;
PRINT 'El apellido es: ' + @lasname;
go

-----
CREATE OR ALTER PROCEDURE sp_obtener_informacion_empleado2
    @empleadoid INT,
    @nombre NVARCHAR(10) OUTPUT,
    @apellido NVARCHAR(20) OUTPUT,
    @existe int OUTPUT
AS
BEGIN
    SET @existe = (SELECT COUNT(*) FROM Employees WHERE EmployeeID =@empleadoid)
	PRINT @existe
    IF @existe > 0
	    BEGIN
        SET @existe = 1;

        SELECT @nombre = FirstName, @apellido = LastName
        FROM Employees
        WHERE EmployeeID = @empleadoid;
		    END
    ELSE 
    BEGIN
	if @existe = 0
	begin
        PRINT 'El empleado con EmployeeID ' + CAST(@empleadoid AS NVARCHAR) + ' no existe.';
    END
END
end;

DECLARE @firsname NVARCHAR(10),
        @lasname NVARCHAR(20),
        @employeeExists int;

EXEC sp_obtener_informacion_empleado2 
    @empleadoid = 10, 
    @nombre = @firsname OUTPUT, 
    @apellido = @lasname OUTPUT,
    @existe = @employeeExists OUTPUT;

IF @employeeExists = 1
BEGIN
    PRINT 'El nombre es: ' + @firsname;
    PRINT 'El apellido es: ' + @lasname;
END
ELSE
BEGIN
    PRINT 'El empleado no existe.';
END
go
------
CREATE OR ALTER PROCEDURE SP_OBTENER_VENTAS_CLIENTE
@customerid nchar(5),
@Fechainicio date,
@fechafinal date,
@total decimal(10,2) output
AS
BEGIN
set @total = (select sum(od.Quantity*od.UnitPrice) as total
from [Order Details] as od
inner join Orders  as o
on od.OrderID = o.OrderID
where CustomerID = @customerid and
o.OrderDate BETWEEN @Fechainicio and @fechafinal)
end

declare
@resultado decimal(10,2)
exec  SP_OBTENER_VENTAS_CLIENTE @customerid = 'VINET',@Fechainicio = '1997-01-01',@fechafinal = '1998-01-01', @total = @resultado OUTPUT
PRINT @resultado