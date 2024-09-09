CREATE DATABASE demo;
USE demo;

-- Table for Users
CREATE TABLE Users (
    UserID CHAR(6) PRIMARY KEY,
    UserName VARCHAR(50) UNIQUE,
    Pass VARCHAR(80),
    Email VARCHAR(100) UNIQUE,
    Role NVARCHAR(20) CHECK (Role IN ('Admin', 'User', 'Staff')) DEFAULT 'User',
    Phone VARCHAR(15),
    Sex VARCHAR(7),
    DateOfBirth DATE CHECK (DateOfBirth <= CURRENT_DATE),
    MoneyLeft MONEY CHECK (MoneyLeft >= 0),
    Avatar VARCHAR(MAX)
);

-- Table for Booking
CREATE TABLE Booking(
    BookingID CHAR(6) PRIMARY KEY,
    CustomerID CHAR(6),
    BookingDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
);

-- Table for Theatres
CREATE TABLE Theatres(
    TheatreID CHAR(6) PRIMARY KEY,
    TheatreName VARCHAR(50) UNIQUE,
    TheatreLocation NVARCHAR(150)
);

-- Table for Rooms
CREATE TABLE Rooms(
    RoomID CHAR(6) PRIMARY KEY,
    RoomName VARCHAR(50) UNIQUE,
    TheatreID CHAR(6),
    FOREIGN KEY (TheatreID) REFERENCES Theatres(TheatreID)
);

-- Table for Seats 
CREATE TABLE Seats(
    SeatID CHAR(6) PRIMARY KEY,
    SeatName VARCHAR(50),
    RoomID CHAR(6),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    UNIQUE(RoomID, SeatName)
);

-- Table for Movies
CREATE TABLE Movies (
    MovieID CHAR(6) PRIMARY KEY,
    MovieName VARCHAR(100),
    Director VARCHAR(50),
    MovieType VARCHAR(50),
    ReleaseDate DATE,
    Rate DECIMAL(3,1) CHECK (Rate >= 0 AND Rate <= 10)
);

-- Table for Shows
CREATE TABLE Shows (
    ShowID CHAR(6) PRIMARY KEY,
    StartTime DATETIME,  
    EndTime DATETIME,   
    MovieID CHAR(6),     
    RoomID CHAR(6),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

-- Table for linking Seats with Shows (to manage seat availability per show)
CREATE TABLE ShowSeats (
    ShowID CHAR(6),
    SeatID CHAR(6),
    IsAvailable BIT DEFAULT 1,
    PRIMARY KEY (ShowID, SeatID),
    FOREIGN KEY (ShowID) REFERENCES Shows(ShowID),
    FOREIGN KEY (SeatID) REFERENCES Seats(SeatID)
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

-- Table for Vouchers
CREATE TABLE Vouchers (
    VoucherID CHAR(6) PRIMARY KEY,
    Price MONEY CHECK (Price >= 0),
    ExpiryDate DATE
);

-- Foods and Drinks Table
CREATE TABLE FoodsAndDrinks (
    ComboID CHAR(6) PRIMARY KEY,
    ComboName NVARCHAR(100),
    Price MONEY CHECK (Price >= 0)
);

-- Table for Tickets (linked to Booking, Shows, and Seats)
CREATE TABLE Tickets (
    TicketID CHAR(6) PRIMARY KEY,
    BookingID CHAR(6),
    ShowID CHAR(6),
    SeatID CHAR(6),
    ComboID CHAR(6),
    VoucherID CHAR(6),
    Price MONEY CHECK (Price >= 0),
    BookingDate DATETIME,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (ShowID, SeatID) REFERENCES ShowSeats(ShowID, SeatID),
    FOREIGN KEY (ComboID) REFERENCES FoodsAndDrinks(ComboID),
    FOREIGN KEY (VoucherID) REFERENCES Vouchers(VoucherID)
);
