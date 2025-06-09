CREATE SCHEMA IF NOT EXISTS warehouse_management;
USE warehouse_management;

CREATE TABLE IF NOT EXISTS Users (
 userID INT PRIMARY KEY AUTO_INCREMENT,
 password VARCHAR(45) NULL,
 name VARCHAR(50) NULL,
 Fname VARCHAR(25) NULL,
 Lname VARCHAR(25) NULL,
 email VARCHAR(45) NULL,
 isAdmin TINYINT NULL
);

CREATE TABLE IF NOT EXISTS Customer (
 customerID INT AUTO_INCREMENT,
 customerName VARCHAR(45) NULL,
 paymentDetails VARCHAR(45) NULL,
 orderHistory VARCHAR(45) NULL,
 orderDetails VARCHAR(45) NULL,
 userID INT NOT NULL,
 PRIMARY KEY (customerID, userID),
 INDEX fk_Customer_Users1_idx (userID ASC),
 CONSTRAINT fk_Customer_Users1
 FOREIGN KEY (userID)
 REFERENCES Users (userID)
);

CREATE TABLE IF NOT EXISTS Product (
 productID INT PRIMARY KEY,
 productName VARCHAR(45) NULL,
 category VARCHAR(45) NULL,
 stock INT NULL,
 isAvailable TINYINT NULL
 );
 
CREATE TABLE IF NOT EXISTS Employees (
 employeeID INT NOT NULL,
 name VARCHAR(45) NULL,
 orderID VARCHAR(45) NULL,
 phoneNumber VARCHAR(45) NULL,
 userID INT NOT NULL,
 orderIDs INT NULL,
 PRIMARY KEY (employeeID, userID),
 INDEX fk_Employees_Users_idx (userID ASC),
 CONSTRAINT fk_Employees_Users
 FOREIGN KEY (userID)
 REFERENCES Users (userID)
);

CREATE TABLE IF NOT EXISTS Order_Details (
 orderID INT NOT NULL,
 orderShippedDate DATETIME NULL,
 address VARCHAR(45) NULL,
 customerID INT NOT NULL,
 employeeID INT NOT NULL,
 PRIMARY KEY (orderID, customerID, employeeID),
 INDEX fk_Order_Details_Customer1_idx (customerID ASC),
 INDEX fk_Order_Details_Employees1_idx (employeeID ASC),
 CONSTRAINT fk_Order_Details_Customer1
 FOREIGN KEY (customerID)
 REFERENCES Customer (customerID),
 CONSTRAINT fk_Order_Details_Employees1
 FOREIGN KEY (employeeID)
 REFERENCES Employees (employeeID)
);

CREATE TABLE IF NOT EXISTS Category (
 categoryID INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(45) NULL,
 description BLOB NULL,
 quantity INT NULL,
 thumbnail BLOB NULL
);

CREATE TABLE IF NOT EXISTS Suppliers (
 supplierID INT PRIMARY KEY,
 supplierName VARCHAR(45) NULL,
 supplierAddress VARCHAR(45) NULL,
 supplierPhoneNumber VARCHAR(45) NULL,
 supplierEmail VARCHAR(45) NULL
);

CREATE TABLE IF NOT EXISTS Stores (
 storeID INT NOT NULL AUTO_INCREMENT,
 address VARCHAR(45) NULL,
 name VARCHAR(45) NULL,
 phoneNumber VARCHAR(45) NULL,
 customerID INT NOT NULL,
 PRIMARY KEY (storeID, customerID),
 INDEX fk_Stores_Customer1_idx (customerID ASC),
 CONSTRAINT fk_Stores_Customer1
 FOREIGN KEY (customerID)
 REFERENCES Customer (customerID)
);

CREATE TABLE IF NOT EXISTS Stock (
 stockID INT PRIMARY KEY,
 name VARCHAR(45) NULL,
 quantity INT NULL,
 category VARCHAR(45) NULL,
 supplierID INT NULL
);

CREATE TABLE IF NOT EXISTS Payment_Details (
 price DECIMAL NULL,
 date DATETIME NULL,
 Order_Details_orderID INT NOT NULL,
 Order_Details_productID INT NOT NULL,
 Order_Details_customerID INT NOT NULL,
 Order_Details_employeeID INT NOT NULL,
 PRIMARY KEY (Order_Details_orderID, Order_Details_productID, Order_Details_customerID,
Order_Details_employeeID),
 INDEX fk_Payment_Order_Details1_idx (Order_Details_orderID ASC, Order_Details_productID ASC,
Order_Details_customerID ASC, Order_Details_employeeID ASC),
 CONSTRAINT fk_Payment_Order_Details1
 FOREIGN KEY (Order_Details_orderID , Order_Details_customerID , Order_Details_employeeID)
 REFERENCES Order_Details (orderID , customerID , employeeID)
);

CREATE TABLE IF NOT EXISTS Product_has_Category (
 Product_productID INT NOT NULL,
 Category_categoryID INT NOT NULL,
 PRIMARY KEY (Product_productID, Category_categoryID),
 INDEX fk_Product_has_Category_Category1_idx (Category_categoryID ASC),
 INDEX fk_Product_has_Category_Product1_idx (Product_productID ASC),
 CONSTRAINT fk_Product_has_Category_Product1
 FOREIGN KEY (Product_productID)
 REFERENCES Product (productID),
 CONSTRAINT fk_Product_has_Category_Category1
 FOREIGN KEY (Category_categoryID)
 REFERENCES Category (categoryID)
);

CREATE TABLE IF NOT EXISTS Stock_has_Product (
 Stock_stockID INT NOT NULL,
 Product_productID INT NOT NULL,
 PRIMARY KEY (Stock_stockID, Product_productID),
 INDEX fk_Stock_has_Product_Product1_idx (Product_productID ASC),
 INDEX fk_Stock_has_Product_Stock1_idx (Stock_stockID ASC),
 CONSTRAINT fk_Stock_has_Product_Stock1
 FOREIGN KEY (Stock_stockID)
  REFERENCES Stock (stockID),
 CONSTRAINT fk_Stock_has_Product_Product1
 FOREIGN KEY (Product_productID)
 REFERENCES Product (productID)
);

CREATE TABLE IF NOT EXISTS Stock_has_Suppliers (
 Stock_stockID INT NOT NULL,
 Suppliers_supplierID INT NOT NULL,
 PRIMARY KEY (Stock_stockID, Suppliers_supplierID),
 INDEX fk_Stock_has_Suppliers_Suppliers1_idx (Suppliers_supplierID ASC),
 INDEX fk_Stock_has_Suppliers_Stock1_idx (Stock_stockID ASC),
 CONSTRAINT fk_Stock_has_Suppliers_Stock1
 FOREIGN KEY (Stock_stockID)
 REFERENCES Stock (stockID),
 CONSTRAINT fk_Stock_has_Suppliers_Suppliers1
 FOREIGN KEY (Suppliers_supplierID)
 REFERENCES Suppliers (supplierID)
);

CREATE TABLE IF NOT EXISTS Order_Details_has_Product (
 Order_Details_orderID INT NOT NULL,
 Order_Details_customerID INT NOT NULL,
 Order_Details_employeeID INT NOT NULL,
 Product_productID INT NOT NULL,
 PRIMARY KEY (Order_Details_orderID, Order_Details_customerID, Order_Details_employeeID,
Product_productID),
 INDEX fk_Order_Details_has_Product_Product1_idx (Product_productID ASC),
 INDEX fk_Order_Details_has_Product_Order_Details1_idx (Order_Details_orderID ASC,
Order_Details_customerID ASC, Order_Details_employeeID ASC),
 CONSTRAINT fk_Order_Details_has_Product_Order_Details1
 FOREIGN KEY (Order_Details_orderID , Order_Details_customerID , Order_Details_employeeID)
 REFERENCES Order_Details (orderID , customerID , employeeID),
 CONSTRAINT fk_Order_Details_has_Product_Product1
 FOREIGN KEY (Product_productID)
 REFERENCES Product (productID)
);

SET FOREIGN_KEY_CHECKS=0;

INSERT INTO Users (password, name, Fname, Lname, email, isAdmin) VALUES
('password123', 'JohnDoe', 'John', 'Doe', 'john.doe@example.com', 0),
('password456', 'JaneSmith', 'Jane', 'Smith', 'jane.smith@example.com', 0),
('password789', 'MichaelBrown', 'Michael', 'Brown', 'michael.brown@example.com', 1),
('password101', 'EmilyJohnson', 'Emily', 'Johnson', 'emily.johnson@example.com', 0),
('password202', 'DavidWilson', 'David', 'Wilson', 'david.wilson@example.com', 0),
('password303', 'SarahLee', 'Sarah', 'Lee', 'sarah.lee@example.com', 1),
('password404', 'RobertTaylor', 'Robert', 'Taylor', 'robert.taylor@example.com', 0),
('password505', 'SusanAnderson', 'Susan', 'Anderson', 'susan.anderson@example.com', 0),
('password606', 'JamesHarris', 'James', 'Harris', 'james.harris@example.com', 0),
('password707', 'LindaMartinez', 'Linda', 'Martinez', 'linda.martinez@example.com', 1);

INSERT INTO Customer (customerName, paymentDetails, orderHistory, orderDetails, userID) VALUES
  ('JohnDoe', 'Payment 1', 'OrderHistory 1', 'OrderDetails 1', 1),
  ('JaneSmith', 'Payment 2', 'OrderHistory 2', 'OrderDetails 2', 2),
  ('MichaelBrown', 'Payment 3', 'OrderHistory 3', 'OrderDetails 3', 3),
  ('EmilyJohnson', 'Payment 4', 'OrderHistory 4', 'OrderDetails 4', 4),
  ('DavidWilson', 'Payment 5', 'OrderHistory 5', 'OrderDetails 5', 5),
  ('SarahLee', 'Payment 6', 'OrderHistory 6', 'OrderDetails 6', 6),
  ('RobertTaylor', 'Payment 7', 'OrderHistory 7', 'OrderDetails 7', 7),
  ('SusanAnderson', 'Payment 8', 'OrderHistory 8', 'OrderDetails 8', 8),
  ('JamesHarris', 'Payment 9', 'OrderHistory 9', 'OrderDetails 9', 9),
  ('LindaMartinez', 'Payment 10', 'OrderHistory 10', 'OrderDetails 10', 10);
  
INSERT INTO Product (productID, productName, category, stock, isAvailable) VALUES
  (1, 'Product A', 'Category 1', 100, 1),
  (2, 'Product B', 'Category 2', 75, 1),
  (3, 'Product C', 'Category 1', 50, 0),
  (4, 'Product D', 'Category 3', 120, 1),
  (5, 'Product E', 'Category 2', 90, 1),
  (6, 'Product F', 'Category 1', 60, 0),
  (7, 'Product G', 'Category 3', 80, 1),
  (8, 'Product H', 'Category 2', 110, 1),
  (9, 'Product I', 'Category 1', 40, 0),
  (10, 'Product J', 'Category 3', 70, 1);

INSERT INTO Employees (employeeID, name, orderID, phoneNumber, userID, orderIDs) VALUES
  (1, 'Employee 1', 'Order001', '123-456-7890', 1, 101),
  (2, 'Employee 2', 'Order002', '234-567-8901', 2, 102),
  (3, 'Employee 3', 'Order003', '345-678-9012', 3, 103),
  (4, 'Employee 4', 'Order004', '456-789-0123', 4, 104),
  (5, 'Employee 5', 'Order005', '567-890-1234', 5, 105),
  (6, 'Employee 6', 'Order006', '678-901-2345', 6, 106),
  (7, 'Employee 7', 'Order007', '789-012-3456', 7, 107),
  (8, 'Employee 8', 'Order008', '890-123-4567', 8, 108),
  (9, 'Employee 9', 'Order009', '901-234-5678', 9, 109),
  (10, 'Employee 10', 'Order010', '012-345-6789', 10, 110);

INSERT INTO Order_Details (orderID, orderShippedDate, address, customerID, employeeID) VALUES
  (1, '2023-01-01 08:00:00', '123 Main St', 1, 1),
  (2, '2023-01-02 09:30:00', '456 Elm St', 2, 2),
  (3, '2023-01-03 10:45:00', '789 Oak St', 3, 3),
  (4, '2023-01-04 12:15:00', '101 Pine St', 4, 4),
  (5, '2023-01-05 14:20:00', '222 Maple St', 5, 5),
  (6, '2023-01-06 16:30:00', '333 Cedar St', 6, 6),
  (7, '2023-01-07 18:45:00', '444 Birch St', 7, 7),
  (8, '2023-01-08 21:00:00', '555 Redwood St', 8, 8),
  (9, '2023-01-09 23:15:00', '666 Walnut St', 9, 9),
  (10, '2023-01-10 01:30:00', '777 Spruce St', 10, 10);

INSERT INTO Category (name, description, quantity, thumbnail) VALUES
  ('Category 1', 'Description for Category 1', 100, NULL),
  ('Category 2', 'Description for Category 2', 75, NULL),
  ('Category 3', 'Description for Category 3', 50, NULL),
  ('Category 4', 'Description for Category 4', 120, NULL),
  ('Category 5', 'Description for Category 5', 90, NULL),
  ('Category 6', 'Description for Category 6', 60, NULL),
  ('Category 7', 'Description for Category 7', 80, NULL),
  ('Category 8', 'Description for Category 8', 110, NULL),
  ('Category 9', 'Description for Category 9', 40, NULL),
  ('Category 10', 'Description for Category 10', 70, NULL);

INSERT INTO Suppliers (supplierID, supplierName, supplierAddress, supplierPhoneNumber, supplierEmail)
VALUES
  (1, 'Supplier A', '123 Main St', '123-456-7890', 'supplierA@example.com'),
  (2, 'Supplier B', '456 Elm St', '234-567-8901', 'supplierB@example.com'),
  (3, 'Supplier C', '789 Oak St', '345-678-9012', 'supplierC@example.com'),
  (4, 'Supplier D', '101 Pine St', '456-789-0123', 'supplierD@example.com'),
  (5, 'Supplier E', '222 Maple St', '567-890-1234', 'supplierE@example.com'),
  (6, 'Supplier F', '333 Cedar St', '678-901-2345', 'supplierF@example.com'),
  (7, 'Supplier G', '444 Birch St', '789-012-3456', 'supplierG@example.com'),
  (8, 'Supplier H', '555 Redwood St', '890-123-4567', 'supplierH@example.com'),
  (9, 'Supplier I', '666 Walnut St', '901-234-5678', 'supplierI@example.com'),
  (10, 'Supplier J', '777 Spruce St', '012-345-6789', 'supplierJ@example.com');

INSERT INTO Stores (address, name, phoneNumber, customerID) VALUES
  ('123 Main St', 'Store 1', '123-456-7890', 1),
  ('456 Elm St', 'Store 2', '234-567-8901', 2),
  ('789 Oak St', 'Store 3', '345-678-9012', 3),
  ('101 Pine St', 'Store 4', '456-789-0123', 4),
  ('222 Maple St', 'Store 5', '567-890-1234', 5),
  ('333 Cedar St', 'Store 6', '678-901-2345', 6),
  ('444 Birch St', 'Store 7', '789-012-3456', 7),
  ('555 Redwood St', 'Store 8', '890-123-4567', 8),
  ('666 Walnut St', 'Store 9', '901-234-5678', 9),
  ('777 Spruce St', 'Store 10', '012-345-6789', 10);
  
INSERT INTO Stock (stockID, name, quantity, category, supplierID) VALUES
  (1, 'Product A', 100, 'Category 1', 1),
  (2, 'Product B', 75, 'Category 2', 2),
  (3, 'Product C', 50, 'Category 1', 3),
  (4, 'Product D', 120, 'Category 3', 4),
  (5, 'Product E', 90, 'Category 2', 5),
  (6, 'Product F', 60, 'Category 1', 6),
  (7, 'Product G', 80, 'Category 3', 7),
  (8, 'Product H', 110, 'Category 2', 8),
  (9, 'Product I', 40, 'Category 1', 9),
  (10, 'Product J', 70, 'Category 3', 10);

INSERT INTO Payment_Details (price, date, Order_Details_orderID, Order_Details_productID, Order_Details_customerID, Order_Details_employeeID)
VALUES
  (50.0, '2023-01-01 08:00:00', 1, 1, 1, 1),
  (65.0, '2023-01-02 09:30:00', 2, 2, 2, 2),
  (75.0, '2023-01-03 10:45:00', 3, 3, 3, 3),
  (40.0, '2023-01-04 12:15:00', 4, 4, 4, 4),
  (95.0, '2023-01-05 14:20:00', 5, 5, 5, 5),
  (60.0, '2023-01-06 16:30:00', 6, 6, 6, 6),
  (80.0, '2023-01-07 18:45:00', 7, 7, 7, 7),
  (110.0, '2023-01-08 21:00:00', 8, 8, 8, 8),
  (45.0, '2023-01-09 23:15:00', 9, 9, 9, 9),
  (70.0, '2023-01-10 01:30:00', 10, 10, 10, 10);

INSERT INTO Product_has_Category (Product_productID, Category_categoryID) VALUES
  (1, 1),
  (2, 2),
  (3, 1),
  (4, 3),
  (5, 2),
  (6, 1),
  (7, 3),
  (8, 2),
  (9, 1),
  (10, 3);

INSERT INTO Stock_has_Product (Stock_stockID, Product_productID) VALUES
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

INSERT INTO Stock_has_Suppliers (Stock_stockID, Suppliers_supplierID) VALUES
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
  
INSERT INTO Order_Details_has_Product (Order_Details_orderID, Order_Details_customerID, Order_Details_employeeID, Product_productID)
VALUES
  (1, 1, 1, 1),
  (2, 2, 2, 2),
  (3, 3, 3, 3),
  (4, 4, 4, 4),
  (5, 5, 5, 5),
  (6, 6, 6, 6),
  (7, 7, 7, 7),
  (8, 8, 8, 8),
  (9, 9, 9, 9),
  (10, 10, 10, 10);
