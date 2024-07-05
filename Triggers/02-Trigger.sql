use Northwind
go

select * from Orders
select * from [Order Details]
select * from Products where ProductID = 11


create or alter trigger verificar_salario
on [Order Details]
after insert
as 
begin
begin transaction
if exists(select 1 from inserted) or  not exists(select 1 from deleted)
begin
declare
@cantidad smallint, @stock smallint,@ProductId int
set @cantidad = (select Quantity from inserted)
set @ProductId = (select ProductID from inserted)
set @stock = (select UnitsInStock from Products where ProductID = @ProductId)
if @cantidad <= @stock
begin
update Northwind.dbo.Products
set UnitsInStock = (UnitsInStock-@cantidad)
where ProductID = @ProductId
print ('Compra exitosa ')
commit
end
else 
begin
raiserror('no se cuenta con la cantidad  de producto', 16,1)
rollback transaction;
end
end
end

begin transaction

create or alter procedure sp_insert_order_details
--Variables
@id as int,
@proid as int,
@Quant as smallint,
@Discount as real
as
begin
if exists (select 1 from Products where ProductID = @proid)
begin

declare
@Unitp money
select @Unitp = UnitPrice from Products where ProductID = @proid
insert into [Order Details](OrderID, ProductID, UnitPrice, Quantity, Discount)
values (@id,@proid,@Unitp,@Quant,@Discount)
end
else
begin
print ('Algo salio mal')
end
end

exec sp_insert_order_details @id = 10248, @proid = 11,@Quant = 2,@Discount = 0;

DELETE [Order Details] WHERE ProductID = 11  and OrderID = 10248