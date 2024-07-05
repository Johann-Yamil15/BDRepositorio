use Northwind
--Funciones de fecha
select GETDATE()

select DATEPART(YEAR, '2024-06-06')as 'Año',
DATEPART(MONTH, '2024-06-06')as 'mes',
DATEPART(QUARTER, '2024-06-06')as 'trimestre',
DATEPART(WEEK, '2024-06-06')as 'semana',
DATEPART(DAY, '2024-06-06')as 'dia',
DATEPART(WEEKDAY, '2024-06-06')as 'Dia de la semana'

select DATEPART(YEAR, o.OrderDate)as 'Año',
DATEPART(MONTH, o.OrderDate)as 'mes',
DATEPART(QUARTER, o.OrderDate)as 'trimestre',
DATEPART(WEEK, o.OrderDate)as 'semana',
DATEPART(DAY, o.OrderDate)as 'dia',
DATEPART(WEEKDAY, o.OrderDate)as 'Dia de la semana'
 from Orders as o


 --funcion que regresa el nombre de un mes o dia etc
 select DATENAME(MONTH, GETDATE()) as mes 
set LANGUAGE spanish
 select DATENAME(MONTH, GETDATE()) as mes, DATENAME(WEEKDAY, GETDATE()) as dia

--funcio para obtener la diferencia entre anios, mes, dias, etc
select datediff(YEAR,'1983-04-06', getdate()) as 'tiempo de vejes'

--seleccionar el numero de dias entre la fecha del pedido y la fecha de entrega
select DATEDIFF(day, OrderDate,ShippedDate) as 'dias transcurridos' from Orders