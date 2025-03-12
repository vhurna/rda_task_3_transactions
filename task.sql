CREATE DATABASE IF NOT EXISTS ShopDB;

USE ShopDB;

CREATE TABLE IF NOT EXISTS Products (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    Description VARCHAR(100),
    Price DECIMAL(10, 2),
    WarehouseAmount INT
);

CREATE TABLE IF NOT EXISTS Customers (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Address VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS Orders (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    Date DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS OrderItems (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Count INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(ID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ID) ON DELETE CASCADE
);

START TRANSACTION;

INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

SET @OrderID = LAST_INSERT_ID();

INSERT INTO OrderItems (OrderID, ProductID, Count)
VALUES (@OrderID, 1, 1);  

UPDATE Products
SET WarehouseAmount = WarehouseAmount - 1
WHERE ID = 1;  

COMMIT;
