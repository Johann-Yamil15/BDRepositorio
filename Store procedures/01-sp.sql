use Northwind
--Declaracion de variables

Declare @x int;
set @x = 10
PRINT 'El valor de x es: '+cast(@x as varchar)

if @x >=0
BEGIN
    PRINT ' El numero es positivo'
END
else
BEGIN
    PRINT ' El numero es negativo'
end

DECLARE @i as int;
set @i = 1
while(@i <=10)
BEGIN
    PRINT cast(@i as varchar)
    set @i = @i + 1
end

--crear un sp(store procedures)
CREATE procedure prosedure_ciclo
AS
BEGIN
    DECLARE @i as int;
    set @i = 1
    while(@i <=10)
BEGIN
        PRINT 'El primer valor es'+cast(@i as varchar)
        set @i = @i + 1
    end
end;

Declare @ii INT;
set @ii = 1
WHILE @ii <= 2
BEGIN
    exec prosedure_ciclo
    set @ii = @ii +1
END

-- relizar un sp_suma1 para dos numeros cualquiera
--crear un sp(store procedures)
CREATE procedure sp_suma1
AS
BEGIN
    DECLARE @e as int;
    set @e = 8
    DECLARE @r as int;
    set @r = 5

    PRINT 'La suma de '+cast(@e as varchar)+' + '+cast(@r as varchar)+'es: '+ cast(@e+@r as varchar)
end;

EXEC sp_suma1





SELECT
    c.CompanyName AS 'Nombre del Cliente',
    SUM(od.Quantity * od.UnitPrice) AS 'Total'
FROM
    customers AS c
    INNER JOIN
    orders AS o ON c.CustomerID = o.CustomerID
    INNER JOIN
    [Order Details] AS od ON od.OrderID = o.OrderID
WHERE 
    DATEPART(YEAR, o.OrderDate) = 1996
GROUP BY 
    c.CompanyName;

CREATE or ALTER proc sp_ventasporcliente
    --parametros
    @year as int
AS
BEGIN
    SELECT
        c.CompanyName AS 'Nombre del Cliente',
        SUM(od.Quantity * od.UnitPrice) AS 'Total'
    FROM
        customers AS c
        INNER JOIN
        orders AS o ON c.CustomerID = o.CustomerID
        INNER JOIN
        [Order Details] AS od ON od.OrderID = o.OrderID
    WHERE 
    DATEPART(YEAR, o.OrderDate) = @year
    GROUP BY 
    c.CompanyName;
end

---Ejecutar sp
EXEC sp_ventasporcliente 1997
EXECUTE sp_ventasporcliente 1996
EXEC sp_ventasporcliente @year = 1998

--Ejercicio Realizar un store procedures que muestre un reporte de ventas,
--por cliente y producto agrupado de un rango de fechas
CREATE OR ALTER PROCEDURE sp_ventasrango
    @startDate DATE,
    @endDate DATE
AS
BEGIN
    SELECT
        c.CompanyName AS 'Nombre del Cliente',
        p.ProductName AS 'Nombre del Producto',
        SUM(od.Quantity * od.UnitPrice) AS 'Total'
    FROM
        customers AS c
        INNER JOIN
        orders AS o ON c.CustomerID = o.CustomerID
        INNER JOIN
        [Order Details] AS od ON od.OrderID = o.OrderID
        INNER JOIN
        products AS p ON od.ProductID = p.ProductID
    WHERE 
        o.OrderDate BETWEEN @startDate AND @endDate
    GROUP BY 
        c.CompanyName, p.ProductName;
END;

EXEC sp_ventasrango @startDate = '1996-01-01', @endDate = '1998-12-31';

--Ejersicio 2: realizar un estore prosedure que inserte un cliente nuevo
CREATE OR ALTER PROCEDURE sp_insertarcliente
    @CustomerID nchar(5),
    @CompanyName nvarchar(40),
    @ContactName nvarchar(30) = NULL,
    @ContactTitle nvarchar(30) = NULL,
    @Address nvarchar(60) = NULL,
    @City nvarchar(15) = NULL,
    @Region nvarchar(15) = NULL,
    @PostalCode nvarchar(10) = NULL,
    @Country nvarchar(15) = NULL,
    @Phone nvarchar(24) = NULL,
    @Fax nvarchar(24) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO [dbo].[Customers] (
        [CustomerID],
        [CompanyName],
        [ContactName],
        [ContactTitle],
        [Address],
        [City],
        [Region],
        [PostalCode],
        [Country],
        [Phone],
        [Fax]
    )
    VALUES (
        @CustomerID,
        @CompanyName,
        @ContactName,
        @ContactTitle,
        @Address,
        @City,
        @Region,
        @PostalCode,
        @Country,
        @Phone,
        @Fax
    );

    SELECT SCOPE_IDENTITY() AS NewCustomerId; -- Opcional: devuelve el ID del nuevo cliente insertado
END

BEGIN TRANSACTION
EXEC sp_insertarcliente
 @CustomerID ='GTIG3',
    @CompanyName ='Patito de hule',
    @ContactName ='Edith Campos',
    @ContactTitle ='Tutora',
    @Address ='calle del infierno',
    @City ='tula',
    @Region ='sur',
    @PostalCode = '42800',
    @Country = 'mexico',
    @Phone ='1234567890'


