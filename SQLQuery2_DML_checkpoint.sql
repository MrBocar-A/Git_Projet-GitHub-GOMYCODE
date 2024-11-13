CREATE TABLE Vehicles (
    VehicleID INT IDENTITY(1,1) PRIMARY KEY,
    LicensePlate VARCHAR(10) NOT NULL,
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    Color VARCHAR(20) NOT NULL,
    VIN VARCHAR(17) UNIQUE NOT NULL
);
CREATE TABLE Drivers (
    DriverID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    LicenseNumber VARCHAR(15) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State CHAR(2) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL
);
CREATE TABLE Trips (
    TripID INT IDENTITY(1,1) PRIMARY KEY,
    VehicleID INT NOT NULL,
    DriverID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    StartLocation VARCHAR(50) NOT NULL,
    EndLocation VARCHAR(50) NOT NULL,
    Distance INT NOT NULL,
    CONSTRAINT FK_Trips_VehicleID FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID),
    CONSTRAINT FK_Trips_DriverID FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);
CREATE TABLE Maintenance (
    MaintenanceID INT IDENTITY(1,1) PRIMARY KEY,
    VehicleID INT NOT NULL,
    MaintenanceDate DATE NOT NULL,
    Description VARCHAR(100) NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Maintenance_VehicleID FOREIGN KEY (VehicleID) REFERENCES Vehicles(VehicleID)
);
-- ajout des valeurs (Write SQL queries to insert the provided records into their respective tables.)

INSERT INTO Vehicles (LicensePlate,Make,Model,Year,Color,VIN)
VALUES ('ABC123', 'Toyota','Corolla', 2020, 'White', '1HGCM82633A004352'),
	   ('XYZ789', 'Ford', 'Fusion',2018, 'Blue','2HGCM82633A004353');

INSERT INTO Drivers (FirstName,LastName,LicenseNumber,Phone,Address,City,State,ZipCode)
VALUES ('Michael','Smith','D1234567','1234567890','123 Main St','Anytown','CA','12345'),
       ('Sarah','Connor','D7654321','0987654321','456 Elm St','Otherville','NY','54321');

INSERT INTO Trips (VehicleID,DriverID,StartDate,EndDate,StartLocation,EndLocation,Distance)
VALUES (1,1,'2024-07-01','2024-07-02','Los Angeles','San Francisco',380),
       (2,2,'2024-07-03','2024-07-04','New York','Washington D.C.',225);

INSERT INTO Maintenance (VehicleID,MaintenanceDate,Description,Cost)
VALUES (1,'2024-06-15','Oil change',50.00),
       (2,'2024-06-20','Tire replacement',300.00);

--Update the cost of the second maintenance record to 350.00.

UPDATE Maintenance SET Cost=350.00 WHERE VehicleID=2;

-- Delete the first vehicle from the Vehicles table.

DELETE from Vehicles where LicensePlate='ABC123';
--- reçu une erreur car il y'a une contraite REFERENCE sur la table trips & maintenance

DELETE FROM Trips
WHERE VehicleID = (SELECT VehicleID FROM Vehicles WHERE LicensePlate = 'ABC123');

DELETE FROM Maintenance
WHERE VehicleID = (SELECT VehicleID FROM Vehicles WHERE LicensePlate = 'ABC123');

DELETE FROM Vehicles
WHERE LicensePlate = 'ABC123';

--Insert one more record into the Trips table with the following details: VehicleID: 2,DriverID: 1,StartDate: '2024-07-05',EndDate: '2024-07-06',StartLocation: "Boston",EndLocation: "Philadelphia",Distance: 30

INSERT INTO Trips
VALUES (2,1,'2024-07-05','2024-07-06','Boston','Philadelphia',30);

UPDATE Trips SET Distance=300 WHERE VehicleID=2;

--Update the color of the second vehicle in the Vehicles table to "Red".

UPDATE Vehicles SET color='Red' WHERE LicensePlate='XYZ789';

--Insert a new maintenance record into the Maintenance table with the following details:VehicleID: 1,MaintenanceDate: '2024-07-10',Description: "Brake inspection",Cost: 100.00

INSERT INTO Maintenance 
VALUES (1,'2024-07-10','Brake inspection',100.00);

--L'instruction INSERT est en conflit avec la contrainte FOREIGN KEY "FK_Maintenance_VehicleID". Le conflit s'est produit dans la base de données "Fleetmanagement", table "dbo.Vehicles", column 'VehicleID'.

SELECT * FROM Vehicles;
-- Le vehicule avec vehicleID=1 a été supprimé , je crée un nouvel enregistrement 

INSERT INTO Vehicles (LicensePlate, Make, Model, Year, Color, VIN)
VALUES ('NEW123', 'Mercedes', 'GLE 2024', 2024, 'Black', '1HGCM82633A004354');

SELECT * FROM Vehicles;

--Update the phone number of the first driver in the Drivers table to "2223334444".

UPDATE Drivers SET Phone='2223334444' WHERE FirstName='Michael';

--Delete the trip with TripID = 2 from the Trips table.

DELETE from Trips WHERE TripID='2';






