DROP DATABASE warehouse_management;
CREATE DATABASE IF NOT EXISTS warehouse_management;
USE warehouse_management;

CREATE TABLE IF NOT EXISTS Users (
 userID INT PRIMARY KEY AUTO_INCREMENT,
 username VARCHAR(50),
 password VARCHAR(45) NULL,
 Fname VARCHAR(25) NULL,
 Lname VARCHAR(25) NULL,
 email VARCHAR(45) NULL,
 name VARCHAR(100) GENERATED ALWAYS AS (CONCAT(Fname, ' ', Lname)) STORED,
 isAdmin TINYINT NULL
);

CREATE TABLE IF NOT EXISTS Customers (
 customerID INT PRIMARY KEY AUTO_INCREMENT,
 dateJoined DATE,
 phone VARCHAR(20),
 address VARCHAR(255),
 userID INT NOT NULL
);

ALTER TABLE Customers
ADD FOREIGN KEY (userID) REFERENCES Users(userID);

CREATE TABLE IF NOT EXISTS Employees (
 employeeID INT PRIMARY KEY,
 hireDate DATE,
 salary DECIMAL(10, 2),
 userID INT NOT NULL
);

ALTER TABLE Employees
ADD FOREIGN KEY (userID) REFERENCES Users(userID);

-- Associative Entity, Partial Participation
CREATE TABLE EmployeePhoneNumbers (
    employeeID INT,
    phoneNumber VARCHAR(20),
    FOREIGN KEY (employeeID) REFERENCES Employees(employeeID)
);

CREATE TABLE IF NOT EXISTS Products (
 productID INT PRIMARY KEY,
 productName VARCHAR(100) NOT NULL,
 price DECIMAL(10,2),
 weight DECIMAL(8, 2),
 createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Order_Details (
 orderID INT PRIMARY KEY AUTO_INCREMENT,
 orderShippedDate DATETIME NULL,
 orderDate DATE,
 orderQuantity INT,
 customerID INT,
 FOREIGN KEY (customerID) REFERENCES Customers(customerID)
);

CREATE TABLE IF NOT EXISTS Categories (
 categoryID INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(45) NULL,
 description TEXT,
 createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Suppliers (
 supplierID INT PRIMARY KEY,
 supplierName VARCHAR(45) NULL,
 supplierAddress VARCHAR(45) NULL,
 supplierPhoneNumber VARCHAR(45) NULL,
 supplierEmail VARCHAR(45) NULL
);

CREATE TABLE IF NOT EXISTS Stores (
 storeID INT PRIMARY KEY AUTO_INCREMENT,
 address VARCHAR(45) NOT NULL,
 name VARCHAR(45) NULL,
 phoneNumber VARCHAR(45) NULL,
 createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Stock (
 stockID INT PRIMARY KEY,
 name VARCHAR(45) NULL,
 quantity INT NULL,
 isAvailable BOOLEAN GENERATED ALWAYS AS (CASE WHEN Quantity > 0 THEN TRUE ELSE FALSE END) STORED,
 supplierID INT NULL,
 FOREIGN KEY (supplierID) REFERENCES Suppliers(supplierID)
);

CREATE TABLE IF NOT EXISTS Payment_Details (
 orderID INT PRIMARY KEY,
 amountPaid DECIMAL NULL,
 paymentDate TIMESTAMP,
 paymentMethod VARCHAR(50),
 paymentStatus VARCHAR(20),
 FOREIGN KEY (orderID) REFERENCES Order_Details(orderID)
);

CREATE TABLE IF NOT EXISTS ProductsCategories (
    productID INT,
    categoryID INT,
    PRIMARY KEY (ProductID, CategoryID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE IF NOT EXISTS ProductsStock (
    productID INT,
    stockID INT,
    PRIMARY KEY (ProductID, StockID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (StockID) REFERENCES Stock(StockID)
);

CREATE TABLE IF NOT EXISTS Order_DetailsProduct (
 orderID INT NOT NULL,
 productID INT NOT NULL,
 PRIMARY KEY (productID, orderID),
 FOREIGN KEY (productID) REFERENCES Products(productID),
 FOREIGN KEY (orderID) REFERENCES Order_Details(orderID)
);

CREATE TABLE IF NOT EXISTS EmployeeOrders (
    employeeID INT,
    orderID INT,
    PRIMARY KEY (employeeID, orderID),
    FOREIGN KEY (employeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (orderID) REFERENCES Order_Details(OrderID)
);

CREATE TABLE IF NOT EXISTS CustomersStores (
	customerID INT,
    storeID INT,
    PRIMARY KEY (customerID, storeID),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID),
    FOREIGN KEY (storeID) REFERENCES Stores(storeID)
);

-- Begin Insertions
SET FOREIGN_KEY_CHECKS=0;

-- Users
INSERT INTO Users (userId, username, password, Fname, Lname, email, isAdmin)
VALUES
(1,'user1', 'password1', 'John', 'Doe', 'john.doe@example.com', 1),
(2,'user2', 'password2', 'Jane', 'Smith', 'jane.smith@example.com', 0),
(3,'user3', 'password3', 'Bob', 'Johnson', 'bob.johnson@example.com', 0),
(4,'user4', 'password4', 'Alice', 'Williams', 'alice.williams@example.com', 0),
(5,'user5', 'password5', 'Charlie', 'Brown', 'charlie.brown@example.com', 0),
(6,'user6', 'password6', 'Emma', 'Davis', 'emma.davis@example.com', 0),
(7,'user7', 'password7', 'Frank', 'Miller', 'frank.miller@example.com', 0),
(8,'user8', 'password8', 'Grace', 'Taylor', 'grace.taylor@example.com', 0),
(9,'user9', 'password9', 'Henry', 'Clark', 'henry.clark@example.com', 0),
(10,'user10', 'password10', 'Ivy', 'Robinson', 'ivy.robinson@example.com', 0);

-- Customers
INSERT INTO Customers (dateJoined, phone, address, userID)
VALUES
('2023-01-15', '123-456-7890', '123 Main St, Cityville', 1),
('2022-11-20', '555-123-4567', '456 Oak St, Townsville', 2),
('2023-02-10', '999-888-7777', '789 Pine St, Villagetown', 3),
('2023-03-05', '111-222-3333', '456 Birch St, Hamletville', 4),
('2022-12-12', '444-555-6666', '789 Cedar St, Villagetown', 5),
('2023-01-20', '777-888-9999', '987 Maple St, Riverside', 6),
('2023-02-28', '333-444-5555', '654 Pine St, Hillside', 7),
('2022-11-05', '888-999-0000', '321 Oak St, Gadgetville', 8),
('2023-01-02', '222-333-4444', '987 Willow St, Countryside', 9),
('2022-12-18', '666-777-8888', '456 Elm St, Suburbia', 10);

-- Employees
INSERT INTO Employees (employeeID, hireDate, salary, userID)
VALUES
(101, '2022-05-10', 50000.00, 1),
(102, '2023-01-03', 60000.00, 3),
(103, '2022-08-15', 55000.00, 5),
(104, '2023-02-28', 65000.00, 7),
(105, '2022-11-10', 70000.00, 9),
(106, '2022-12-01', 75000.00, 2),
(107, '2023-03-15', 80000.00, 4),
(108, '2022-10-20', 72000.00, 6),
(109, '2022-09-05', 68000.00, 8),
(110, '2023-01-15', 69000.00, 10);

-- EmployeePhoneNumbers
INSERT INTO EmployeePhoneNumbers (employeeID, phoneNumber)
VALUES
(101, '555-111-2222'),
(102, '555-333-4444'),
(103, '555-555-5555'),
(104, '555-777-8888'),
(105, '555-999-0000'),
(106, '555-222-3333'),
(107, '555-444-5555'),
(108, '555-666-7777'),
(109, '555-888-9999'),
(110, '555-123-4567');

-- Products
INSERT INTO Products (productID, productName, price, weight)
VALUES
(1, 'Laptop', 1200.00, 5.5),
(2, 'Smartphone', 800.00, 0.3),
(3, 'Headphones', 80.00, 0.5),
(4, 'Tablet', 600.00, 1.0),
(5, 'Camera', 400.00, 0.8),
(6, 'Printer', 300.00, 10.0),
(7, 'Mouse', 20.00, 0.1),
(8, 'Keyboard', 30.00, 0.5),
(9, 'Monitor', 200.00, 8.0),
(10, 'Speakers', 50.00, 2.0);

-- Order_Details
INSERT INTO Order_Details (orderShippedDate, orderDate, orderQuantity, customerID)
VALUES
('2023-02-20 08:00:00', '2023-02-15', 2, 1),
('2023-01-10 10:30:00', '2023-01-05', 1, 2),
('2023-03-05 15:45:00', '2023-03-01', 3, 3),
('2022-12-01 09:00:00', '2022-11-25', 1, 4),
('2023-01-20 11:30:00', '2023-01-15', 2, 5),
('2023-02-28 14:15:00', '2023-02-20', 1, 6),
('2022-11-05 12:45:00', '2022-11-01', 3, 7),
('2023-01-02 13:30:00', '2022-12-28', 2, 8),
('2022-12-18 16:00:00', '2022-12-10', 1, 9),
('2022-11-20 10:00:00', '2022-11-15', 4, 10);

-- Categories
INSERT INTO Categories (name, description)
VALUES
('Electronics', 'Devices powered by electricity'),
('Accessories', 'Additional items for convenience'),
('Office', 'Items for office use'),
('Cameras', 'Photography and recording devices'),
('Computers', 'Computing devices and accessories'),
('Audio', 'Sound and music-related devices'),
('Peripherals', 'Additional devices for computers'),
('Printers', 'Devices for printing documents'),
('Monitors', 'Display devices for computers'),
('Gaming', 'Devices and accessories for gaming');

-- Suppliers
INSERT INTO Suppliers (supplierID, supplierName, supplierAddress, supplierPhoneNumber, supplierEmail)
VALUES
(1, 'Tech Supplier 1', '123 Tech St, Tech City', '555-777-8888', 'supplier1@example.com'),
(2, 'Gadget Provider 2', '456 Gadget Ave, Gadget Town', '999-111-2222', 'supplier2@example.com'),
(3, 'Electronics World', '789 Electronics St, Mega City', '111-222-3333', 'supplier3@example.com'),
(4, 'Office Essentials', '987 Office St, Worksville', '444-555-6666', 'supplier4@example.com'),
(5, 'Camera Solutions', '654 Camera St, Photoville', '777-888-9999', 'supplier5@example.com'),
(6, 'Audio Experts', '321 Audio St, Soundtown', '333-444-5555', 'supplier6@example.com'),
(7, 'Peripherals Plus', '654 Peripheral St, Computerville', '888-999-0000', 'supplier7@example.com'),
(8, 'Printers Unlimited', '987 Printer St, Printsville', '222-333-4444', 'supplier8@example.com'),
(9, 'Monitor Masters', '456 Monitor St, Display City', '666-777-8888', 'supplier9@example.com'),
(10, 'Gaming Galaxy', '321 Gaming St, Gametown', '123-456-7890', 'supplier10@example.com');

-- Stores
INSERT INTO Stores (address, name, phoneNumber)
VALUES
('789 Main St, Megamall', 'Megamall Electronics', '555-444-3333'),
('321 Oak St, Gadget Plaza', 'Gadget Plaza', '777-999-1111'),
('456 Maple St, Tech Haven', 'Tech Haven', '888-777-6666'),
('654 Elm St, Office Center', 'Office Center', '111-222-3333'),
('789 Cedar St, Photoland', 'Photoland', '444-555-6666'),
('987 Pine St, Sound Lounge', 'Sound Lounge', '777-888-9999'),
('654 Birch St, Computer Depot', 'Computer Depot', '333-444-5555'),
('987 Willow St, Print World', 'Print World', '888-999-0000'),
('456 Oak St, Display City', 'Display City', '222-333-4444'),
('321 Hill St, Gamers Haven', 'Gamers Haven', '123-456-7890');

-- Stock
INSERT INTO Stock (stockID, name, quantity, supplierID)
VALUES
(1, 'Laptop Stock', 10, 1),
(2, 'Phone Stock', 15, 2),
(3, 'Headphones Stock', 20, 1),
(4, 'Tablet Stock', 8, 3),
(5, 'Camera Stock', 12, 5),
(6, 'Printer Stock', 5, 4),
(7, 'Mouse Stock', 30, 7),
(8, 'Keyboard Stock', 25, 7),
(9, 'Monitor Stock', 15, 9),
(10, 'Speakers Stock', 18, 6);

-- Payment_Details
INSERT INTO Payment_Details (orderID, amountPaid, paymentDate, paymentMethod, paymentStatus)
VALUES
(1, 2400.00, '2023-02-20 08:30:00', 'Credit Card', 'Paid'),
(2, 800.00, '2023-01-10 11:00:00', 'PayPal', 'Paid'),
(3, 240.00, '2023-03-05 16:00:00', 'Debit Card', 'Paid'),
(4, 600.00, '2022-12-01 09:30:00', 'Credit Card', 'Paid'),
(5, 1200.00, '2023-01-20 12:00:00', 'Bank Transfer', 'Paid'),
(6, 300.00, '2023-02-28 14:30:00', 'PayPal', 'Paid'),
(7, 60.00, '2022-11-05 13:00:00', 'Credit Card', 'Paid'),
(8, 60.00, '2023-01-02 13:45:00', 'Debit Card', 'Paid'),
(9, 200.00, '2022-12-18 16:30:00', 'Bank Transfer', 'Paid'),
(10, 200.00, '2022-11-20 10:30:00', 'Credit Card', 'Paid');

-- ProductsCategories
INSERT INTO ProductsCategories (productID, categoryID)
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 1),
(5, 4),
(6, 3),
(7, 7),
(8, 7),
(9, 6),
(10, 6);

-- ProductsStock
INSERT INTO ProductsStock (productID, stockID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Order_DetailsProduct
INSERT INTO Order_DetailsProduct (orderID, productID)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 1),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8);

-- EmployeeOrders
INSERT INTO EmployeeOrders (employeeID, orderID)
VALUES
(101, 1),
(102, 2),
(101, 3),
(103, 4),
(104, 5),
(105, 6),
(106, 7),
(107, 8),
(108, 9),
(109, 10);

-- CustomersStores
INSERT INTO CustomersStores (customerID, storeID)
VALUES
(1, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 7),
(9, 8),
(10, 9);


SET FOREIGN_KEY_CHECKS=1;
-- Finished Insertions

-- Create a view for the product page
CREATE VIEW ProductPage AS
SELECT
    p.productID,
    p.productName,
    p.price,
    p.weight,
    p.createdAt,
    p.updatedAt,
    c.name AS categoryName,
    s.supplierName,
    s.supplierAddress,
    s.supplierPhoneNumber,
    s.supplierEmail,
    GROUP_CONCAT(DISTINCT c.name ORDER BY c.name ASC SEPARATOR ', ') AS categories
FROM
    Products p
    LEFT JOIN ProductsCategories pc ON p.productID = pc.productID
    LEFT JOIN Categories c ON pc.categoryID = c.categoryID
    LEFT JOIN ProductsStock ps ON p.productID = ps.productID
    LEFT JOIN Stock st ON ps.stockID = st.stockID
    LEFT JOIN Suppliers s ON st.supplierID = s.supplierID
    LEFT JOIN Order_DetailsProduct odp ON p.productID = odp.productID
    LEFT JOIN Order_Details od ON odp.orderID = od.orderID
    LEFT JOIN Employees e ON od.customerID = e.employeeID
GROUP BY
    p.productID;

CREATE VIEW CustomerOrdersView AS
SELECT
    c.customerID,
    c.dateJoined,
    c.phone,
    c.address,
    u.username,
    u.email,
    o.orderID,
    o.orderShippedDate,
    o.orderDate,
    o.orderQuantity,
    p.productName,
    p.price
FROM
    Customers c
    JOIN Order_Details o ON c.customerID = o.customerID
    JOIN Order_DetailsProduct op ON o.orderID = op.orderID
    JOIN Products p ON op.productID = p.productID
    JOIN Users u ON c.userID = u.userID;

CREATE VIEW EmployeeSalesView AS
SELECT
    e.employeeID,
    CONCAT(u.Fname, ' ', u.Lname) AS employeeName,
    e.hireDate,
    COUNT(o.orderID) AS totalOrders,
    SUM(p.price * o.orderQuantity) AS totalSales
FROM
    Employees e
    LEFT JOIN Users u ON e.userID = u.userID
    LEFT JOIN EmployeeOrders eo ON e.employeeID = eo.employeeID
    LEFT JOIN Order_Details o ON eo.orderID = o.orderID
    LEFT JOIN Order_DetailsProduct op ON o.orderID = op.orderID
    LEFT JOIN Products p ON op.productID = p.productID
GROUP BY
    e.employeeID, u.Fname, u.Lname, e.hireDate;

CREATE VIEW CategoryProductsView AS
SELECT
    p.productID,
    p.productName,
    p.price,
    p.weight,
    c.name AS categoryName
FROM
    Products p
    LEFT JOIN ProductsCategories pc ON p.productID = pc.productID
    LEFT JOIN Categories c ON pc.categoryID = c.categoryID;

CREATE VIEW StoreInventoryView AS
SELECT
    s.storeID,
    s.name AS storeName,
    st.name AS stockName,
    p.productName,
    st.quantity AS stockQuantity,
    st.isAvailable
FROM
    Stores s
    JOIN CustomersStores cs ON s.storeID = cs.storeID
    JOIN Customers c ON cs.customerID = c.customerID
    JOIN Order_Details od ON c.customerID = od.customerID
    JOIN Order_DetailsProduct odp ON od.orderID = odp.orderID
    JOIN ProductsStock ps ON odp.productID = ps.productID
    JOIN Stock st ON ps.stockID = st.stockID
    JOIN Products p ON odp.productID = p.productID;

CREATE VIEW ProductsWithoutOrdersView AS
SELECT
    p.productID,
    p.productName,
    p.price,
    p.weight
FROM
    Products p
    LEFT JOIN Order_DetailsProduct odp ON p.productID = odp.productID
WHERE
    odp.productID IS NULL;
