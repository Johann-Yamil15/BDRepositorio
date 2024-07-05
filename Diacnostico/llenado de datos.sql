use DBVentas

select * from [Northwind].dbo.Customers
go

select * from Cliente;
go

--Insertar en la tabla cliente
insert into Cliente(rfc,Curp,Nombre,Apellido1,Apellido2)
values('jlhg19830406x9x', 'JPJ050415HHGMRHA3','Alfreds Futterkiste', 'XYZ2SDW', 'WJXIWKJXI')
insert into Cliente(rfc,Curp,Nombre,Apellido1,Apellido2)
values('LKJFERGHJUYTFGx', 'DMWSKDJ0415HHGMR6','Ana Trujillo Emparedados y helados', 'XYGF', 'IUTRDRIUJ')
go

--eliminar tabla cliente

DELETE Cliente
go

--comando para reiniciar el identity de una tabla
DBCC CHECKIDENT (Cliente, reseed, 0)
go

--Crear una tabla a partir de una consulta
select top 0 EmployeeID as 'empleadoid', LastName as 'Apellido',
FirstName as 'PrimerNombre',
BirthDate as 'FechaNacimiento',
HireDate as 'FechaContratacion',
[address] as 'Direccion',
City as 'Ciudad',
region,PostalCode as 'CodigoPostal',
country as 'Pais'
into empleado2
from Northwind.dbo.Employees
go

select top 5 * from Northwind.dbo.[Order Details]
go

drop table empleado2
go

select * from empleado2
go

alter table empleado2
add constraint pk_empleado2
Primary key (empleadoid)
go

--inserrtar datos
insert into empleado2(empleadoid, Apellido, PrimerNombre, FechaNacimiento, FechaContratacion, Direccion, Ciudad,region, CodigoPostal, Pais)
select EmployeeID as 'empleadoid', LastName as 'Apellido',
FirstName as 'PrimerNombre',
BirthDate as 'FechaNacimiento',
HireDate as 'FechaContratacion',
[address] as 'Direccion',
City as 'Ciudad',
region,PostalCode as 'CodigoPostal',
country as 'Pais'
from Northwind.dbo.Employees
go

--consultas
select * from empleado2;
select * from Cliente;
select * from empleado;
select * from OrdenCompra;
select * from Northwind.dbo.Products;


insert into empleado (Nombre, Apellido1,Apellido2,Curp,rfc,NumeroExterno,Calle,Salario,Numeronomina)
values('Alan', 'Santiago','Molina', 'almasdfgh', 'sdfghkjhgf', 23, 'Calle del infierno', 67890.9, 12345),
('Yamileth', 'Mejia', 'Rangel', 'ymr871234dfrtg','scddhjjwf', NULL, 'Calle del ambre', 76890.9, 23455),
('Moyses', 'Santiago', 'Isidro', 'sim234568765g','ytrdgkikl', NULL, 'Calle del gordura', 20000, 98765)

insert into OrdenCompra values
(GETDATE(),'2024-06-10',1,1),
(GETDATE(),'2024-06-10',2,2),
(GETDATE(),'2024-07-11',3,3)



--slecciona la fecha actual del sistema
select GETDATE()

select * from Proveedor
select * from Northwind.dbo.Suppliers

insert into Proveedor
select SupplierID, CompanyName, PostalCode, 'calle de la soledad',city,2345 as cp, 'www.prueba.com.mx' as 'paginaweb' from Northwind.dbo.Suppliers

--Eliminar los registros de una tabla
Delete Proveedor

insert into Producto(Numerocontrol,descripcion,precio,
[status],existencia,proveedorid)
select ProductID, ProductName,
UnitPrice,Discontinued , UnitsInStock, SupplierID
from Northwind.dbo.Products

insert into detallecompra
values(1,1,10,(select precio from Producto where Numerocontrol = 1))

update Producto
set precio =20.2
where Numerocontrol =1

insert into detallecompra
values(1,2,30,(select precio from Producto where Numerocontrol = 1))

--Seleccionar las ordenes de compra realizadas al producto
select*,(cantidad * preciocompra) as importe from detallecompra
where productoid = 1

--seleccionar el total a pagar de las ordenes que contienen
--el producto1
select sum(cantidad * preciocompra) as 'total' from detallecompra
