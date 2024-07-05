-- Crear la base de datos AlmacenDatos
CREATE DATABASE AlmacenDatos;
GO

-- Usar la base de datos AlmacenDatos
USE AlmacenDatos;
GO

-- Crear la tabla Customers
CREATE TABLE Customers (
    ClienteId int IDENTITY(1,1) NOT NULL,
    Clientebk nchar(5) NOT NULL,
    CompanyName nvarchar(60) NOT NULL,
    Address nvarchar(60) NOT NULL,
    City nvarchar(15) NOT NULL,
    Region nvarchar(15) NOT NULL,
    Country nvarchar(15) NOT NULL,
    CONSTRAINT PK_Customers PRIMARY KEY (ClienteId)
);
GO

-- Crear la tabla Supplier
CREATE TABLE Supplier (
    ShipperId int IDENTITY(1,1) NOT NULL,
    Shipperbk int NOT NULL,
    CompanyName nvarchar(40) NOT NULL,
    Country nvarchar(15) NOT NULL,
    Address nvarchar(60) NOT NULL,
    City nvarchar(15) NOT NULL,
    CONSTRAINT PK_Supplier PRIMARY KEY (ShipperId)
);
GO

-- Crear la tabla Employees
CREATE TABLE Employees (
    EmployeeId int IDENTITY(1,1) NOT NULL,
    Employeebk int NOT NULL,
    FullName nvarchar(80) NOT NULL,
    Title nvarchar(30) NOT NULL,
    HireDate datetime NOT NULL,
    Address nvarchar(60) NOT NULL,
    City nvarchar(15) NOT NULL,
    Region nvarchar(15) NOT NULL,
    Country nvarchar(15) NOT NULL,
    CONSTRAINT PK_Employees PRIMARY KEY (EmployeeId)
);
GO

-- Crear la tabla Products
CREATE TABLE Products (
    ProductId int IDENTITY(1,1) NOT NULL,
    Productbk int NOT NULL,
    ProductName nvarchar(40) NOT NULL,
    CategoryName nvarchar(40) NOT NULL,
    CONSTRAINT PK_Products PRIMARY KEY (ProductId)
);
GO
-- Crear la tabla Ventas
CREATE TABLE Ventas (
    ClienteId int NOT NULL,
    ProductoId int NOT NULL,
    EmployeId int NOT NULL,
    SupplerId int NOT NULL,
    UnitPrice money NOT NULL,
    Quantity smallint NOT NULL,
    --CONSTRAINT PK_Ventas PRIMARY KEY (ClienteId, ProductoId, EmployeId, SupplerId),
    CONSTRAINT FK_Ventas_Customers FOREIGN KEY (ClienteId) REFERENCES Customers(ClienteId),
    CONSTRAINT FK_Ventas_Products FOREIGN KEY (ProductoId) REFERENCES Products(ProductId),
    CONSTRAINT FK_Ventas_Employees FOREIGN KEY (EmployeId) REFERENCES Employees(EmployeeId),
    CONSTRAINT FK_Ventas_Supplier FOREIGN KEY (SupplerId) REFERENCES Supplier(ShipperId)
);
GO
