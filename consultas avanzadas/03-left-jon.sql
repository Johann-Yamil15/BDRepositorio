
---crea base de datos ñpara demostrar el uso del left join
create database pruebajoins;

-- Utilizamos la base de datos
use pruebajoins

-- crear tabla de categorias 
create table Categorias(
    categoriaid int not null identity(1,1),
    nombre VARCHAR(50) not null DEFAULT 'no categoria',
    constraint pk_Categorias
    primary key(categoriaid)
)

--Create tabla productos
create table Producto(
    productoid int not null identity(1,1),
    nombre VARCHAR(50) not null,
    existencia int not null,
    precio money not null,
    categoriaid int,
    constraint pk_Producto
    primary key(productoid),
    constraint unico_nombre
    unique(nombre),
    constraint fk_Producto_Categorias
    FOREIGN key(categoriaid)
    REFERENCES Categorias(categoriaid)
)

-- agregar registros a la tabal categoria
insert into Categorias(nombre)
VALUES ('LB'),
('LACTEOS'),
('ROPA'),
('BEBIDAS'),
('CARNES FRIAS')
SELECT * FROM Categorias

-- agregar registros a productos

insert into Producto(nombre, existencia,precio, categoriaid)
VALUES('Refrigerador', 3, 10000.0, 1),
        ('Estufa' , 3, 9000.04, 1),
        ('Crema' , 2, 10.5, 2),
        ('Yogurt' , 3, 13.45, 2);

        select *
        from Producto as p 
        INNER join Categorias as c 
        on p.categoriaid = c.categoriaid

        --consulta utilizando un left join
        select *
        from Categorias as c 
        left join Producto as p
        on p.categoriaid = c.categoriaid
        --seleccionar todas las consultas que no tengan   asignado categoria
        select c.categoriaid, c.nombre
        from Categorias as c 
        left join Producto as p
        on p.categoriaid = c.categoriaid
        where p.productoid is null

-- right join
        select *
        from Categorias as c 
        right join Producto as p
        on p.categoriaid = c.categoriaid
        where p.productoid is null
 --full join
        select *
        from Categorias as c 
        full join Producto as p
        on p.categoriaid = c.categoriaid

        ---ejersicio
        -- 1. crear una base de datos de datos llamadass ejerciciosJoins
                create database ejerciciosJoins;
        use ejerciciosJoins;
        -- 2. crear un atabla empleados tomando como base la tabla Employees de norwind (no tomar todos los campos)\
        select * from Northwind.dbo.Employees;

        select employeeid as 'empleadoid',
        CONCAT(FirstName,' ',LastName) as 'nombreCompleto',
        Title as 'titulo',
        HireDate as 'fechacontratacion'
        into ejerciciosJoins.dbo.empleado
        from Northwind.dbo.Employees

        select * from ejerciciosJoins.dbo.empleado;

        -- 3. llenar la tabla con una consulta a la tabla Employees
        insert into ejerciciosJoins.dbo.empleado(nombreCompleto, titulo, fechacontratacion)
        select 
        CONCAT(FirstName,' ',LastName) as 'nombreCompleto',
        Title as 'titulo',
        HireDate as 'fechacontratacion'
        from Northwind.dbo.Employees

        select top 0 *
        into ejerciciosJoins.dbo.dimempleados
        FROM ejerciciosJoins.dbo.empleado

        select * from dimempleados
        select * from empleado
        -- 4. agrgare nuevos datos a la tabla empleados por lo menos dos 
       insert into ejerciciosJoins.dbo.dimempleados(nombreCompleto, titulo, fechacontratacion)
        select 
        e.nombreCompleto as 'nombreCompleto',
        e.titulo as 'titulo',
        e.fechacontratacion as 'fechacontratacion'
        from empleado as e


         insert into ejerciciosJoins.dbo.empleado(nombreCompleto, titulo, fechacontratacion)
        values('Nancy Davolio','Sales Representative','1994-11-15 00:00:00.000'),
        ('Andrew Fuller','Sales Manager','1994-11-15 00:00:00.000')
     
       
        
        -- actualizar la tabla empleados con los nuevos registros, la cual se llamaran en una nueva tabla llamada dimempleados
        insert into ejerciciosJoins.dbo.dimempleados(nombreCompleto, titulo, fechacontratacion)
         select *
        from empleado as e
        left join dimempleados as d
        on e.nombreCompleto = e.nombreCompleto
       


       ----------------------------------------
       ----------------JOINS-------------------
       ----------------------------------------
       -- 1. Crear la base de datos
CREATE DATABASE ejerciciosJoins;
USE ejerciciosJoins;

-- 2. Crear la tabla empleado tomando como base la tabla Employees de Northwind
SELECT 
    EmployeeID AS 'empleadoid',
    CONCAT(FirstName, ' ', LastName) AS 'nombreCompleto',
    Title AS 'titulo',
    HireDate AS 'fechacontratacion'
INTO 
    ejerciciosJoins.dbo.empleado
FROM 
    Northwind.dbo.Employees;

-- 3. No es necesario repetir la inserción ya que se llenó en el paso anterior

-- 4. Crear una nueva tabla dimempleados con la misma estructura que empleado
SELECT TOP 0 *
INTO 
    ejerciciosJoins.dbo.dimempleados
FROM 
    ejerciciosJoins.dbo.empleado;

-- 5. Agregar nuevos datos a la tabla empleado
INSERT INTO ejerciciosJoins.dbo.empleado(nombreCompleto, titulo, fechacontratacion)
VALUES
    ('Nancy Davolio', 'Sales Representative', '1994-11-15 00:00:00.000'),
    ('Andrew Fuller', 'Sales Manager', '1994-11-15 00:00:00.000');

-- 6. Actualizar la tabla dimempleados con los nuevos registros de la tabla empleado
INSERT INTO ejerciciosJoins.dbo.dimempleados(nombreCompleto, titulo, fechacontratacion)
SELECT 
    e.nombreCompleto,
    e.titulo,
    e.fechacontratacion
FROM 
    ejerciciosJoins.dbo.empleado AS e
LEFT JOIN 
    ejerciciosJoins.dbo.dimempleados AS d
ON 
    e.nombreCompleto = d.nombreCompleto
WHERE 
    d.nombreCompleto IS NULL;

-- Verificar los datos
SELECT * FROM ejerciciosJoins.dbo.empleado;
SELECT * FROM ejerciciosJoins.dbo.dimempleados;

----------------------------------------------------------------------------------------------
create database repasojoins;

use repasojoins;

create table proveedor(
     provid int not null identity(1,1),
     nombre varchar(50) not null,
     limite_credito money not null,
     constraint pk_proveedor
     primary key (provid)
)

create table producto(
    prodid int not null identity(1,1),
    nombre varchar(50) not null,
    existencia int not null,
    precio money not null,
    proveedor int,
    constraint pk_producto
    primary key (prodid),
    constraint fk_producto_proveedor
    foreign key (proveedor)
    references proveedor(provid)
)

--insertar datos en las tablas
insert into proveedor (nombre,limite_credito)
values('proveedor1',10000),
      ('proveedor2',20000),
      ('proveedor3',30000),
      ('proveedor4',40000),
      ('proveedor5',50000)

insert into producto(nombre,existencia,precio,proveedor)
values('producto1',54,45.6,1),
      ('producto2',54,45.6,1),
      ('producto3',54,45.6,2),
      ('producto4',54,45.6,3)

      select * from proveedor

      select * from producto

      --CONSULTAS INNER JOIN--

      --SELECCIONAR TODOS LOS PRODUCTOS QUE TENGAN PROVEEDOR

      select pr.nombre as 'Nombre_Producto', pr.precio as 'precio',
      pr.existencia as 'existencia', p.nombre as 'proveedor'
      from proveedor as p
      inner join producto as pr
      on p.provid=pr.proveedor

      --CONSULTA LEFT JOIN

      --MOSTRAR TODOS LOS PROVEEDORES Y SUS RESPECTIVOS PRODUCTOS

      select pr.nombre as 'Nombre_Producto', pr.precio as 'precio',
      pr.existencia as 'existencia', p.nombre as 'proveedor'
      from proveedor as p
      left join producto as pr
      on p.provid=pr.proveedor

      update proveedor
      set nombre = 'proveedor6'
      where provid = 5;

      select * from proveedor

      update proveedor
      set nombre = 'proveedor5'
      where provid = 5;

      insert into proveedor (nombre,limite_credito)
      values('proveedor6',45000)

      select * from proveedor

      delete from proveedor
      where provid = 7

      update proveedor
      set nombre = 'proveedor6'
      where provid = 6;

      --UTILIZANDO RIGHT JOIN

        select pr.nombre as 'Nombre_Producto', pr.precio as 'precio',
      pr.existencia as 'existencia', p.nombre as 'proveedor'
      from proveedor as p
      right join producto as pr
      on p.provid=pr.proveedor

    --seleccionar todos los proveedores que no tienen asignado productos
   select p.provid as 'existencia', p.nombre as 'proveedor'
      from proveedor as p
      left join producto as pr
      on p.provid=pr.proveedor
      where p.provid is NULL

   --seleccionar todos los proveedores que no tienen asignado Proveedor
   select pr.nombre,pr.precio,precio
      from proveedor as p
      left join producto as pr
      on p.provid=pr.proveedor
      where p.provid is NULL