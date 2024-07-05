# Requerimientos
Una empresa encargada de las ventas de diferentes productos desea crear una base de datos que controles los proveedores, clientes, empleados, categorías de producto y órdenes de compra. Para los proveedores se necesita almacenar un numero de control, nombre de la empresa, dirección (numero, calle, colonia, estado), cp,teléfono, página web, teléfono de contacto o contactos del proveedor, nombre del contacto, email del contacto. Para los empleados se desea almacenar un numero de nómina, nombre completo del empleado, rfc, curp, salario (El salario máximo es de 65000), para las ordenes de compra se necesita almacenar la fecha de creación de la orden, el empleado que la realizo, al cliente que se le vende, la fecha de entrega y los diferentes productos que contiene. El producto debe almacenar un numero de control y una descripción única, status, existencia y un precio. La categoría debe tener un identificador y nombre único de categoría. La compra siempre debe tener un precio de venta que se obtiene del precio unitario del producto y una cantidad vendida. 

# Diagrama E-R
 ![Diagrama Relacional](./img/Diagrama_%20Compra.jpeg)
# Diagrama Relacional

# Creacion BD con Lenguaje SQL-LDD
```sql
--Crear base de datos
Create database DBVentas;
--Utilizar db
Use DBVentas;

--Tabala cliente
Create Table Cliente(
ClienteId int Not null Identity (1,1),
rfc Varchar(20) not null,
Curp Varchar(18) not null,
Nombre Varchar(50) not null,
Apellido1 Varchar(50) not null,
Apellido2 Varchar(50) not null,
constraint PK_Cliente
Primary key (ClienteId),
Constraint unico_rfc
unique (rfc),
constraint unico_curp
unique (Curp)
);

--Tabala Empleado
Create Table Empleado(
Empleadoid int Not null Identity (1,1),
Nombre Varchar(50) not null,
Apellido1 Varchar(50) not null,
Apellido2 Varchar(50) null,
rfc Varchar(20) not null,
Curp Varchar(18) not null,
NumeroExterno int null,
Calle varchar(30) not null,
Salario money not null,
Numeronomina int not null,
constraint PK_Empleado
Primary key (Empleadoid),
Constraint unico_rfc_Empleado
unique (rfc),
constraint unico_curp_Empleado
unique (Curp),
constraint chk_salario
Check(Salario>0.0 and Salario<=100000),
--Check(Salario between 0.0 and 100000)
constraint unico_nomina_empleado
unique(Numeronomina)
);

--Tabala TelefonoProvedor
Create Table TelefonoProvedor(
Telefonoid int Not null,
Provedorid int not null,
NumeroTelefono Varchar(15),
constraint PK_Telefono_Provedor
Primary key (Telefonoid, Provedorid),
Constraint Fk_Telefono_Provedor
foreign key (Provedorid)
references Proveedor(ProveedorId)
on delete cascade
on update cascade
);

--Tabala Provedor
Create Table Proveedor(
ProveedorId int Not null Identity (1,1),
NombreEmpresa Varchar(50) not null,
rfc Varchar(20) not null,
Calle varchar(20) null,
Colonia varchar(50) not null,
CodigoPostal int not null,
PaginaWeb varchar(80) null,
constraint PK_Proveedor
Primary key (ProveedorId),
Constraint unico_PaginaWeb2
unique (PaginaWeb),
constraint unico_NombreEmpresa2
unique (NombreEmpresa)
);

--Tabala TelefonoProvedor
Create Table ContactoProvedor(
Contactoid int not null identity (1,1),
Proveedorid int not null,
Nombre Varchar(50) not null,
Apellido1 Varchar(50) not null,
Apellido2 Varchar(50) null,
Constraint Pk_ContactoProvedor
Primary key (Contactoid)
);

alter table contactoprovedor
add constraint fk_ContactoProvedor_Proveedor
Foreign Key (Proveedorid)
references Proveedor(ProveedorId)

--Tabla Producto
create table Producto(
Numerocontrol int not null identity(1,1),
descripcion Varchar(50)not null,
precio money not null,
[status] int not null,
existencia int not null,
proveedorid int not null,
Constraint pk_Producto
primary key(numerocontrol),
Constraint unico_descripcion
unique(descripcion),
Constraint chk_Precio
--precio>=1 and precio<=200000
check(precio between 1 and 200000),
Constraint chk_Status
--status in (0,1)
Check([Status] = 1 or [status] = 0),
constraint chk_existente
check(existencia>0),
constraint Fk_producto_Proveedor
Foreign key (proveedorid)
references Proveedor(ProveedorId)
);

--Tabla OrdenCompra
Create table OrdenCompra(
numeroorden int not null identity(1,1),
fechacompra date not null,
fechaentrega date not null,
cliennteid int not null,
empleadoid int not null,
constraint pk_ordencompra
primary key(numeroorden),
constraint fk_ordencompra_cliente
foreign key(cliennteid)
references Cliente(ClienteId),
constraint fk_ordencompra_empleado
foreign key(empleadoid)
references Empleado(Empleadoid),
);

--Tabla detallecompra
Create table detallecompra(
productoid int not null,
numeroorden int not null,
cantidad int not null,
preciocompra money not null,
Constraint Pk_detallecompra
Primary key (productoid, numeroorden),
constraint fk_ordencompra_producto
foreign key(productoid)
references Producto(Numerocontrol),
constraint fk_ordencompra_compra
foreign key (numeroorden)
references OrdenCompra(numeroorden)
);
```
# Llenar BD con Lenguaje SQl-MLD
```sql
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

```