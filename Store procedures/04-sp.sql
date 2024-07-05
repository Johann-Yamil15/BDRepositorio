--sp total de ventas agrupado por proveedor de tablas

--hacer consultas en orderdetails y suppliers

--Inserte o actualice los registros nuevos o los cambios en la tabla Product,
--Suppliers,Customers,EAmployees,tomando como base Northwind 

use Northwind
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