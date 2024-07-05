create database vistaspracticas;
use vistaspracticas;

--crear una vista de la siguiente consultaracteristicas
create or ALTER view view_Categorias_Productos
as
    select c.CategoryName as 'Categoria', p.ProductName as 'Nombre del Producto', p.UnitPrice as 'Precio', p.UnitsInStock as 'Existencia'
    from
        northwind.dbo.Categories as c join
        northwind.dbo.Products as p on c.CategoryID=p.CategoryID;


SELECT *, (Precio * Existencia) as [presio inventario]
from view_Categorias_Productos
WHERE [Categoria] in ('Beberages', 'Condiments')
order  by [Nombre del Producto] desc;
--sql - LDD
-- sql - LMD

--seleccionar la suma del presio del inventario agrupado por categoria
SELECT  Categoria as 'categoria',sum(Precio * Existencia) as [presio inventario]
from view_Categorias_Productos
order by Categoria


