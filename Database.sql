CREATE DATABASE a;
USE a;

-- Table for Users
CREATE TABLE Users (
    UserID CHAR(6) PRIMARY KEY,
    UserName VARCHAR(50) UNIQUE,
    Pass VARCHAR(80),
    Email VARCHAR(100) UNIQUE,
    Role NVARCHAR(20) CHECK (Role IN ('Admin', 'User', 'Staff')) DEFAULT 'User',
    Phone VARCHAR(15),
    Sex VARCHAR(7),
    DateOfBirth DATE,
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


-- Thêm Users (thêm vài tài khoản mẫu)
INSERT INTO Users (UserID, UserName, Pass, Email, Role, Phone, Sex, DateOfBirth, MoneyLeft, Avatar)
VALUES 
('U00001', 'Admin', '123', 'admin@example.com', 'Admin', '0905000001', 'Male', '1985-05-01', 1000000, 'admin.png'),
('U00002', 'Staff', '456', 'staff@example.com', 'Staff', '0905000002', 'Female', '1990-08-15', 500000, 'staff.png'),
('U00003', 'User1', '123', 'user1@example.com', 'User', '0905000003', 'Male', '2000-02-10', 300000, 'user1.png'),
('U00004', 'User2', '123', 'user2@example.com', 'User', '0905000004', 'Female', '1998-11-21', 100000, 'user2.png');

-- Thêm Theatres (rạp phim tại Đà Nẵng)
INSERT INTO Theatres (TheatreID, TheatreName, TheatreLocation)
VALUES 
('T00001', 'CGV Vincom Đà Nẵng', '910A Ngô Quyền, Sơn Trà, Đà Nẵng'),
('T00002', 'Lotte Cinema Đà Nẵng', '46 Điện Biên Phủ, Thanh Khê, Đà Nẵng'),
('T00003', 'Galaxy Đà Nẵng', '79 Nguyễn Văn Linh, Hải Châu, Đà Nẵng'),
('T00004', 'Beta Cinemas Đà Nẵng', 'Cách Mạng Tháng 8, Cẩm Lệ, Đà Nẵng'),
('T00005', 'Metiz Cinema Đà Nẵng', 'Lô 19 đường 30 Tháng 4, Hải Châu, Đà Nẵng'),
('T00006', 'Starlight Đà Nẵng', 'Tầng 4, Lotte Mart, Ngũ Hành Sơn, Đà Nẵng');

-- Thêm Rooms (phòng chiếu phim tại các rạp)
INSERT INTO Rooms (RoomID, RoomName, TheatreID)
VALUES 
('R00001', 'Phòng 1', 'T00001'),
('R00002', 'Phòng 2', 'T00001'),
('R00003', 'Phòng 1', 'T00002'),
('R00004', 'Phòng 2', 'T00002'),
('R00005', 'Phòng 1', 'T00003'),
('R00006', 'Phòng 1', 'T00004'),
('R00007', 'Phòng 2', 'T00004'),
('R00008', 'Phòng 1', 'T00005'),
('R00009', 'Phòng 2', 'T00005'),
('R00010', 'Phòng 1', 'T00006');

-- Thêm Seats (ghế tại các phòng chiếu)
INSERT INTO Seats (SeatID, SeatName, RoomID)
VALUES 
('S00001', 'A1', 'R00001'),
('S00002', 'A2', 'R00001'),
('S00003', 'A3', 'R00001'),
('S00004', 'B1', 'R00002'),
('S00005', 'B2', 'R00002'),
('S00006', 'C1', 'R00003'),
('S00007', 'A1', 'R00006'),
('S00008', 'A2', 'R00006'),
('S00009', 'B1', 'R00007'),
('S00010', 'B2', 'R00007'),
('S00011', 'C1', 'R00008'),
('S00012', 'C2', 'R00008'),
('S00013', 'D1', 'R00009'),
('S00014', 'D2', 'R00009'),
('S00015', 'E1', 'R00010');

-- Thêm Movies (các bộ phim)
INSERT INTO Movies (MovieID, MovieName, Director, MovieType, ReleaseDate, Rate)
VALUES 
('M00001', 'Avengers: Endgame', 'Anthony Russo, Joe Russo', 'Action', '2019-04-26', 8.4),
('M00002', 'The Lion King', 'Jon Favreau', 'Animation', '2019-07-19', 7.0),
('M00003', 'Parasite', 'Bong Joon-ho', 'Drama', '2019-05-30', 8.6),
('M00004', 'Dune', 'Denis Villeneuve', 'Sci-fi', '2021-10-22', 8.2),
('M00005', 'Spider-Man: No Way Home', 'Jon Watts', 'Action', '2021-12-17', 8.7),
('M00006', 'Soul', 'Pete Docter', 'Animation', '2020-12-25', 8.1);

-- Thêm Shows (suất chiếu phim)
INSERT INTO Shows (ShowID, StartTime, EndTime, MovieID, RoomID)
VALUES 
('SH0001', '2024-09-13 14:00:00', '2024-09-13 16:30:00', 'M00001', 'R00001'),
('SH0002', '2024-09-13 17:00:00', '2024-09-13 19:30:00', 'M00002', 'R00002'),
('SH0003', '2024-09-13 20:00:00', '2024-09-13 22:30:00', 'M00003', 'R00003'),
('SH0004', '2024-09-14 14:00:00', '2024-09-14 16:30:00', 'M00004', 'R00006'),
('SH0005', '2024-09-14 17:00:00', '2024-09-14 19:30:00', 'M00005', 'R00007'),
('SH0006', '2024-09-14 20:00:00', '2024-09-14 22:30:00', 'M00006', 'R00008'),
('SH0007', '2024-09-15 14:00:00', '2024-09-15 16:30:00', 'M00004', 'R00009'),
('SH0008', '2024-09-15 17:00:00', '2024-09-15 19:30:00', 'M00005', 'R00010');

-- Thêm ShowSeats (tình trạng ghế cho từng suất chiếu)
INSERT INTO ShowSeats (ShowID, SeatID, IsAvailable)
VALUES 
('SH0001', 'S00001', 1),
('SH0001', 'S00002', 1),
('SH0001', 'S00003', 0),  -- ghế đã đặt
('SH0002', 'S00004', 1),
('SH0002', 'S00005', 1),
('SH0003', 'S00006', 1),
('SH0004', 'S00007', 1),
('SH0004', 'S00008', 0),  -- ghế đã đặt
('SH0005', 'S00009', 1),
('SH0005', 'S00010', 1),
('SH0006', 'S00011', 1),
('SH0006', 'S00012', 0),  -- ghế đã đặt
('SH0007', 'S00013', 1),
('SH0007', 'S00014', 1),
('SH0008', 'S00015', 1);

-- Thêm Actors (diễn viên)
INSERT INTO Actors (ActorID, ActorName)
VALUES 
('A00001', 'Robert Downey Jr.'),
('A00002', 'Scarlett Johansson'),
('A00003', 'Tom Hanks');

-- Thêm MovieActors (liên kết phim và diễn viên)
INSERT INTO MovieActors (MovieID, ActorID)
VALUES 
('M00001', 'A00001'),
('M00001', 'A00002'),
('M00002', 'A00003');

-- Thêm Vouchers (voucher khuyến mãi)
INSERT INTO Vouchers (VoucherID, Price, ExpiryDate)
VALUES 
('V00001', 50000, '2024-12-31'),
('V00002', 100000, '2024-11-30');

-- Thêm FoodsAndDrinks (đồ ăn và nước uống)
INSERT INTO FoodsAndDrinks (ComboID, ComboName, Price)
VALUES 
('C00001', 'Combo 1: Bắp rang + Nước ngọt', 60000),
('C00002', 'Combo 2: Bắp rang lớn + Nước ngọt lớn', 80000);

-- Thêm Booking (đơn đặt vé)
INSERT INTO Booking (BookingID, CustomerID, BookingDate)
VALUES 
('B00001', 'U00003', '2024-09-10'),
('B00002', 'U00004', '2024-09-11'),
('B00003', 'U00003', '2024-09-12'),
('B00004', 'U00004', '2024-09-12');

-- Thêm Tickets (vé đã đặt)
INSERT INTO Tickets (TicketID, BookingID, ShowID, SeatID, ComboID, VoucherID, Price, BookingDate)
VALUES 
('T00001', 'B00001', 'SH0001', 'S00001', 'C00001', 'V00001', 120000, '2024-09-10 13:00:00'),
('T00002', 'B00002', 'SH0002', 'S00004', 'C00002', 'V00002', 150000, '2024-09-11 14:00:00');



select Username, Pass , UserID, Email, Phone, Sex, DateOfBirth, MoneyLeft from Users where Username = 'Admin' and Pass= '123' 