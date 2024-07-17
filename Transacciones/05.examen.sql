use Northwind
go

--actualizar el precio de los productos y los guarde en una tabal de historicos id, id del producto que se modifico ,precioold y precio new
Create table ProductPriceHistory
(
    id int IDENTITY(1,1),
    productid int,
    oldprice Money,
    newprice Money,
    changedate Datetime Default Getdate()
);

-----------------------
-----------------------
-----------------------
select * from products;
GO

Create or alter procedure usp_actualizarPrecio
    @Producto as int,
    @NewPrice as Money
as
begin
    BEGIN TRANSACTION
        BEGIN TRY
            declare
            @price money
            set @price= (select UnitPrice
                from Products
                where ProductID = @Producto)
            Update Products
            Set UnitPrice = @NewPrice
            where ProductID = @Producto
            Print ('se actulizo la lista de precios')
            insert into ProductPriceHistory
                    (productid,oldprice,newprice)
                select ProductID, @price, @NewPrice
                from Products
                where ProductID = @Producto
            COMMIT TRANSACTION
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            DECLARE @mensajeError VARCHAR(50)
            set @mensajeError = ERROR_MESSAGE()
            PRINT @mensajeError
        END CATCH
END
GO

exec usp_actualizarPrecio @Producto = 6, @NewPrice = 32.00;

select * from ProductPriceHistory;
go



--crear un store procedure que elimine una orden y orden details y actulizar el stock

/*
	Elimine una orden actualizar en estock del producto
*/

create or alter proc sp_deleteOrdenCompra 
 @OrderID int
as
begin
    begin transaction
    begin try
	declare @Cantidad int

	/* Usando marge */
		merge into products as tgt
        using (
            select Quantity, ProductID
            from [Order Details] where OrderID = @OrderID
        ) AS src 
        ON tgt.ProductID = src.ProductID
        when MATCHED THEN
            update set tgt.UnitsInStock = (tgt.UnitsInStock+src.Quantity);
			delete [Order Details] where OrderID=@OrderID;
			delete Orders where OrderID=@OrderID;
		/* Usando inner */
			update Products set UnitsInStock= p.UnitsInStock+od.Quantity from Products as p 
			join [Order Details] as od on p.ProductID=od.ProductID where OrderID=11077
			delete [Order Details] where OrderID=@OrderID;
			delete Orders where OrderID=@OrderID;
       /* commit transaction */
    end try
    begin catch 
        rollback transaction
        declare @mensajeError varchar(400) 
        set @mensajeError = error_message()
        print @mensajeError
    end catch
end
go

exec sp_deleteOrdenCompra @OrderID=11077

select * from Products where ProductID=2
select * from Products where ProductID=3

select * from [Order Details] where OrderID=11077
  rollback transaction
  go