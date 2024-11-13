

--VOIR A PARTIR DE LIGNE 105


	-- Create the Producer Table
CREATE TABLE Producer (
    ProducerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Location VARCHAR(50)
);

-- Create the Wine Table
CREATE TABLE Wine (
    WineID INT PRIMARY KEY,
    Type VARCHAR(50),
    Year INT,
    AlcoholContent DECIMAL(3, 1),
    ProducerID INT,
    FOREIGN KEY (ProducerID) REFERENCES Producer(ProducerID)
);

SELECT * FROM Wine

--3.Insert data into the database tables.

-- Insert into Producer Table
INSERT INTO Producer (ProducerID, FirstName, LastName, Location) VALUES
(1, 'John', 'Smith', 'Sousse'),
(2, 'Emma', 'Johnson', 'Tunis'),
(3, 'Michael', 'Williams', 'Sfax'),
(4, 'Emily', 'Brown', 'Sousse'),
(5, 'James', 'Jones', 'Sousse'),
(6, 'Sarah', 'Davis', 'Tunis'),
(7, 'David', 'Miller', 'Sfax'),
(8, 'Olivia', 'Wilson', 'Monastir'),
(9, 'Daniel', 'Moore', 'Sousse'),
(10, 'Sophia', 'Taylor', 'Tunis'),
(11, 'Matthew', 'Anderson', 'Sfax'),
(12, 'Amelia', 'Thomas', 'Sousse');

-- Insert into Wine Table
INSERT INTO Wine (WineID, Type, Year, AlcoholContent, ProducerID) VALUES
(1, 'Red', 2019, 13.5, 1),
(2, 'White', 2020, 12.0, 2),
(3, 'Rose', 2018, 11.5, 3),
(4, 'Red', 2021, 14.0, 4),
(5, 'Sparkling', 2017, 10.5, 5),
(6, 'White', 2019, 12.5, 6),
(7, 'Red', 2022, 13.0, 7),
(8, 'Rose', 2020, 11.0, 8),
(9, 'Red', 2018, 12.0, 9),
(10, 'Sparkling', 2019, 10.0, 10),
(11, 'White', 2021, 11.5, 11),
(12, 'Red', 2022, 15.0, 12);

--4.Retrieve a list of all producers.

SELECT * FROM Producer

--5.Retrieve a sorted list of producers by name.

SELECT FirstName, LastName
FROM Producer
ORDER BY LastName ASC, FirstName ASC;

--6.Retrieve a list of producers from Sousse.

SELECT * FROM Producer
WHERE Location = 'Sousse';

--7.Calculate the total quantity of wine produced with the wine number 12.

SELECT SUM(AlcoholContent) AS TotalQuantity
FROM Wine
WHERE WineID = 12;

--8.Calculate the quantity of wine produced for each category.

SELECT w.Type,SUM(w.AlcoholContent) AS TotalAlcoholContent
FROM Wine AS w
GROUP BY w.Type;

--9.Find producers in the Sousse region who have harvested at least one wine in quantities greater than 300 liters. Display their names and first names, sorted alphabetically.

CREATE TABLE Harvest (
    ProducerID INT,
    FOREIGN KEY (ProducerID) REFERENCES Producer(ProducerID)
	WineID INT,
    FOREIGN KEY (WineID) REFERENCES Wine(WineID)
	Quantity 
	ProducerID, WineID, and Quantity
);

-- Rename the columns in the Producer table
EXEC sp_rename 'Producer.ProducerID', 'NumP';
EXEC sp_rename 'Producer.Location', 'Region';
EXEC sp_rename 'Wine.WineID', 'NumW';
EXEC sp_rename 'Wine.Type', 'Category';
EXEC sp_rename 'Wine.AlcoholContent', 'Degree';

-- Drop the Wine table
DROP TABLE Wine;
-- Drop the Producer table
DROP TABLE Producer;
--Je n'avais pas pris en compte le modéle partagé au niveau de l'image


--2.Implement the relational model using SQL.

CREATE TABLE Producer (
    NumP INT PRIMARY KEY,
    FirstName VARCHAR(20),
    LastName VARCHAR(20),
    Region VARCHAR(20)
);

CREATE TABLE Wine (
    NumW INT PRIMARY KEY,
    Category VARCHAR(20),
    Year INT,
    Degree DECIMAL(4,1),
    NumP INT,
    FOREIGN KEY (NumP) REFERENCES Producer(NumP)
);

CREATE TABLE Harvest (
    Quantity INT,
    NumW INT,
    FOREIGN KEY (NumW) REFERENCES Wine(NumW)
);


--3.Insert data into the database tables.

-- Insert into Producer Table
INSERT INTO Producer (NumP, FirstName, LastName, Region) VALUES
(1, 'John', 'Smith', 'Sousse'),
(2, 'Emma', 'Johnson', 'Tunis'),
(3, 'Michael', 'Williams', 'Sfax'),
(4, 'Emily', 'Brown', 'Sousse'),
(5, 'James', 'Jones', 'Sousse'),
(6, 'Sarah', 'Davis', 'Tunis'),
(7, 'David', 'Miller', 'Sfax'),
(8, 'Olivia', 'Wilson', 'Monastir'),
(9, 'Daniel', 'Moore', 'Sousse'),
(10, 'Sophia', 'Taylor', 'Tunis'),
(11, 'Matthew', 'Anderson', 'Sfax'),
(12, 'Amelia', 'Thomas', 'Sousse');

-- Insert into Wine Table
INSERT INTO Wine (NumW, Category, Year, Degree, NumP) VALUES
(1, 'Red', 2019, 13.5, 1),
(2, 'White', 2020, 12.0, 2),
(3, 'Rose', 2018, 11.5, 3),
(4, 'Red', 2021, 14.0, 4),
(5, 'Sparkling', 2017, 10.5, 5),
(6, 'White', 2019, 12.5, 6),
(7, 'Red', 2022, 13.0, 7),
(8, 'Rose', 2020, 11.0, 8),
(9, 'Red', 2018, 12.0, 9),
(10, 'Sparkling', 2019, 10.0, 10),
(11, 'White', 2021, 11.5, 11),
(12, 'Red', 2022, 15.0, 12);

--4.Retrieve a list of all producers.

SELECT FirstName, LastName, Region
FROM Producer;

--5.Retrieve a sorted list of producers by name.

SELECT FirstName, LastName, Region
FROM Producer
ORDER BY LastName, FirstName;

--6.Retrieve a list of producers from Sousse.

SELECT FirstName, LastName, Region
FROM Producer
WHERE Region = 'Sousse';

--7.Calculate the total quantity of wine produced with the wine number 12.

SELECT SUM(Quantity) AS TotalQuantity
FROM Harvest
WHERE NumW = 12;

--8.Calculate the quantity of wine produced for each category.

SELECT Category, SUM(Quantity) AS TotalQuantity
FROM Wine w
JOIN Harvest h ON w.NumW = h.NumW
GROUP BY Category;

--9.Find producers in the Sousse region who have harvested at least one wine in quantities greater than 300 liters. Display their names and first names, sorted alphabetically.

SELECT p.FirstName, p.LastName
FROM Producer p
JOIN Wine w ON p.NumP = w.NumP
JOIN Harvest h ON w.NumW = h.NumW
WHERE p.Region = 'Sousse'
  AND h.Quantity > 300
ORDER BY p.LastName, p.FirstName;

--10.List the wine numbers with a degree greater than 12, produced by producer number 24.

SELECT w.NumW
FROM Wine w
WHERE w.Degree > 12
  AND w.NumP = 24;

--11.Find the producer who has produced the highest quantity of wine.

SELECT TOP 1 p.FirstName, p.LastName, SUM(h.Quantity) AS TotalQuantity
FROM Producer p
JOIN Wine w ON p.NumP = w.NumP
JOIN Harvest h ON w.NumW = h.NumW
GROUP BY p.NumP, p.FirstName, p.LastName
ORDER BY TotalQuantity DESC;

--12.Find the average degree of wine produced.

SELECT AVG(Degree) AS AverageDegree
FROM Wine;

--13.Find the oldest wine in the database.

SELECT * FROM Wine
WHERE Year = (SELECT MIN(Year) FROM Wine);

--14.Retrieve a list of producers along with the total quantity of wine they have produced.

SELECT p.FirstName, p.LastName, SUM(h.Quantity) AS TotalQuantity
FROM Producer p
JOIN Wine w ON p.NumP = w.NumP
JOIN Harvest h ON w.NumW = h.NumW
GROUP BY p.NumP, p.FirstName, p.LastName;

--15.Retrieve a list of wines along with their producer details.

SELECT w.NumW, w.Category, w.Year, w.Degree, p.FirstName, p.LastName, p.Region
FROM Wine w
JOIN Producer p ON w.NumP = p.NumP;
