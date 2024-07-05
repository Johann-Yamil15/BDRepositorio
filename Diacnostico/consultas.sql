--Consultas Simples (consultas a una sola tabla)
use Northwind;

--Seleccionar todos los costomers (clientes)
select * from Customers

--Proyecci�n
select CustomerID, CompanyName, City,Country
from Customers

-- Selecciona 10 registros de los clientes
select top 10 CustomerID, CompanyName, City,Country
from Customers

-- Alias de columna
-- Country as pais
-- Country pais
-- Country 'Pais'
-- Country as 'Pais'
-- Country as 'Pais de las marabillas'
select CustomerID as 'numero cliente',
CompanyName NombreEmpresa, City as 'City',Country 'pais'
from Customers

-- Alias de tabla
select Customers.CustomerID, Customers.CompanyName, Customers.City,Customers.Country
from Customers

select c.CustomerID, c.CompanyName, c.City, c.Country
from Customers as c

select c.CustomerID, c.CompanyName, c.City, c.Country
from Customers c

-- Campo Calculado
select *,(p.UnitPrice * p.UnitsInStock) as 'Costo inventario' from Products as p

select ProductName as 'Nombre producto',
UnitPrice as 'Existencia',
UnitsInStock as 'precio unitario',
(p.UnitPrice * p.UnitsInStock) as 'Costo inventario'
from Products as p

-- Filtrar Datos
--Clausula where y operadores relacionales
/*
  <   -> menor que
  >   -> mayor que
  <=  -> menor o igual
  >=  -> mayor o igual
  <>  -> diferente
  !=  -> diferente
  =   -> igual a
*/

--Seleccionar todos los clientes alemanes
Select * from Customers
where Country = 'Germay'

--Seleccionar todos los productos que tenga  un stock mayor a 20
--mostrando solamente el nombre del producto, el precio
--y la existencia
Select ProductName as 'Nombre Producto',UnitPrice as ' precio',UnitsInStock as 'Existencia' from Products
where UnitsInStock>=20

Select ProductName as 'Nombre Producto',UnitPrice as ' precio',UnitsInStock as 'Existencia' from Products
where UnitsInStock>=20
order by 1 desc

Select ProductName as 'Nombre Producto',UnitPrice as ' precio',UnitsInStock as 'Existencia' from Products as p
where UnitsInStock>=20
order by p.ProductName desc

--seleccionar todos los clientes ordenados de forma asendente  por pais y dentro del pais ordenados de forma desendente por ciudad
select c.Country, c.City from Customers as c
Where c.Country = 'germany'
order by c.Country, c.City desc

--Eliminar valores repetidos

-- seleccionar los paises de os clientes
select distinct Country, count(Country)
from Customers

select count(distinct Country)
from Customers

--Selecciona todos los productos donde el presio es mayor o igual a 18
select * from Products as p
where p.UnitPrice >= 18.0

select * from Products as p
where p.UnitPrice <> 18.0

select * from Products as p
where p.UnitPrice != 18.0

-- seleccionar todos los productos que tengan un presio
-- entre 18 y 25 dolares
select * from Products as p
where p.UnitPrice >= 18 and p.UnitPrice <= 25 

select * from Products as p
where p.UnitPrice between 18 and 25 --- between = rango

-- seleccionar todos los productos que no tengan un presio
-- entre 18 y 25 dolares
select * from Products as p
where p.UnitPrice not between 18 and 25

select * from Products as p
where not(p.UnitPrice >= 18 and p.UnitPrice <= 25) 

-- Seleccionar todos los productos donde el presio sea mayor a 38 
-- y su existencia sea mayor e igual a 22
select * from Products as p
where p.UnitPrice > 38 and p.UnitsInStock >= 22 

-- Seleccionar todos los clientes de alemania,mexico y francia
select * from Customers as c
where c.Country = 'Mexico' or c.Country = 'Germany' or c.Country = 'France'

select * from Customers as c
where c.Country in ('Mexico','Germany','France')

--Seleccionar todos los clientes que no tengan region
select * from Customers as c
where c.Region is NULL

select * from Customers as c
where c.Region is not NULL

-- Seleccionar todos las ordenes enviadas de juli de 1996
--a abril de 1998 para los empleados Buchanan,Leverling y Davolio(5, 3, 1)
select * from Employees
select * from Orders as o
Where o.ShippedDate between '1996-07-01' and '1998-04-01' and  o.EmployeeID  in (1, 3, 5)

select e.LastName as 'Empleado',
o.ShippedDate as 'Fecha de entrga' from
Employees as e
inner join orders as o
on e.EmployeeID = o.EmployeeID
Where o.ShippedDate between '1996-07-01' and '1998-04-01' 
and  o.EmployeeID  in ('Davolio', 'Leverling', 'Buchanan')


-- Selecciona la fecha actual del sistema
select GETDATE()

select YEAR(OrderDate) as año from Orders;

-- Selecciona todas las ordenes de compra para 1996
select OrderID as 'numero orden', OrderDate as 'Fecha orden', 
YEAR(OrderDate) as año from Orders
where YEAR(OrderDate) = 1996

-- Selecciona todas las ordenes de compra mostrando el numero de orden,
--fecha de orden, a;o, mes y dia de 1996 y 1998
select OrderID as 'numero orden', OrderDate as 'Fecha orden', 
YEAR(OrderDate) as año, MONTH(OrderDate) as mes from Orders
where YEAR(OrderDate) in (1996, 1998)

--Seleccionar todos los apellidos de los empleados que comiencen con D
Select e.LastName as apellido  from Employees as e
where LastName  like 'D%'--Like: Patron %D , D% y %D%

--Selecciona todos los empleados que su apellido comiencen con Da
Select e.LastName as apellido  from Employees as e
where LastName  like 'Da%'--Like: Patron %D, D% y %D%

--Selecciona todos los empleados que su apellido Termine con A
Select e.LastName as apellido  from Employees as e
where LastName  like '%a'--Like: Patron %D, D% y %D%

--Selecciona todos los empleados que su apellido Contenga  A
Select e.LastName as apellido  from Employees as e
where LastName  like '%a%'--Like: Patron %D , D% y %D%

--Selecciona todos los empleados que su apellido no Contenga  A
Select e.LastName as apellido  from Employees as e
where LastName  not like '%a%'--Like: Patron %D , D% y %D%

--Selecciona todos los empleados que su apellido cualquier palabra y una i
Select e.LastName as apellido  from Employees as e
where LastName like '%_i_%'--Like: Patron %D , D% y %D%

--Selecciona todos los empleados que en se nombre contenga tres caracteres
-- Antes la palabra li desp un cacter y finalmente la letra d
Select e.LastName as Nombre  from Employees as e
where e.LastName like '%__i_g%'--Like: Patron %D , D% y %D%


--seleccionar los apellidos que comiencen con d o con l de los empleados
Select e.LastName as Nombre  from Employees as e
where e.LastName like '[DL]%'--Like: Patron %D , D% y %D%

--Seleccionar todos los datos de los empleados que su apellido comierncen con una H o una A
select * from Employees as e
where e.LastName LIKE '[SC]%'

--Seleccionar todos los datos de los empleados que en su apellido contengan una D o una L
select * from Employees as e
where e.LastName LIKE '%[DL]%'

--Seleccionar todos los datos de los empleados que en su apellido contengan entre la A y la F
select * from Employees as e
where e.LastName LIKE '%[A-F]%'

--Seleccionar cuantos empleados en su apellido contienen las letras entre la A y la F
select COUNT(*) as 'numero de datos' from Employees as e
where e.LastName LIKE '%[A-F]%'

--Seleccionar cuantos empleados en su apellido no Comiencen con CB
select *  from Employees as e
where e.LastName LIKE '%[^CB]%'

--funciones de agregado, group by, having
/*
  sum 
  count(*) --> cuenta las ordenes sin importar nulos
  count(campo)--> no cuenta nulos
  avg()
  max() --> maximo
  min() --> minimo
*/
--selecciona el numero total de ordenes realizadas
select COUNT(*) as 'total ordenes' from Orders as o

select COUNT(ShipRegion) as 'total ordenes' from Orders as o

-- selecciona el noumero de paises a los que les e enviado ordenes
select COUNT(distinct ShipCountry) as 'numero de pises' from Orders

--seleccionar el numero de orddenes enviadas entre 1996 y 1998
SELECT COUNT(o.CustomerID) from Orders as o
WHERE YEAR(ShippedDate)  between '1996' and '1998' and ShipCountry in ('France')

--seleccionar el presio minimo de los productos
select MIN(UnitPrice) as 'presio minimo' from Products as p

--seleccionar el presio mas caro de los productos
select max(UnitPrice) as 'presio minimo' from Products as p

--seleccionar el nombre y presio mas caro de los productos
select top 1 ProductName, UnitPrice as 'presio minimo' from Products as p
order by UnitPrice desc

--seleccionar el monto total de todas las ordenes
select SUM(o.UnitPrice*o.Quantity) as 'total de ventas' from [Order Details]  as o

--seleccionar el total de ventas realizadas a los productos que no tienen descuento
select count(o.OrderID) as 'sin descuento' from [Order Details]  as o
where Discount = 0

--seleccionar el promedio de ventas para los productos
--singaporean, hokkien fried mee y mozzrella di giovanni
select avg(UnitPrice * Quantity) as 'Total ventas' from [Order Details] as o
where o.ProductID in ('42', '72')

select avg(UnitPrice * Quantity) as 'Total ventas' from [Order Details] as o
where o.ProductID = 72 or ProductID = 42

--seleccionar el total de ventas para el cliente Chop-suey Chinese de 1996 a 1998
SELECT * from Customers
SELECT count(CustomerID) as 'total ventas' from Orders
where  CustomerID = 'CHOPS' and YEAR(ShippedDate) between '1996' and '1998'

SELECT*
from Categories as c 
inner JOIN  Products as p 
on c.CategoryID = p.CategoryID

SELECT c.CategoryName as 'nombre categoria',
 p.ProductName as 'nombre del producto',
  p.UnitPrice as 'precio',
  p.UnitsInStock as 'existencia',
  (p.UnitPrice*p.UnitsInStock) as 'presio inventario'
from Categories as c 
inner JOIN  Products as p 
on c.CategoryID = p.CategoryID

--selecccionar los productos de la caracteristica Beverages
SELECT c.CategoryName as 'nombre categoria',
 p.ProductName as 'nombre del producto',
  p.UnitPrice as 'precio',
  p.UnitsInStock as 'existencia',
  (p.UnitPrice*p.UnitsInStock) as 'presio inventario'
from Categories as c 
inner JOIN  Products as p 
on c.CategoryID = p.CategoryID
where c.CategoryName = 'Beverages' and UnitPrice > '20'

SELECT 
AVG(p.UnitPrice *UnitsInStock) as 'presio unitario'
from Categories as c 
inner JOIN  Products as p 
on c.CategoryID = p.CategoryID
where c.CategoryName = 'Beverages' and UnitPrice > '20'
--selecccionar el total de ventas para el cliente chop 96 98

--Joins