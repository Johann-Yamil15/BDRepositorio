/*
Las transacciones son fundamentales para asegurar la consistencia y la integridad de los datos
transaccion:es una unidad de trabajo que se ejecuta de manera completamente exitosa o no se ejecuta en absoluto

Begin transaction: inicia una nueva transaccion
Commit transaction: confirma todos los cambios realizados durante la transaccion
Rollback transaction: revierte todos los cambios realizados durante la transaccion
*/

-- Ejercicio 1:
-- --> Realizar un Venta dentro de la base de datos Northwind  utilizando transacciones y stores Procedures
use Northwind
go

create or alter procedure ps_insertOrder
    @CustomerID nchar(5),
    @EmployeeID int,
    @OrderDate datetime,
    @RequiredDate datetime,
    @ShippedDate datetime,
    @ShipVia int,
    @Freight money = null,
    @ShipName nvarchar(40) = null,
    @ShipAddress nvarchar(60) = null,
    @ShipCity nvarchar(15) = null,
    @ShipRegion nvarchar(15) = null,
    @ShipPostalCode nvarchar(10) = null,
    @ShipCountry nvarchar(15),
    @ProductID int, 
    @Quantity smallint,
    @Discount real
as
begin
    begin transaction
        begin try
            -- Insertar en la tabla Orders
            insert into Northwind.dbo.Orders(CustomerID, EmployeeID,OrderDate, RequiredDate, ShippedDate,ShipVia,Freight,ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry) 
            values(@CustomerID, @EmployeeID,@OrderDate, @RequiredDate, @ShippedDate,@ShipVia,@Freight,@ShipName, @ShipAddress, @ShipCity, @ShipRegion, @ShipPostalCode, @ShipCountry)
            
            -- Obtener el Id Insertado en la orden 
            declare @OrderID int;
            set @OrderID = scope_identity();

            -- Insertar en detalle Orden el producto
                --Obtener el Precio del producto a insertar
            declare @precioVenta money;
            if exists(select 1 from Northwind.dbo.Products where ProductID=@ProductID)
            begin
                select @precioVenta = p.UnitPrice from Northwind.dbo.Products as p where ProductID=@ProductID;
                insert into Northwind.dbo.[Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount) values(@OrderID, @ProductID, @precioVenta, @Quantity, @Discount)
                --Actualizar la tabla products reducioendo el unitsinstock con cantidad vendida
                update products set UnitsInStock = UnitsInStock - @Quantity where ProductID = @ProductID
            end
            else 
            begin
                raiserror('El producto no se encuentra',1,16);
                rollback
            end
            commit transaction
        end try
        begin catch 
            rollback transaction
            declare @mensajeError varchar(400) 
            set @mensajeError = error_message()
            print @mensajeError   
        end catch
end
GO

EXEC sp_InserterOrder

select * from products WHERE ProductID = 9

select MAX(OrderID) from Orders

SELECT * FROM [Order Details]
WHERE OrderID = 11077


SELECT * FROM Orders
WHERE OrderID = 11077

