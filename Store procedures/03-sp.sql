use AlmacenDatos
--1. Inserta o actualiza los registros nuevos o los cambios 
--en la tabla products,suppliers,customers employees,tomando
--como base nortwind(store procedure)


--Clinte
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Clientes
AS
BEGIN
    -- Actualizar registros existentes
    UPDATE AlmacenDatos.dbo.Customers
    SET 
        Clientebk = n.CustomerID,
        CompanyName = ISNULL(n.CompanyName, 'no tiene CompanyName'),
        [Address] = ISNULL(n.[Address], 'no tiene Address'),
        City = ISNULL(n.City, 'no tiene City'),
        Region = ISNULL(n.Region, 'no tiene Region'),
        Country = ISNULL(n.Country, 'no tiene Country')
    FROM Northwind.dbo.Customers AS n
    INNER JOIN AlmacenDatos.dbo.Customers AS a
    ON n.CustomerID = a.Clientebk
    WHERE 
        a.Clientebk <> n.CustomerID OR
        a.CompanyName <> ISNULL(n.CompanyName, 'no tiene CompanyName') OR
        a.[Address] <> ISNULL(n.[Address], 'no tiene Address') OR
        a.City <> ISNULL(n.City, 'no tiene City') OR
        a.Region <> ISNULL(n.Region, 'no tiene Region') OR
        a.Country <> ISNULL(n.Country, 'no tiene Country');

    -- Insertar registros nuevos
    INSERT INTO AlmacenDatos.dbo.Customers (Clientebk, CompanyName, [Address], City, Region, Country)
    SELECT 
        n.CustomerID,
        ISNULL(n.CompanyName, 'no tiene CompanyName'),
        ISNULL(n.[Address], 'no tiene Address'),
        ISNULL(n.City, 'no tiene City'),
        ISNULL(n.Region, 'no tiene Region'),
        ISNULL(n.Country, 'no tiene Country')
    FROM Northwind.dbo.Customers AS n
    LEFT JOIN AlmacenDatos.dbo.Customers AS a
    ON n.CustomerID = a.Clientebk
    WHERE a.Clientebk IS NULL;
END;


EXEC sp_Actualizar_Insertar_Clientes;

	select * from AlmacenDatos.dbo.Customers;
	select * from Northwind.dbo.Customers;

--Employes
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Empleado
AS
BEGIN
    -- Actualizar registros existentes
    UPDATE AlmacenDatos.dbo.Employees
    SET 
        Employeebk = n.EmployeeID,
        FullName = ISNULL(CONCAT(n.FirstName, ' ', n.LastName), 'no tiene FullName'),
        Title = ISNULL(n.Title, 'no tiene Title'),
        HireDate = ISNULL(CONVERT(varchar, n.HireDate, 120), 'no tiene HireDate'),
        [Address] = ISNULL(n.[Address], 'no tiene Address'),
        City = ISNULL(n.City, 'no tiene City'),
        Region = ISNULL(n.Region, 'no tiene Region'),
        Country = ISNULL(n.Country, 'no tiene Country')
    FROM Northwind.dbo.Employees AS n
    INNER JOIN AlmacenDatos.dbo.Employees AS a
    ON n.EmployeeID = a.Employeebk
    WHERE 
        a.Employeebk <> n.EmployeeID OR
        a.FullName <> ISNULL(CONCAT(n.FirstName, ' ', n.LastName), 'no tiene FullName') OR
        a.Title <> ISNULL(n.Title, 'no tiene Title') OR
        a.HireDate <> ISNULL(CONVERT(varchar, n.HireDate, 120), 'no tiene HireDate') OR
        a.[Address] <> ISNULL(n.[Address], 'no tiene Address') OR
        a.City <> ISNULL(n.City, 'no tiene City') OR
        a.Region <> ISNULL(n.Region, 'no tiene Region') OR
        a.Country <> ISNULL(n.Country, 'no tiene Country');

    -- Insertar registros nuevos
    INSERT INTO AlmacenDatos.dbo.Employees (Employeebk, FullName, Title, HireDate, [Address], City, Region, Country)
    SELECT 
        n.EmployeeID,
        ISNULL(CONCAT(n.FirstName, ' ', n.LastName), 'no tiene FullName'),
        ISNULL(n.Title, 'no tiene Title'),
        ISNULL(CONVERT(varchar, n.HireDate, 120), 'no tiene HireDate'),
        ISNULL(n.[Address], 'no tiene Address'),
        ISNULL(n.City, 'no tiene City'),
        ISNULL(n.Region, 'no tiene Region'),
        ISNULL(n.Country, 'no tiene Country')
    FROM Northwind.dbo.Employees AS n
    LEFT JOIN AlmacenDatos.dbo.Employees AS a
    ON n.EmployeeID = a.Employeebk
    WHERE a.Employeebk IS NULL;
END;


EXEC sp_Actualizar_Insertar_Empleado;

	select * from AlmacenDatos.dbo.Employees;
	select * from Northwind.dbo.Employees;

--Suppliers
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Suppliers
AS
BEGIN
    -- Actualizar registros existentes
    UPDATE AlmacenDatos.dbo.Supplier
    SET 
        Shipperbk = n.SupplierID,
        CompanyName = ISNULL(n.CompanyName, 'no tiene CompanyName'),
        Country = ISNULL(n.Country, 'no tiene Country'),
        [Address] = ISNULL(n.[Address], 'no tiene Address'),
        City = ISNULL(n.City, 'no tiene City')
    FROM Northwind.dbo.Suppliers AS n
    INNER JOIN AlmacenDatos.dbo.Supplier AS a
    ON n.SupplierID = a.Shipperbk
    WHERE 
        a.Shipperbk <> n.SupplierID OR
        a.CompanyName <> ISNULL(n.CompanyName, 'no tiene CompanyName') OR
        a.Country <> ISNULL(n.Country, 'no tiene Country') OR
        a.[Address] <> ISNULL(n.[Address], 'no tiene Address') OR
        a.City <> ISNULL(n.City, 'no tiene City');

    -- Insertar registros nuevos
    INSERT INTO AlmacenDatos.dbo.Supplier (Shipperbk, CompanyName, Country, [Address], City)
    SELECT 
        n.SupplierID,
        ISNULL(n.CompanyName, 'no tiene CompanyName'),
        ISNULL(n.Country, 'no tiene Country'),
        ISNULL(n.[Address], 'no tiene Address'),
        ISNULL(n.City, 'no tiene City')
    FROM Northwind.dbo.Suppliers AS n
    LEFT JOIN AlmacenDatos.dbo.Supplier AS a
    ON n.SupplierID = a.Shipperbk
    WHERE a.Shipperbk IS NULL;
END;

EXEC sp_Actualizar_Insertar_Suppliers;

	select * from AlmacenDatos.dbo.Supplier;
	select * from Northwind.dbo.Suppliers;

--Product
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Product
AS
BEGIN
    -- Actualizar registros existentes
    UPDATE AlmacenDatos.dbo.Products
    SET 
	    Productbk = n.ProductID,
        ProductName = ISNULL(n.ProductName, 'No tiene ProductName'),
		CategoryName = ISNULL(na.CategoryName, 'No tiene CategoryName')
	
    FROM Northwind.dbo.Products AS n
    INNER JOIN AlmacenDatos.dbo.Products AS a
    ON n.ProductID = a.Productbk
	INNER JOIN Northwind.dbo.Categories AS na
	ON n.CategoryID = na.CategoryID
    WHERE 
		a.Productbk <> n.ProductID OR
        a.ProductName <> ISNULL(n.ProductName, 'No tiene ProductName') OR
		a.CategoryName <> ISNULL(na.CategoryName, 'No tiene ProductName');
	
    -- Insertar registros nuevos
    INSERT INTO AlmacenDatos.dbo.Products(Productbk, ProductName, CategoryName)
    SELECT 
        n.ProductID,
        ISNULL(n.ProductName, 'No tiene ProductName'),
        ISNULL(na.CategoryName, 'No tiene CategoryName')
        
    FROM Northwind.dbo.Products AS n
    LEFT JOIN AlmacenDatos.dbo.Products AS a
    ON n.ProductID = a.Productbk
	LEFT JOIN Northwind.dbo.Categories AS na
	ON n.CategoryID = na.CategoryID
    WHERE a.Productbk IS NULL;
END;

EXEC sp_Actualizar_Insertar_Product;

	select * from AlmacenDatos.dbo.Supplier;
	select * from Northwind.dbo.Suppliers;

--Ventas
CREATE OR ALTER PROCEDURE sp_Actualizar_Insertar_Ventas
AS
BEGIN
    -- Actualizar registros existentes
    UPDATE v
    SET 
	    ClienteId = ISNULL(cast(c.ClienteId as nvarchar), 'No tiene ClienteId'),
		ProductoId = ISNULL(cast(p.ProductId as nvarchar), 'No tiene ProductId'),
		EmployeId = ISNULL(cast(n.EmployeeID as nvarchar), 'No tiene EmployeeID'),
		SupplerId = ISNULL(cast(s.ShipperId as nvarchar), 'No tiene ShipperId'),
        UnitPrice = ISNULL(od.UnitPrice, 0), 
        Quantity = ISNULL(od.Quantity, 0)    
     FROM Northwind.dbo.Orders AS n
    LEFT JOIN AlmacenDatos.dbo.Customers AS c
        ON n.CustomerID = c.Clientebk        
    LEFT JOIN AlmacenDatos.dbo.Employees AS e
        ON n.EmployeeID = e.Employeebk   
    LEFT JOIN Northwind.dbo.[Order Details] AS od
        ON n.OrderID = od.OrderID
	LEFT JOIN AlmacenDatos.dbo.Products AS p
        ON od.ProductID= p.Productbk  
	LEFT JOIN Northwind.dbo.Products AS np
        ON p.Productbk = np.ProductID 
	LEFT JOIN AlmacenDatos.dbo.Supplier AS s
        ON np.SupplierID = s.Shipperbk
		LEFT JOIN AlmacenDatos.dbo.Ventas AS v
        ON c.ClienteId = v.ClienteId
    WHERE 
        v.ClienteId <> ISNULL(cast(c.ClienteId as nvarchar), 'No tiene ClienteId') OR
		v.ProductoId <> ISNULL(cast(p.ProductId as nvarchar), 'No tiene ProductId') OR
		v.EmployeId <> ISNULL(cast(n.EmployeeID as nvarchar), 'No tiene EmployeeID') OR
		v.SupplerId <> ISNULL(cast(s.ShipperId as nvarchar), 'No tiene ShipperId') OR
		v.UnitPrice <> ISNULL(od.UnitPrice, 0) OR
		v.Quantity <> ISNULL(od.Quantity, 0) 

    -- Insertar registros nuevos
    INSERT INTO AlmacenDatos.dbo.Ventas (ClienteId, ProductoId, EmployeId, SupplerId, UnitPrice, Quantity)
    SELECT 
        ISNULL(cast(c.ClienteId as nvarchar), 'No tiene ClienteId'),
    ISNULL(cast(p.ProductId as nvarchar), 'No tiene ProductId'),
    ISNULL(cast(n.EmployeeID as nvarchar), 'No tiene EmployeeID'),
    ISNULL(cast(s.ShipperId as nvarchar), 'No tiene ShipperId'),
    ISNULL(od.UnitPrice, 0) AS UnitPrice,
    ISNULL(od.Quantity, 0) AS Quantity    
    FROM Northwind.dbo.Orders AS n
    LEFT JOIN AlmacenDatos.dbo.Customers AS c
        ON n.CustomerID = c.Clientebk        
    LEFT JOIN AlmacenDatos.dbo.Employees AS e
        ON n.EmployeeID = e.Employeebk   
    LEFT JOIN Northwind.dbo.[Order Details] AS od
        ON n.OrderID = od.OrderID
	LEFT JOIN AlmacenDatos.dbo.Products AS p
        ON od.ProductID= p.Productbk  
	LEFT JOIN Northwind.dbo.Products AS np
        ON p.Productbk = np.ProductID 
	LEFT JOIN AlmacenDatos.dbo.Supplier AS s
        ON np.SupplierID = s.Shipperbk
		LEFT JOIN AlmacenDatos.dbo.Ventas AS v
        ON c.ClienteId = v.ClienteId
    WHERE v.ClienteId  is null;
END;



EXEC sp_Actualizar_Insertar_Ventas;

	select * from AlmacenDatos.dbo.Ventas;
	select * from Northwind.dbo.[Order Details];
--2 Crear un sp que Actualice la tabal ventas