use Northwind
-- 1.Realizar un sp que permita visualizar lo vendido a los clientes
--mostrando el nombre del cliente y en año variable
CREATE OR ALTER PROCEDURE sp_venta_cliente
    @year as int
As
BEGIN
    SELECT
        c.CompanyName as 'Cliente',
        o.OrderDate as 'Fecha',
        SUM(od.UnitPrice * od.Quantity) as 'Total'
    FROM
        customers AS c
        INNER JOIN
        orders AS o ON c.CustomerID = o.CustomerID
        INNER JOIN
        [Order Details] AS od ON od.OrderID = o.OrderID
    WHERE 
    DATEPART(YEAR, o.OrderDate) = @year
    GROUP BY 
     c.CompanyName, o.OrderDate
    ORDER BY
     c.CompanyName, o.OrderDate
END;

EXEC sp_venta_cliente 1998


SELECT
    c.CompanyName as 'Cliente',
    o.OrderDate as 'Fecha',
    SUM(od.UnitPrice * od.Quantity) as 'Total'
FROM
    customers AS c
    INNER JOIN
    orders AS o ON c.CustomerID = o.CustomerID
    INNER JOIN
    [Order Details] AS od ON od.OrderID = o.OrderID
WHERE 
    DATEPART(YEAR, o.OrderDate) = 1998
GROUP BY 
     c.CompanyName, o.OrderDate
ORDER BY
     c.CompanyName, o.OrderDate

----------------------------------------------------------------
--2. Crear un sp que inserte un producto
----------------------------------------------------------------
CREATE PROCEDURE InsertProduct
    @ProductName NVARCHAR(40),
    @SupplierID INT,
    @CategoryID INT,
    @QuantityPerUnit NVARCHAR(20),
    @UnitPrice MONEY,
    @UnitsInStock SMALLINT,
    @UnitsOnOrder SMALLINT,
    @ReorderLevel SMALLINT,
    @Discontinued BIT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Products (ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued)
    VALUES (@ProductName, @SupplierID, @CategoryID, @QuantityPerUnit, @UnitPrice, @UnitsInStock, @UnitsOnOrder, @ReorderLevel, @Discontinued);
END

---------------------------------------------------------------------


---------------------------------------------------------------------
--3.Crear un sp que inserte en los catálogos customers employers 
--categoris pero el sp debe recibir también como parámetro el catálogo
-- a insertar procedures
---------------------------------------------------------------------
CREATE PROCEDURE InsertIntoCatalog
    @catalog NVARCHAR(50),
    @data NVARCHAR(MAX)  -- Asumimos que los datos se pasan como JSON
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX);

    IF @catalog = 'Customers'
    BEGIN
        DECLARE @CustomerID NVARCHAR(5), @CompanyName NVARCHAR(40), @ContactName NVARCHAR(30),
                @ContactTitle NVARCHAR(30), @Address NVARCHAR(60), @City NVARCHAR(15),
                @Region NVARCHAR(15), @PostalCode NVARCHAR(10), @Country NVARCHAR(15),
                @Phone NVARCHAR(24), @Fax NVARCHAR(24);

        -- Extraer los valores del JSON
        SELECT
            @CustomerID = JSON_VALUE(@data, '$.CustomerID'),
            @CompanyName = JSON_VALUE(@data, '$.CompanyName'),
            @ContactName = JSON_VALUE(@data, '$.ContactName'),
            @ContactTitle = JSON_VALUE(@data, '$.ContactTitle'),
            @Address = JSON_VALUE(@data, '$.Address'),
            @City = JSON_VALUE(@data, '$.City'),
            @Region = JSON_VALUE(@data, '$.Region'),
            @PostalCode = JSON_VALUE(@data, '$.PostalCode'),
            @Country = JSON_VALUE(@data, '$.Country'),
            @Phone = JSON_VALUE(@data, '$.Phone'),
            @Fax = JSON_VALUE(@data, '$.Fax');

        SET @sql = N'INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
                     VALUES (@CustomerID, @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax)';
                     
        EXEC sp_executesql @sql, N'@CustomerID NVARCHAR(5), @CompanyName NVARCHAR(40), @ContactName NVARCHAR(30), 
                                  @ContactTitle NVARCHAR(30), @Address NVARCHAR(60), @City NVARCHAR(15),
                                  @Region NVARCHAR(15), @PostalCode NVARCHAR(10), @Country NVARCHAR(15),
                                  @Phone NVARCHAR(24), @Fax NVARCHAR(24)',
                           @CustomerID, @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax;
    END
    ELSE IF @catalog = 'Employees'
    BEGIN
        DECLARE @EmployeeID INT, @LastName NVARCHAR(20), @FirstName NVARCHAR(10), @Title NVARCHAR(30),
                @TitleOfCourtesy NVARCHAR(25), @BirthDate DATETIME, @HireDate DATETIME, @Address NVARCHAR(60),
                @City NVARCHAR(15), @Region NVARCHAR(15), @PostalCode NVARCHAR(10), @Country NVARCHAR(15),
                @HomePhone NVARCHAR(24), @Extension NVARCHAR(4), @Photo VARBINARY(MAX), @Notes NTEXT,
                @ReportsTo INT, @PhotoPath NVARCHAR(255);

        -- Extraer los valores del JSON
        SELECT
            @EmployeeID = JSON_VALUE(@data, '$.EmployeeID'),
            @LastName = JSON_VALUE(@data, '$.LastName'),
            @FirstName = JSON_VALUE(@data, '$.FirstName'),
            @Title = JSON_VALUE(@data, '$.Title'),
            @TitleOfCourtesy = JSON_VALUE(@data, '$.TitleOfCourtesy'),
            @BirthDate = JSON_VALUE(@data, '$.BirthDate'),
            @HireDate = JSON_VALUE(@data, '$.HireDate'),
            @Address = JSON_VALUE(@data, '$.Address'),
            @City = JSON_VALUE(@data, '$.City'),
            @Region = JSON_VALUE(@data, '$.Region'),
            @PostalCode = JSON_VALUE(@data, '$.PostalCode'),
            @Country = JSON_VALUE(@data, '$.Country'),
            @HomePhone = JSON_VALUE(@data, '$.HomePhone'),
            @Extension = JSON_VALUE(@data, '$.Extension'),
            @Photo = CAST(JSON_VALUE(@data, '$.Photo') AS VARBINARY(MAX)),
            @Notes = JSON_VALUE(@data, '$.Notes'),
            @ReportsTo = JSON_VALUE(@data, '$.ReportsTo'),
            @PhotoPath = JSON_VALUE(@data, '$.PhotoPath');

        SET @sql = N'INSERT INTO Employees (EmployeeID, LastName, FirstName, Title, TitleOfCourtesy, BirthDate, HireDate, Address, City, Region, PostalCode, Country, HomePhone, Extension, Photo, Notes, ReportsTo, PhotoPath)
                     VALUES (@EmployeeID, @LastName, @FirstName, @Title, @TitleOfCourtesy, @BirthDate, @HireDate, @Address, @City, @Region, @PostalCode, @Country, @HomePhone, @Extension, @Photo, @Notes, @ReportsTo, @PhotoPath)';

        EXEC sp_executesql @sql, N'@EmployeeID INT, @LastName NVARCHAR(20), @FirstName NVARCHAR(10), @Title NVARCHAR(30),
                                  @TitleOfCourtesy NVARCHAR(25), @BirthDate DATETIME, @HireDate DATETIME, @Address NVARCHAR(60),
                                  @City NVARCHAR(15), @Region NVARCHAR(15), @PostalCode NVARCHAR(10), @Country NVARCHAR(15),
                                  @HomePhone NVARCHAR(24), @Extension NVARCHAR(4), @Photo VARBINARY(MAX), @Notes NTEXT,
                                  @ReportsTo INT, @PhotoPath NVARCHAR(255)',
                           @EmployeeID, @LastName, @FirstName, @Title, @TitleOfCourtesy, @BirthDate, @HireDate, @Address, @City, @Region, @PostalCode, @Country, @HomePhone, @Extension, @Photo, @Notes, @ReportsTo, @PhotoPath;
    END
    ELSE IF @catalog = 'Categories'
    BEGIN
        DECLARE @CategoryID INT, @CategoryName NVARCHAR(15), @Description NTEXT, @Picture VARBINARY(MAX);

        -- Extraer los valores del JSON
        SELECT
            @CategoryID = JSON_VALUE(@data, '$.CategoryID'),
            @CategoryName = JSON_VALUE(@data, '$.CategoryName'),
            @Description = JSON_VALUE(@data, '$.Description'),
            @Picture = CAST(JSON_VALUE(@data, '$.Picture') AS VARBINARY(MAX));

        SET @sql = N'INSERT INTO Categories (CategoryID, CategoryName, Description, Picture)
                     VALUES (@CategoryID, @CategoryName, @Description, @Picture)';

        EXEC sp_executesql @sql, N'@CategoryID INT, @CategoryName NVARCHAR(15), @Description NTEXT, @Picture VARBINARY(MAX)',
                           @CategoryID, @CategoryName, @Description, @Picture;
    END
    ELSE
    BEGIN
        RAISERROR('El catálogo especificado no es válido.', 16, 1);
        RETURN;
    END
END

---------------------------------------------------------------------
--sp total de ventas agrupado por proveedor de tablas

--hacer consultas en orderdetails y suppliers

--Inserte o actualice los registros nuevos o los cambios en la tabla Product,
--Suppliers,Customers,EAmployees,tomando como base Northwind 

create or alter procedure SP_VENTASDEPROVEEDOR
@year int, @month int, @day int
as 
begin

select* from Orders

select s.CompanyName,
sum (od.UnitPrice * quantity) as Total
from
Suppliers as s
inner join Products as p
on s.SupplierID=P.SupplierID
inner join [Order Details] as od
on p.ProductID=od.ProductID
inner join Orders as o 
on o.OrderID=od.OrderID
where  datepart (year,o.OrderDate)=@year
and datepart (month, o.OrderDate)=@month
and datepart (day,o.OrderDate)=@day
group by s.CompanyName
order by s.companyName; 
end 
go

--Formas de ejecutar un sp

execute SP_VENTASDEPROVEEDOR  1997,07,04

exec SP_VENTASDEPROVEEDOR  1996,07,04

exec SP_VENTASDEPROVEEDOR @day=04,@year=1996,@month=04

exec SP_VENTASDEPROVEEDOR @day=

--crear un sp que premita visualizar cuantas ordenes se han haecho por año y paselect s.CompanyName,

create or alter procedure SPOrdenesPaisyAño
@pais varchar(50),
@año int
as
begin
select count (*) as [Numero de ordenes]
from Orders as o
where o.shipcountry = @pais and datepart(year,o.OrderDate)=@año

end 
go

exec SPOrdenesPaisyAño @pais='Austria', @año=1996