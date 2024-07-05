use Northwind
---Selecciona cuantos productos  tiene cada categoroa
select CategoryID from Products

select COUNT(*) from Products

select CategoryID, COUNT(*) 
from products as p
GROUP by p.CategoryID

SELECT * from products

SELECT * from categories

SELECT c.CategoryName, COUNT(*) as 'numero de productos' from Categories as c
INNER JOIN  products as p 
on c.CategoryID = p.CategoryID
GROUP by c.CategoryName

--consultar todos los productos junto con sus categorias y sus presios
select p.ProductName as 'nombre de producto',c.CategoryName as 'Nombre categoria', p.UnitPrice as 'precio' from Categories as c 
INNER join Products as p 
ON c.CategoryID = p.CategoryID
--consulta para mostrar los nombres de los productos y los nombres de sus provedores
select p.ProductName as 'nombre de producto', s.ContactName as 'provedor' from Products as p
INNER join Suppliers as s
ON p.SupplierID = s.SupplierID
order by  UnitPrice
--selecionar las oordenes de compra mostrando los noombres de los productos y sus importes
select o.OrderID as 'numero de orden',p.ProductName  as 'producto',(o.Quantity * o.UnitPrice) as 'importe' from [Order Details] as o
INNER join Products as p 
ON o.ProductID =p.ProductID
WHERE (o.Quantity * o.UnitPrice) <= 1500
order by 'importe' desc
--mostrar las ordenes de coompra y los nombres de los empleados que las realizaron
select o.OrderID as 'orden', CONCAT(p.FirstName,' ',p.LastName) as 'empleado' from Orders as o
INNER join Employees as p 
ON o.EmployeeID = o.EmployeeID
where YEAR(OrderDate) in ('1996', '1999');
--seleccionar las ordenes mostrando a los clientes a los que se les hicieron las cantidades vendidas y los nombres de los productos
select o.OrderID as 'orden', c.ContactName as 'cliente', d.Quantity as 'cantidad_vendida', p.ProductName as'nombre_producto' from Orders as o
INNER join [Order Details] as d
ON o.OrderID = d.OrderID

INNER join Products as p
ON d.ProductID = p.ProductID

INNER join Customers as c 
ON o.CustomerID = c.CustomerID

--Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado del representante de ventas de cada pedido.
select c.CompanyName as 'Nombre CLiente',CONCAT(e.FirstName,' ',e.LastName) as 'Nombre Empleado' from Employees as e 
INNER JOIN Orders as o 
on e.EmployeeID = o.EmployeeID --whxyu
inner join Customers as c
on c.CustomerID = o.CustomerID;

--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.
select p.ProductName as 'Nombre Provedor',
s.CompanyName as 'Nombre Producto',
p.UnitPrice as 'presio' from Products as p
inner join Suppliers as s
on  p.SupplierID = s.SupplierID;

select P.ProductName ,s.CompanyName,p.UnitPrice
from(
    select SupplierID, ProductName, UnitPrice 
    from Products
)as P 
inner join Suppliers as s 
on p.SupplierID = s.SupplierID;

select P.ProductName ,s.CompanyName,p.UnitPrice
from(
    select SupplierID, CompanyName
    from Suppliers
)as s
inner join Products as P
on p.SupplierID = s.SupplierID;

--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
SELECT o.OrderID as 'ID pedido',
 c.CompanyName as 'Cliente',
 DAY(o.OrderDate) as 'Dia',
MONTH(o.OrderDate) as 'Mes',
YEAR(o.OrderDate) as 'Año' from Customers as c 
INNER JOIN Orders as o 
on c.CustomerID = o.CustomerID

SELECT o.OrderID as 'ID pedido',
 c.CompanyName as 'Cliente',
 DAY(o.OrderDate) as 'Dia',
MONTH(o.OrderDate) as 'Mes',
YEAR(o.OrderDate) as 'Año' 
from(select OrderID,OrderDate,CustomerID
from Orders
) as o
INNER JOIN Customers as c
on c.CustomerID = o.CustomerID
--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el departamento del empleado para cada empleado.
select CONCAT(e.FirstName,' ',e.LastName) as 'Nombre Empleado',
e.Title as 'título del cargo',
t.TerritoryDescription as 'Departamento'
from EmployeeTerritories as et 
inner join  Employees as e
on e.EmployeeID = et.EmployeeID
inner join  Territories as t 
on t.TerritoryID = et.TerritoryID;

--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.
SELECT *
from(select CompanyName,ContactName,Phone
from Suppliers
) as s;

--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
select p.ProductName as "Nombre Producto",
c.CategoryName as 'Nombre de Categoria',
s.CompanyName as 'Nombre Provedor'
from Products as p
inner join  Suppliers as s 
on p.SupplierID =s.SupplierID
inner join  Categories as c 
on p.CategoryID = c.CategoryID;

--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
select c.CompanyName as 'Cliente',o.OrderID as 'ID pedido',p.ProductName as 'Nombre Producto',od.Quantity as 'cantidad del producto'
from [Order Details] as od 
inner join Products as p 
on od.ProductID = p.ProductID
inner join Orders as o 
on od.OrderID = o.OrderID
inner join Customers as c 
on c.CustomerID = o.CustomerID

--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.


--seleccionar todas las ordenes mostrando el empleado que la realizo el cliente al que se le realizo el
-- nombre del producto sus categorias, el presio que se vendio las unidades vendidas y
-- el importe para enero de 19997 a Febrero de 1998
select CONCAT(e.FirstName,' ',e.LastName) as 'empleado',
c.CompanyName as 'cliente',
p.ProductName as 'producto',
ca.CategoryName as 'Categori',
od.Quantity as 'cantidad',
(od.Quantity * p.UnitPrice) as 'importe',
 DAY(o.OrderDate) as 'Dia',
  MONTH(o.OrderDate) as 'mes',
   YEAR(o.OrderDate) as 'Año'
from (select CustomerID,EmployeeID,OrderID,OrderDate from Orders) as o
INNER join (select EmployeeID,FirstName,LastName from Employees) as e
on e.EmployeeID =o.EmployeeID
inner join (select CustomerID,CompanyName from Customers) as c 
on c.CustomerID = o.CustomerID
inner JOIN (select OrderID,Quantity,ProductID from [Order Details]) as od
on o.OrderID = od.OrderID
inner JOIN (select ProductID,ProductName,CategoryID,UnitPrice from Products) as p
on p.ProductID = od.ProductID
inner JOIN (select CategoryID,CategoryName from Categories) as ca
on ca.CategoryID = p.CategoryID
where o.OrderDate BETWEEN '01-01-1997' and '02-28-1998' and ca.CategoryName in ('Beverages')
order by c.CompanyName DESC

--cuanto dinero e vendido de la categoria  Beverages
select SUM(od.Quantity * p.UnitPrice) as 'importe total'
from Categories as c
inner JOIN (select ProductID,ProductName,CategoryID,UnitPrice from Products) as p
on p.CategoryID = c.CategoryID
inner JOIN (select OrderID,Quantity,ProductID from [Order Details]) as od
on p.ProductID = od.ProductID

