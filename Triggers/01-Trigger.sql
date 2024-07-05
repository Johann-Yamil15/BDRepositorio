--SINTAXIS DE TRIGGER
--CREATE TRIGGER Nombre_trigger
--on nombre_table
--AFTER INSERT DELETE UPDATE
--AS
--BEGIN
---------CODIGO
--END

/*
CREATE TRIGGER Verificar_insercion_tabla1
on table 1
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
--INSERT INTO table1
--value (1,'nombre1')

--update tabla 1
--set nombre='nombrenuevo'
--where id=1;

--DELETE From Tabla 1
--where id=1

Print 'se ejecuto el tiger en la tabal 1'
END
*/
create database pruebatriggerg3
go

use pruebatriggerg3
go

create table tabla1(
id int not null primary key,
nombre varchar(50) not null
);
go

--TRIGGER

--Trigger que verifica el evento que se ejecuto
Create or alter trigger tg_verificar_insercion
on tabla1
after insert
as
begin
Print 'se ejecuto el elemento insert en la tabal 1'
end

insert into tabla1
values (1, 'nombre1')


Create or alter trigger tg_verificar_actualizar
on tabla1
after update
as
begin
Print 'se ejecuto el elemento Update en la tabal 1'
end

update tabla1
set nombre='nombrenuevo'
where id=1;

Create or alter trigger tg_verificar_eliminar
on tabla1
after Delete
as
begin
Print 'se ejecuto el elemento Delete en la tabal 1'
end

Delete tabla1
where id=1

insert into tabla1
values (1, 'Nombre1')

drop trigger tg_verificar_insercion
drop trigger tg_verificar_eliminar

create or alter trigger verificar_contenido_inserted
on tabla1
after insert
as 
begin
--ver los datos de la tabla inserted
select * from inserted
end

insert into tabla1
values(2,'Nombre 2')

select * from tabla1

insert into tabla1
values(4,'Nombre4'),(5,'Nombre5')

use Northwind

create or alter trigger verificar_inserted_categoria
on Categories
after insert
as 
begin
select [CategoryID],[CategoryName],[Description] from inserted;
end

insert into Categories([CategoryName],[Description])
values ('Categoria nueva', 'Prueba tigger')

create or alter trigger verificar_update_categoria
on Categories
after update
as 
begin
select [CategoryID],[CategoryName],[Description] from inserted;
select [CategoryID],[CategoryName],[Description] from deleted;
end
 
 begin transaction--conjunto de actividades se cumple o nad
 rollback-- se cansela transaccion
 /*
 confirmar --> Commit
 cancelar -->Rollback
 */

update Northwind.dbo.Categories
set CategoryName = 'Categoria otra',
Description = 'si esta bien'
where CategoryID = 9

--NUEVO TRIGGER
create or alter trigger verificar_update_delete
on Categories
after insert,update,delete
as 
begin
if exists(select 1 from inserted) or  not exists(select 1 from deleted)
begin
print ('Existen datos en la tabla inserted, se adjunto un insert')
end
if exists(select 1 from deleted) and not exists (select 1 from inserted)
begin
print ('Existen datos en la tabla delete, se realizo un delete')
end
else if exists(select 1 from deleted) and not exists (select 1 from inserted)
begin
print ('Existen en las dos tablas, se realizo un update')
end
end

insert into Categories([CategoryName],[Description])
values ('Categoria10', 'Pimpon')

delete Categories
where [CategoryName] = 'Categoria10'

update Northwind.dbo.Categories
set CategoryName = 'Categoria otra2',
Description = 'si esta bien'
where CategoryID = 9


/**/

use pruebatriggerg3

create table empleado(
id int not null primary key,
nombre varchar(50) not null, 
salario money not null
);
go

create or alter trigger verificar_salario
on empleado
after insert
as 
begin
if exists(select 1 from inserted) or  not exists(select 1 from deleted)
begin
declare
@salarionuevo money
set @salarionuevo = (select salario from inserted)
if @salarionuevo > 50000
begin
raiserror('el salario es mayor a 50000 y no esta permitido', 16,1)
rollback transaction;
end
end
end

insert into empleado(id, nombre, salario)
values (1,'jaun', 35000.00)