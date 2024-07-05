use AdventureWorks2019

--CASE
create view v_reporte_productos
as
select productNumber, [Name], ProductLine,
    case ProductLine 
    when 'R' then 'Road'
    when 'M' then 'Mountain'
    when 'T' then 'Touring'
    when 'S' then 'Other sale items'
    else 'not for sale'
    end as [Category]
from 
Production.Product

select productNumber, [Name], ProductLine,
    [Category] = case ProductLine 
    when 'R' then 'Road'
    when 'M' then 'Mountain'
    when 'T' then 'Touring'
    when 'S' then 'Other sale items'
    else 'not for sale'
    end
from 
Production.Product

SELECT 
    ProductNumber AS 'numero de producto',
    [Name] AS 'nombre producto',
    CASE ProductLine
        WHEN 'R' THEN 'Road'
        WHEN 'M' THEN 'Mountain'
        WHEN 'T' THEN 'Touring'
        WHEN 'S' THEN 'Other sale items'
        ELSE 'Not for sale'
    END AS 'Category',
    ListPrice AS 'precio',
    CASE
        WHEN ListPrice = 0.0 THEN 'Mfg item - not for resale'
        WHEN ListPrice < 50.0 THEN 'Under $50'
        WHEN ListPrice >= 50.0 AND ListPrice < 250.0 THEN 'Under $250'
        WHEN ListPrice >= 250.0 AND ListPrice < 1000 THEN 'Under $1000'
        ELSE 'Over $1000'
    END AS 'Price Range'
FROM
    Production.Product;

--ISNULL (funcion)
select v.AccountNumber,v.Name,
v.PurchasingWebServiceURL
FROM
Purchasing.Vendor as v

SELECT IIF(1=2, 'verdadero', 'falso') as 'resultado'
SELECT IIF(len('sql server')=10,'ok', 'no ok') as 'resultado'

SELECT e.LoginID,e.JobTitle,e.Gender, IIF(e.Gender = 'M', 'Hombre', 'Mujer') as Genero
from HumanResources.Employee as e
--------------------------------------------------
IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)


IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END


CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

SELECT * from #StudentsC2
SELECT * from #StudentsC1

--insertar datos que no estan en la tabla 2
insert into #StudentsC2
select s1.StudentID, s1.StudentName,s1.StudentStatus
from #StudentsC1 as s1
left JOIN #StudentsC2 as s2
on s1.StudentID = s2.StudentID
where s2.StudentID is null

SELECT COUNT(*) from #StudentsC2


select *
from #StudentsC1 as s1
inner JOIN #StudentsC2 as s2
on s1.StudentID = s2.StudentID

--Actualizar datos
update s2
set 
s2.StudentName =s1.StudentName,
s2.StudentStatus = s1.StudentStatus
from
#StudentsC1 as s1
inner JOIN #StudentsC2 as s2
on s1.StudentID = s2.StudentID
