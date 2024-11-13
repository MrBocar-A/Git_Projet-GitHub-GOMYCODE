USE [master]
GO

/****** Object:  Database [GoMYCODE]    Script Date: 28/10/2024 13:37:54 ******/
CREATE DATABASE [GoMYCODE]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GoMYCODE', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\GoMYCODE.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GoMYCODE_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\GoMYCODE_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GoMYCODE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [GoMYCODE] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [GoMYCODE] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [GoMYCODE] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [GoMYCODE] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [GoMYCODE] SET ARITHABORT OFF 
GO

ALTER DATABASE [GoMYCODE] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [GoMYCODE] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [GoMYCODE] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [GoMYCODE] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [GoMYCODE] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [GoMYCODE] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [GoMYCODE] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [GoMYCODE] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [GoMYCODE] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [GoMYCODE] SET  DISABLE_BROKER 
GO

ALTER DATABASE [GoMYCODE] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [GoMYCODE] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [GoMYCODE] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [GoMYCODE] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [GoMYCODE] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [GoMYCODE] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [GoMYCODE] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [GoMYCODE] SET RECOVERY FULL 
GO

ALTER DATABASE [GoMYCODE] SET  MULTI_USER 
GO

ALTER DATABASE [GoMYCODE] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [GoMYCODE] SET DB_CHAINING OFF 
GO

ALTER DATABASE [GoMYCODE] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [GoMYCODE] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [GoMYCODE] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [GoMYCODE] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO

ALTER DATABASE [GoMYCODE] SET QUERY_STORE = ON
GO

ALTER DATABASE [GoMYCODE] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO

ALTER DATABASE [GoMYCODE] SET  READ_WRITE 
GO

CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL
);

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    Description VARCHAR(255) NOT NULL
);

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    CategoryID INT NOT NULL,
    CONSTRAINT FK_Products_CategoryID FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Orders_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_OrderDetails_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderDetails_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

