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
  PRIMARY KEY (Order_Details_orderID, Order_Details_productID, Order_Details_customerID, Order_Details_employeeID),
  INDEX fk_Payment_Order_Details1_idx (Order_Details_orderID ASC, Order_Details_productID ASC, Order_Details_customerID ASC, Order_Details_employeeID ASC),
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
  PRIMARY KEY (Order_Details_orderID, Order_Details_customerID, Order_Details_employeeID, Product_productID),
  INDEX fk_Order_Details_has_Product_Product1_idx (Product_productID ASC),
  INDEX fk_Order_Details_has_Product_Order_Details1_idx (Order_Details_orderID ASC, Order_Details_customerID ASC, Order_Details_employeeID ASC),
  CONSTRAINT fk_Order_Details_has_Product_Order_Details1
    FOREIGN KEY (Order_Details_orderID , Order_Details_customerID , Order_Details_employeeID)
    REFERENCES Order_Details (orderID , customerID , employeeID),
  CONSTRAINT fk_Order_Details_has_Product_Product1
    FOREIGN KEY (Product_productID)
    REFERENCES Product (productID)
);

