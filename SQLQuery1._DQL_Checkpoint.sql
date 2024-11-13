CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    ProductType VARCHAR(50),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, ProductType, Price) VALUES
(1, 'Widget A', 'Widget', 10.00),
(2, 'Widget B', 'Widget', 15.00),
(3, 'Gadget X', 'Gadget', 20.00),
(4, 'Gadget Y', 'Gadget', 25.00),
(5, 'Doohickey Z', 'Doohickey', 30.00);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(15)
);

INSERT INTO Customers (CustomerID, CustomerName, Email, Phone) VALUES
(1, 'John Smith', 'john@example.com', '123-456-7890'),
(2, 'Jane Doe', 'jane.doe@example.com', '987-654-3210'),
(3, 'Alice Brown', 'alice.brown@example.com', '456-789-0123');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2024-05-01'),
(102, 2, '2024-05-02'),
(103, 3, '2024-05-01');

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1, 101, 1, 2),
(2, 101, 3, 1),
(3, 102, 2, 3),
(4, 102, 4, 2),
(5, 103, 5, 1);


CREATE TABLE ProductTypes (
    ProductTypeID INT PRIMARY KEY,
    ProductTypeName VARCHAR(50)
);

INSERT INTO ProductTypes (ProductTypeID, ProductTypeName) VALUES
(1, 'Widget'),
(2, 'Gadget'),
(3, 'Doohickey');

 --1.Retrieve All Products
SELECT * FROM Products;

 --2.Retrieve All Customers
SELECT * FROM Customers;

 --3.Retrieve All Orders
SELECT * FROM Orders;

 --4.Retrieve All Order Details
 SELECT * FROM OrderDetails;
 
 --5.Retrieve All Product Types
SELECT * FROM ProductTypes;

 --6.Retrieve the names of the products that have been ordered by at least one customer, along with the total quantity of each product ordered:

SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantityOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
HAVING SUM(od.Quantity) > 0;

--7.Retrieve the names of the customers who have placed an order on every day of the week, along with the total number of orders placed by each customer:

SELECT c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE DATEPART(WEEKDAY, o.OrderDate) BETWEEN 1 AND 7
GROUP BY c.CustomerName
HAVING COUNT(DISTINCT DATEPART(WEEKDAY, o.OrderDate)) = 7;

--8.Retrieve the names of the customers who have placed the most orders, along with the total number of orders placed by each customer:

SELECT TOP 1 WITH TIES c.CustomerName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalOrders DESC;

--9.Retrieve the names of the products that have been ordered the most, along with the total quantity of each product ordered:

SELECT TOP 1 p.ProductName, SUM(od.Quantity) AS TotalQuantityOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantityOrdered DESC;

--10.Retrieve the names of customers who have placed an order for at least one widget:

SELECT DISTINCT c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType = 'Widget';

--11.Retrieve the names of the customers who have placed an order for at least one widget and at least one gadget, along with the total cost of the widgets and gadgets ordered by each customer.

SELECT c.CustomerName,
       SUM(CASE WHEN p.ProductType = 'Widget' THEN od.Quantity * p.Price ELSE 0 END) AS TotalCostWidgets,
       SUM(CASE WHEN p.ProductType = 'Gadget' THEN od.Quantity * p.Price ELSE 0 END) AS TotalCostGadgets
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType IN ('Widget', 'Gadget')
GROUP BY c.CustomerName
HAVING SUM(CASE WHEN p.ProductType = 'Widget' THEN 1 ELSE 0 END) > 0
   AND SUM(CASE WHEN p.ProductType = 'Gadget' THEN 1 ELSE 0 END) > 0;

--12.Retrieve the names of the customers who have placed an order for at least one gadget, along with the total cost of the gadgets ordered by each customer.

SELECT c.CustomerName,
       SUM(od.Quantity * p.Price) AS TotalCostGadgets
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType = 'Gadget'
GROUP BY c.CustomerName;

--13.Retrieve the names of the customers who have placed an order for at least one doohickey, along with the total cost of the doohickeys ordered by each customer.

SELECT c.CustomerName,
       SUM(od.Quantity * p.Price) AS TotalCostDoohickeys
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductType = 'Doohickey'
GROUP BY c.CustomerName;

--Retrieve the names of the customers who have placed an order every day of the week, along with the total number of orders placed by each customer.

SELECT c.CustomerName,
       COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
HAVING COUNT(DISTINCT DATEPART(WEEKDAY, o.OrderDate)) = 7;

--14.Retrieve the total number of widgets and gadgets ordered by each customer, along with the total cost of the orders.

SELECT c.CustomerName,
       SUM(CASE WHEN p.ProductType IN ('Widget', 'Gadget') THEN od.Quantity ELSE 0 END) AS TotalQuantityWidgetsAndGadgets,
       SUM(od.Quantity * p.Price) AS TotalOrderCost
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerName;
