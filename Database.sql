
CREATE DATABASE DoAnDBSWP391;
USE DoAnDBSWP391;

-- Table for Customers
CREATE TABLE Customers (
    CustomerID CHAR(6) PRIMARY KEY,
    CustomerName VARCHAR(50) UNIQUE,
    Pass VARCHAR(80),
    Email VARCHAR(100) UNIQUE,
    Role NVARCHAR(20) CHECK (Role IN ('Admin', 'User')) DEFAULT 'User',
    Phone VARCHAR(15),
    Sex VARCHAR(7),
    DateOfBirth DATE,
    MoneyLeft MONEY,
    Avatar VARCHAR(MAX)
);

-- Table for Booking
CREATE TABLE Booking(
    CustomerID CHAR(6),
    BookingDate DATE,
    TicketNumber INT,
    PRIMARY KEY (CustomerID, BookingDate),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table for Theatres
CREATE TABLE Theatres(
    TheatreID CHAR(6) PRIMARY KEY,
    TheatreName VARCHAR(50) UNIQUE,
    tLocatetion NVARCHAR(150)
);

-- Table for Rooms (linked to Theatres)
CREATE TABLE Rooms(
    RoomID CHAR(6) PRIMARY KEY,
    RoomName VARCHAR(50) UNIQUE,
    TheatreID CHAR(6),
    FOREIGN KEY (TheatreID) REFERENCES Theatres(TheatreID)
);

-- Table for Seats (linked to Rooms)
CREATE TABLE Seats(
    SeatID CHAR(6) PRIMARY KEY,
    SeatName VARCHAR(50),
    NoSeatsLeft INT,
    RoomID CHAR(6),
    IsAvailable BIT DEFAULT 1,
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

-- Table for Shows (linked to Movies)
CREATE TABLE Shows(
    ShowID CHAR(6) PRIMARY KEY,
    StartTime DATETIME,  -- Show start time
    EndTime DATETIME,    -- Show end time
    MovieID CHAR(6),     -- Link to Movie
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

-- Table for Movies
CREATE TABLE Movies (
    MovieID CHAR(6) PRIMARY KEY,
    MovieName VARCHAR(100),
    Director VARCHAR(50),
    movieType VARCHAR(50),
    releaseDate DATE
);

-- Table for Actors
CREATE TABLE Actors (
    ActorID CHAR(6) PRIMARY KEY,
    ActorName VARCHAR(100)
);

-- Table for linking Movies and Actors (many-to-many relationship)
CREATE TABLE MovieActors (
    MovieID CHAR(6),
    ActorID CHAR(6),
    PRIMARY KEY (MovieID, ActorID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (ActorID) REFERENCES Actors(ActorID)
);

-- Table for Tickets (linked to Customers, Seats, Shows)
CREATE TABLE Tickets (
    TicketID CHAR(6) PRIMARY KEY,
    CustomerID CHAR(6),
    SeatID CHAR(6),
    ShowID CHAR(6),
    BookingDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SeatID) REFERENCES Seats(SeatID),
    FOREIGN KEY (ShowID) REFERENCES Shows(ShowID)
);

-- Table for Vouchers (optional for discounts, offers, etc.)
CREATE TABLE Vouchers (
    VoucherID CHAR(6) PRIMARY KEY,
    MovieID CHAR(6), 
    OfferID CHAR(6),
    Price MONEY,
    ExpiryDate DATE,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

-- Foods and Drinks Table (Optional)
CREATE TABLE FoodsAndDrinks (
    ComboID CHAR(6) PRIMARY KEY,
    ComboName NVARCHAR(100),
    Price MONEY
);

-- Admin Table (for managing system, linked with Tickets and Foods)
CREATE TABLE Admins (
    AdminID CHAR(6) PRIMARY KEY,
    AdminPass VARCHAR(80), -- Ensure password is hashed in application logic
    Role NVARCHAR(20) CHECK (Role IN ('Admin')) DEFAULT 'Admin'
);

-- Admins selling Tickets and Foods and Drinks
CREATE TABLE AdminTicketSales (
    AdminID CHAR(6),
    TicketID CHAR(6),
    PRIMARY KEY (AdminID, TicketID),
    FOREIGN KEY (AdminID) REFERENCES Admins(AdminID),
    FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID)
);

CREATE TABLE AdminFoodSales (
    AdminID CHAR(6),
    FoodID CHAR(6),
    PRIMARY KEY (AdminID, FoodID),
    FOREIGN KEY (AdminID) REFERENCES Admins(AdminID),
    FOREIGN KEY (FoodID) REFERENCES FoodsAndDrinks(FoodID)
);
