CREATE DATABASE a;
USE a;

CREATE TABLE Customers (
    CustomerID CHAR(6) PRIMARY KEY,
    CustomerName NVARCHAR(50) UNIQUE,
    FName NVARCHAR(50),  -- First Name
    LName NVARCHAR(50),  -- Last Name
    Pass NVARCHAR(80),
    Email NVARCHAR(100) UNIQUE,
    Role NVARCHAR(20) CHECK (Role IN ('Admin', 'User', 'Staff')) DEFAULT 'User',
    Phone NVARCHAR(15),
    Sex NVARCHAR(7),
    DateOfBirth DATE,
    MoneyLeft MONEY CHECK (MoneyLeft >= 0),
    Avatar NVARCHAR(MAX)
);


-- Table for Booking
CREATE TABLE Booking(
    BookingID CHAR(6) PRIMARY KEY,
    CustomerID CHAR(6),
    BookingDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table for Theatres
CREATE TABLE Theatres(
    TheatreID CHAR(6) PRIMARY KEY,
    TheatreName NVARCHAR(50) UNIQUE,
    TheatreLocation NVARCHAR(150)
);

-- Table for Rooms
CREATE TABLE Rooms(
    RoomID CHAR(6) PRIMARY KEY,
    RoomName NVARCHAR(50) UNIQUE,
    TheatreID CHAR(6),
    FOREIGN KEY (TheatreID) REFERENCES Theatres(TheatreID)
);

-- Table for Seats 
CREATE TABLE Seats(
    SeatID CHAR(6) PRIMARY KEY,
    SeatName NVARCHAR(50),
    RoomID CHAR(6)
    UNIQUE(RoomID, SeatName)
);

-- Table for Movies
CREATE TABLE Movies (
    MovieID CHAR(6) PRIMARY KEY,
    MovieName NVARCHAR(100),
    Director NVARCHAR(50),
    MovieType NVARCHAR(50),
    ReleaseDate DATE,
    Rate DECIMAL(3,1) CHECK (Rate >= 0 AND Rate <= 10)
);

-- Table for Shows
CREATE TABLE Shows (
    ShowID CHAR(6) PRIMARY KEY,
    StartTime DATETIME,  
    EndTime DATETIME,   
    MovieID CHAR(6),     
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

-- Table for linking Seats with Shows (to manage seat availability per show)
CREATE TABLE ShowSeats (
    ShowID CHAR(6),
    SeatID CHAR(6),
	RoomID CHAR(6),
    IsAvailable BIT DEFAULT 1,
    PRIMARY KEY (ShowID, SeatID, RoomID),
    FOREIGN KEY (ShowID) REFERENCES Shows(ShowID),
    FOREIGN KEY (SeatID) REFERENCES Seats(SeatID),
	FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

-- Table for Actors
CREATE TABLE Actors (
    ActorID CHAR(6) PRIMARY KEY,
    ActorName NVARCHAR(100)
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
	VoucherName NVARCHAR(50) UNIQUE,
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
	RoomID CHAR(6),
    SeatID CHAR(6),
    ComboID CHAR(6),
    VoucherID CHAR(6),
    Price MONEY CHECK (Price >= 0),
    BookingDate DATETIME,
	TicketStatus NVARCHAR(10),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
    FOREIGN KEY (ShowID, SeatID, RoomID) REFERENCES ShowSeats(ShowID, SeatID, RoomID),
    FOREIGN KEY (ComboID) REFERENCES FoodsAndDrinks(ComboID),
    FOREIGN KEY (VoucherID) REFERENCES Vouchers(VoucherID)
);


-- Thêm Users (thêm vài tài khoản mẫu)
INSERT Customers(CustomerID, CustomerName, FName, LName, Pass, Email, Role, Phone, Sex, DateOfBirth, MoneyLeft, Avatar)
VALUES 
('U00001', 'Admin', 'John', 'Doe', '123', 'admin@example.com', 'Admin', '0905000001', 'Male', '1985-05-01', 1000000, 'admin.png'),
('U00002', 'Staff', 'Jane', 'Smith', '456', 'staff@example.com', 'Staff', '0905000002', 'Female', '1990-08-15', 500000, 'staff.png'),
('U00003', 'User1', 'Tom', 'Johnson', '123', 'user1@example.com', 'User', '0905000003', 'Male', '2000-02-10', 300000, 'user1.png'),
('U00004', 'User2', 'Alice', 'Brown', '123', 'user2@example.com', 'User', '0905000004', 'Female', '1998-11-21', 100000, 'user2.png');


-- Thêm Theatres (rạp phim tại Đà Nẵng)
INSERT INTO Theatres (TheatreID, TheatreName, TheatreLocation)
VALUES 
('T00001', N'CGV Vincom Đà Nẵng', N'910A Ngô Quyền, Sơn Trà, Đà Nẵng'),
('T00002', N'Lotte Cinema Đà Nẵng', N'46 Điện Biên Phủ, Thanh Khê, Đà Nẵng'),
('T00003', N'Galaxy Đà Nẵng', N'79 Nguyễn Văn Linh, Hải Châu, Đà Nẵng'),
('T00004', N'Beta Cinemas Đà Nẵng', N'Cách Mạng Tháng 8, Cẩm Lệ, Đà Nẵng'),
('T00005', N'Metiz Cinema Đà Nẵng', N'Lô 19 đường 30 Tháng 4, Hải Châu, Đà Nẵng'),
('T00006', N'Starlight Đà Nẵng', N'Tầng 4, Lotte Mart, Ngũ Hành Sơn, Đà Nẵng');

-- Thêm Rooms (phòng chiếu phim tại các rạp)
INSERT INTO Rooms (RoomID, RoomName, TheatreID)
VALUES 
('R000001', N'Phòng 1', 'T00001'),
('R000002', N'Phòng 2', 'T00001'),
('R000003', N'Phòng 3', 'T00002'),
('R000004', N'Phòng 4', 'T00002'),
('R000005', N'Phòng 5', 'T00003'),
('R000006', N'Phòng 6', 'T00004'),
('R000007', N'Phòng 7', 'T00004'),
('R000008', N'Phòng 8', 'T00005'),
('R000009', N'Phòng 9', 'T00005'),
('R000010', N'Phòng 10', 'T00006');

-- Thêm Seats (ghế tại các phòng chiếu)
INSERT INTO Seats (SeatID, SeatName, RoomID) VALUES
    -- Room R000001
    ('S00001', 'A1', 'R000001'), ('S00002', 'A2', 'R000001'), ('S00003', 'A3', 'R000001'), ('S00004', 'A4', 'R000001'), 
    ('S00005', 'A5', 'R000001'), ('S00006', 'A6', 'R000001'), ('S00007', 'A7', 'R000001'), ('S00008', 'A8', 'R000001'),
    ('S00009', 'B1', 'R000001'), ('S00010', 'B2', 'R000001'), ('S00011', 'B3', 'R000001'), ('S00012', 'B4', 'R000001'),
    ('S00013', 'B5', 'R000001'), ('S00014', 'B6', 'R000001'), ('S00015', 'B7', 'R000001'), ('S00016', 'B8', 'R000001'),
    ('S00017', 'C1', 'R000001'), ('S00018', 'C2', 'R000001'), ('S00019', 'C3', 'R000001'), ('S00020', 'C4', 'R000001'),
    ('S00021', 'C5', 'R000001'), ('S00022', 'C6', 'R000001'), ('S00023', 'C7', 'R000001'), ('S00024', 'C8', 'R000001'),
    ('S00025', 'D1', 'R000001'), ('S00026', 'D2', 'R000001'), ('S00027', 'D3', 'R000001'), ('S00028', 'D4', 'R000001'),
    ('S00029', 'D5', 'R000001'), ('S00030', 'D6', 'R000001'), ('S00031', 'D7', 'R000001'), ('S00032', 'D8', 'R000001'),
    ('S00033', 'E1', 'R000001'), ('S00034', 'E2', 'R000001'), ('S00035', 'E3', 'R000001'), ('S00036', 'E4', 'R000001'),
    ('S00037', 'E5', 'R000001'), ('S00038', 'E6', 'R000001'), ('S00039', 'E7', 'R000001'), ('S00040', 'E8', 'R000001'),
    ('S00041', 'F1', 'R000001'), ('S00042', 'F2', 'R000001'), ('S00043', 'F3', 'R000001'), ('S00044', 'F4', 'R000001'),
    ('S00045', 'F5', 'R000001'), ('S00046', 'F6', 'R000001'), ('S00047', 'F7', 'R000001'), ('S00048', 'F8', 'R000001'),

    -- Room R000002
    ('S00049', 'A1', 'R000002'), ('S00050', 'A2', 'R000002'), ('S00051', 'A3', 'R000002'), ('S00052', 'A4', 'R000002'), 
    ('S00053', 'A5', 'R000002'), ('S00054', 'A6', 'R000002'), ('S00055', 'A7', 'R000002'), ('S00056', 'A8', 'R000002'),
    ('S00057', 'B1', 'R000002'), ('S00058', 'B2', 'R000002'), ('S00059', 'B3', 'R000002'), ('S00060', 'B4', 'R000002'),
    ('S00061', 'B5', 'R000002'), ('S00062', 'B6', 'R000002'), ('S00063', 'B7', 'R000002'), ('S00064', 'B8', 'R000002'),
    ('S00065', 'C1', 'R000002'), ('S00066', 'C2', 'R000002'), ('S00067', 'C3', 'R000002'), ('S00068', 'C4', 'R000002'),
    ('S00069', 'C5', 'R000002'), ('S00070', 'C6', 'R000002'), ('S00071', 'C7', 'R000002'), ('S00072', 'C8', 'R000002'),
    ('S00073', 'D1', 'R000002'), ('S00074', 'D2', 'R000002'), ('S00075', 'D3', 'R000002'), ('S00076', 'D4', 'R000002'),
    ('S00077', 'D5', 'R000002'), ('S00078', 'D6', 'R000002'), ('S00079', 'D7', 'R000002'), ('S00080', 'D8', 'R000002'),
    ('S00081', 'E1', 'R000002'), ('S00082', 'E2', 'R000002'), ('S00083', 'E3', 'R000002'), ('S00084', 'E4', 'R000002'),
    ('S00085', 'E5', 'R000002'), ('S00086', 'E6', 'R000002'), ('S00087', 'E7', 'R000002'), ('S00088', 'E8', 'R000002'),
    ('S00089', 'F1', 'R000002'), ('S00090', 'F2', 'R000002'), ('S00091', 'F3', 'R000002'), ('S00092', 'F4', 'R000002'),
    ('S00093', 'F5', 'R000002'), ('S00094', 'F6', 'R000002'), ('S00095', 'F7', 'R000002'), ('S00096', 'F8', 'R000002'),

    -- Room R000003
    ('S00097', 'A1', 'R000003'), ('S00098', 'A2', 'R000003'), ('S00099', 'A3', 'R000003'), ('S00100', 'A4', 'R000003'), 
    ('S00101', 'A5', 'R000003'), ('S00102', 'A6', 'R000003'), ('S00103', 'A7', 'R000003'), ('S00104', 'A8', 'R000003'),
    ('S00105', 'B1', 'R000003'), ('S00106', 'B2', 'R000003'), ('S00107', 'B3', 'R000003'), ('S00108', 'B4', 'R000003'),
    ('S00109', 'B5', 'R000003'), ('S00110', 'B6', 'R000003'), ('S00111', 'B7', 'R000003'), ('S00112', 'B8', 'R000003'),
    ('S00113', 'C1', 'R000003'), ('S00114', 'C2', 'R000003'), ('S00115', 'C3', 'R000003'), ('S00116', 'C4', 'R000003'),
    ('S00117', 'C5', 'R000003'), ('S00118', 'C6', 'R000003'), ('S00119', 'C7', 'R000003'), ('S00120', 'C8', 'R000003'),
    ('S00121', 'D1', 'R000003'), ('S00122', 'D2', 'R000003'), ('S00123', 'D3', 'R000003'), ('S00124', 'D4', 'R000003'),
    ('S00125', 'D5', 'R000003'), ('S00126', 'D6', 'R000003'), ('S00127', 'D7', 'R000003'), ('S00128', 'D8', 'R000003'),
    ('S00129', 'E1', 'R000003'), ('S00130', 'E2', 'R000003'), ('S00131', 'E3', 'R000003'), ('S00132', 'E4', 'R000003'),
    ('S00133', 'E5', 'R000003'), ('S00134', 'E6', 'R000003'), ('S00135', 'E7', 'R000003'), ('S00136', 'E8', 'R000003'),
    ('S00137', 'F1', 'R000003'), ('S00138', 'F2', 'R000003'), ('S00139', 'F3', 'R000003'), ('S00140', 'F4', 'R000003'),
    ('S00141', 'F5', 'R000003'), ('S00142', 'F6', 'R000003'), ('S00143', 'F7', 'R000003'), ('S00144', 'F8', 'R000003'),

	-- Room R000004
    ('S00145', 'A1', 'R000004'), ('S00146', 'A2', 'R000004'), ('S00147', 'A3', 'R000004'), ('S00148', 'A4', 'R000004'), 
    ('S00149', 'A5', 'R000004'), ('S00150', 'A6', 'R000004'), ('S00151', 'A7', 'R000004'), ('S00152', 'A8', 'R000004'),
    ('S00153', 'B1', 'R000004'), ('S00154', 'B2', 'R000004'), ('S00155', 'B3', 'R000004'), ('S00156', 'B4', 'R000004'),
    ('S00157', 'B5', 'R000004'), ('S00158', 'B6', 'R000004'), ('S00159', 'B7', 'R000004'), ('S00160', 'B8', 'R000004'),
    ('S00161', 'C1', 'R000004'), ('S00162', 'C2', 'R000004'), ('S00163', 'C3', 'R000004'), ('S00164', 'C4', 'R000004'),
    ('S00165', 'C5', 'R000004'), ('S00166', 'C6', 'R000004'), ('S00167', 'C7', 'R000004'), ('S00168', 'C8', 'R000004'),
    ('S00169', 'D1', 'R000004'), ('S00170', 'D2', 'R000004'), ('S00171', 'D3', 'R000004'), ('S00172', 'D4', 'R000004'),
    ('S00173', 'D5', 'R000004'), ('S00174', 'D6', 'R000004'), ('S00175', 'D7', 'R000004'), ('S00176', 'D8', 'R000004'),
    ('S00177', 'E1', 'R000004'), ('S00178', 'E2', 'R000004'), ('S00179', 'E3', 'R000004'), ('S00180', 'E4', 'R000004'),
    ('S00181', 'E5', 'R000004'), ('S00182', 'E6', 'R000004'), ('S00183', 'E7', 'R000004'), ('S00184', 'E8', 'R000004'),
    ('S00185', 'F1', 'R000004'), ('S00186', 'F2', 'R000004'), ('S00187', 'F3', 'R000004'), ('S00188', 'F4', 'R000004'),
    ('S00189', 'F5', 'R000004'), ('S00190', 'F6', 'R000004'), ('S00191', 'F7', 'R000004'), ('S00192', 'F8', 'R000004'),

    -- Room R000005
    ('S00193', 'A1', 'R000005'), ('S00194', 'A2', 'R000005'), ('S00195', 'A3', 'R000005'), ('S00196', 'A4', 'R000005'), 
    ('S00197', 'A5', 'R000005'), ('S00198', 'A6', 'R000005'), ('S00199', 'A7', 'R000005'), ('S00200', 'A8', 'R000005'),
    ('S00201', 'B1', 'R000005'), ('S00202', 'B2', 'R000005'), ('S00203', 'B3', 'R000005'), ('S00204', 'B4', 'R000005'),
    ('S00205', 'B5', 'R000005'), ('S00206', 'B6', 'R000005'), ('S00207', 'B7', 'R000005'), ('S00208', 'B8', 'R000005'),
    ('S00209', 'C1', 'R000005'), ('S00210', 'C2', 'R000005'), ('S00211', 'C3', 'R000005'), ('S00212', 'C4', 'R000005'),
    ('S00213', 'C5', 'R000005'), ('S00214', 'C6', 'R000005'), ('S00215', 'C7', 'R000005'), ('S00216', 'C8', 'R000005'),
    ('S00217', 'D1', 'R000005'), ('S00218', 'D2', 'R000005'), ('S00219', 'D3', 'R000005'), ('S00220', 'D4', 'R000005'),
    ('S00221', 'D5', 'R000005'), ('S00222', 'D6', 'R000005'), ('S00223', 'D7', 'R000005'), ('S00224', 'D8', 'R000005'),
    ('S00225', 'E1', 'R000005'), ('S00226', 'E2', 'R000005'), ('S00227', 'E3', 'R000005'), ('S00228', 'E4', 'R000005'),
    ('S00229', 'E5', 'R000005'), ('S00230', 'E6', 'R000005'), ('S00231', 'E7', 'R000005'), ('S00232', 'E8', 'R000005'),
    ('S00233', 'F1', 'R000005'), ('S00234', 'F2', 'R000005'), ('S00235', 'F3', 'R000005'), ('S00236', 'F4', 'R000005'),
    ('S00237', 'F5', 'R000005'), ('S00238', 'F6', 'R000005'), ('S00239', 'F7', 'R000005'), ('S00240', 'F8', 'R000005');

-- Thêm Movies (các bộ phim)
INSERT INTO Movies (MovieID, MovieName, Director, MovieType, ReleaseDate, Rate)
VALUES 
	('M00001', 'Avengers: Endgame', 'Anthony Russo, Joe Russo', 'Action', '2019-04-26', 8.4),
	('M00002', 'The Lion King', 'Jon Favreau', 'Animation', '2019-07-19', 7.0),
	('M00003', 'Parasite', 'Bong Joon-ho', 'Drama', '2019-05-30', 8.6),
	('M00004', 'Dune', 'Denis Villeneuve', 'Sci-fi', '2021-10-22', 8.2),
	('M00005', 'Spider-Man: No Way Home', 'Jon Watts', 'Action', '2021-12-17', 8.7),
	('M00006', 'Soul', 'Pete Docter', 'Animation', '2020-12-25', 8.1),
	('M00007', 'Tenet', 'Christopher Nolan', 'Sci-fi', '2020-08-26', 7.4),
	('M00008', 'The Matrix Resurrections', 'Lana Wachowski', 'Action', '2021-12-22', 6.8),
	('M00009', 'Joker', 'Todd Phillips', 'Drama', '2019-10-04', 8.4),
	('M00010', 'Once Upon a Time in Hollywood', 'Quentin Tarantino', 'Drama', '2019-07-26', 7.6),
	('M00011', 'Black Widow', 'Cate Shortland', 'Action', '2021-07-09', 6.8),
	('M00012', 'Mulan', 'Niki Caro', 'Action', '2020-09-04', 5.7),
	('M00013', 'Wonder Woman 1984', 'Patty Jenkins', 'Action', '2020-12-25', 5.4),
	('M00014', 'A Quiet Place Part II', 'John Krasinski', 'Horror', '2021-05-28', 7.7),
	('M00015', 'The French Dispatch', 'Wes Anderson', 'Comedy', '2021-10-22', 7.6),
	('M00016', 'The Green Knight', 'David Lowery', 'Fantasy', '2021-07-30', 6.7),
	('M00017', 'No Time to Die', 'Cary Joji Fukunaga', 'Action', '2021-09-30', 6.9),
	('M00018', 'Free Guy', 'Shawn Levy', 'Action', '2021-08-13', 7.1),
	('M00019', 'Demon Slayer: Mugen Train', 'Haruo Sotozaki', 'Animation', '2020-10-16', 8.4),
	('M00020', 'Cruella', 'Craig Gillespie', 'Comedy', '2021-05-28', 7.4);
-- Thêm Shows (suất chiếu phim)
INSERT INTO Shows (ShowID, StartTime, EndTime, MovieID)
VALUES 
	('SH0001', '2024-09-13 14:00:00', '2024-09-13 16:30:00', 'M00001'),
	('SH0002', '2024-09-13 17:00:00', '2024-09-13 19:30:00', 'M00002'),
	('SH0003', '2024-09-13 20:00:00', '2024-09-13 22:30:00', 'M00003'),
	('SH0004', '2024-09-14 14:00:00', '2024-09-14 16:30:00', 'M00004'),
	('SH0005', '2024-09-14 17:00:00', '2024-09-14 19:30:00', 'M00005'),
	('SH0006', '2024-09-14 20:00:00', '2024-09-14 22:30:00', 'M00006'),
	('SH0007', '2024-09-15 14:00:00', '2024-09-15 16:30:00', 'M00004'),
	('SH0008', '2024-09-15 17:00:00', '2024-09-15 19:30:00', 'M00005'),
	('SH0009', '2024-09-16 14:00:00', '2024-09-16 16:30:00', 'M00007'),
	('SH0010', '2024-09-16 17:00:00', '2024-09-16 19:30:00', 'M00007'),
	('SH0011', '2024-09-16 20:00:00', '2024-09-16 22:30:00', 'M00007'),
	('SH0012', '2024-09-17 14:00:00', '2024-09-17 16:30:00', 'M00008'),
	('SH0013', '2024-09-17 17:00:00', '2024-09-17 19:30:00', 'M00009'),
	('SH0014', '2024-09-17 20:00:00', '2024-09-17 22:30:00', 'M00010'),
	('SH0015', '2024-09-18 14:00:00', '2024-09-18 16:30:00', 'M00010'),
	('SH0016', '2024-09-18 17:00:00', '2024-09-18 19:30:00', 'M00011'),
	('SH0017', '2024-09-18 20:00:00', '2024-09-18 22:30:00', 'M00012'),
	('SH0018', '2024-09-19 14:00:00', '2024-09-19 16:30:00', 'M00012'),
	('SH0019', '2024-09-19 17:00:00', '2024-09-19 19:30:00', 'M00012'),
	('SH0020', '2024-09-19 20:00:00', '2024-09-19 22:30:00', 'M00013'),
	('SH0021', '2024-09-20 14:00:00', '2024-09-20 16:30:00', 'M00014'),
	('SH0022', '2024-09-20 17:00:00', '2024-09-20 19:30:00', 'M00015'),
	('SH0023', '2024-09-20 20:00:00', '2024-09-20 22:30:00', 'M00015'),
	('SH0024', '2024-09-21 14:00:00', '2024-09-21 16:30:00', 'M00016'),
	('SH0025', '2024-09-21 17:00:00', '2024-09-21 19:30:00', 'M00017'),
	('SH0026', '2024-09-21 20:00:00', '2024-09-21 22:30:00', 'M00018'),
	('SH0027', '2024-09-22 14:00:00', '2024-09-22 16:30:00', 'M00019'),
	('SH0028', '2024-09-22 17:00:00', '2024-09-22 19:30:00', 'M00020'),
	('SH0029', '2024-09-22 20:00:00', '2024-09-22 22:30:00', 'M00020'),
	('SH0030', '2024-09-23 14:00:00', '2024-09-23 16:30:00', 'M00020');

-- Thêm ShowSeats (tình trạng ghế cho từng suất chiếu)
INSERT INTO ShowSeats (ShowID, SeatID, RoomID, IsAvailable) VALUES 

    ('SH0001', 'S00001', 'R00001', 1), 
    ('SH0001', 'S00002', 'R00001', 1), 
    ('SH0001', 'S00003', 'R00001', 0),  -- Seat booked
    ('SH0001', 'S00004', 'R00001', 1), 
    ('SH0001', 'S00005', 'R00001', 1), 
    ('SH0001', 'S00006', 'R00001', 1), 
    ('SH0001', 'S00007', 'R00001', 0),  -- Seat booked
    ('SH0001', 'S00008', 'R00001', 1),
    ('SH0002', 'S00009', 'R00001', 1), 
    ('SH0002', 'S00010', 'R00001', 1), 
    ('SH0002', 'S00011', 'R00001', 0),  -- Seat booked
    ('SH0002', 'S00012', 'R00001', 1), 
    ('SH0002', 'S00013', 'R00001', 1), 
    ('SH0002', 'S00014', 'R00001', 1), 
    ('SH0002', 'S00015', 'R00001', 0),  -- Seat booked
    ('SH0002', 'S00016', 'R00001', 1),
    ('SH0003', 'S00017', 'R00001', 1), 
    ('SH0003', 'S00018', 'R00001', 1), 
    ('SH0003', 'S00019', 'R00001', 0),  -- Seat booked
    ('SH0003', 'S00020', 'R00001', 1), 
    ('SH0003', 'S00021', 'R00001', 1), 
    ('SH0003', 'S00022', 'R00001', 1), 
    ('SH0003', 'S00023', 'R00001', 0),  -- Seat booked
    ('SH0003', 'S00024', 'R00001', 1),
    ('SH0004', 'S00025', 'R00001', 1), 
    ('SH0004', 'S00026', 'R00001', 1), 
    ('SH0004', 'S00027', 'R00001', 0),  -- Seat booked
    ('SH0004', 'S00028', 'R00001', 1), 
    ('SH0004', 'S00029', 'R00001', 1), 
    ('SH0004', 'S00030', 'R00001', 1), 
    ('SH0004', 'S00031', 'R00001', 0),  -- Seat booked
    ('SH0004', 'S00032', 'R00001', 1),
    ('SH0005', 'S00033', 'R00001', 1), 
    ('SH0005', 'S00034', 'R00001', 1), 
    ('SH0005', 'S00035', 'R00001', 0),  -- Seat booked
    ('SH0005', 'S00036', 'R00001', 1), 
    ('SH0005', 'S00037', 'R00001', 1), 
    ('SH0005', 'S00038', 'R00001', 1), 
    ('SH0005', 'S00039', 'R00001', 0),  -- Seat booked
    ('SH0005', 'S00040', 'R00001', 1),
    ('SH0006', 'S00041', 'R00001', 1), 
    ('SH0006', 'S00042', 'R00001', 1), 
    ('SH0006', 'S00043', 'R00001', 0),  -- Seat booked
    ('SH0006', 'S00044', 'R00001', 1), 
    ('SH0006', 'S00045', 'R00001', 1), 
    ('SH0006', 'S00046', 'R00001', 1), 
    ('SH0006', 'S00047', 'R00001', 0),  -- Seat booked
    ('SH0006', 'S00048', 'R00001', 1),

    ('SH0007', 'S00049', 'R00002', 1), 
    ('SH0007', 'S00050', 'R00002', 1), 
    ('SH0007', 'S00051', 'R00002', 0),  -- Seat booked
    ('SH0007', 'S00052', 'R00002', 1), 
    ('SH0007', 'S00053', 'R00002', 1), 
    ('SH0007', 'S00054', 'R00002', 1), 
    ('SH0007', 'S00055', 'R00002', 0),  -- Seat booked
    ('SH0007', 'S00056', 'R00002', 1),
    ('SH0008', 'S00057', 'R00002', 1), 
    ('SH0008', 'S00058', 'R00002', 1), 
    ('SH0008', 'S00059', 'R00002', 0),  -- Seat booked
    ('SH0008', 'S00060', 'R00002', 1), 
    ('SH0008', 'S00061', 'R00002', 1), 
    ('SH0008', 'S00062', 'R00002', 1), 
    ('SH0008', 'S00063', 'R00002', 0),  -- Seat booked
    ('SH0008', 'S00064', 'R00002', 1),
    ('SH0009', 'S00065', 'R00002', 1), 
    ('SH0009', 'S00066', 'R00002', 1), 
    ('SH0009', 'S00067', 'R00002', 0),  -- Seat booked
    ('SH0009', 'S00068', 'R00002', 1), 
    ('SH0009', 'S00069', 'R00002', 1), 
    ('SH0009', 'S00070', 'R00002', 1), 
    ('SH0009', 'S00071', 'R00002', 0),  -- Seat booked
    ('SH0009', 'S00072', 'R00002', 1),
    ('SH0010', 'S00073', 'R00002', 1), 
    ('SH0010', 'S00074', 'R00002', 1), 
    ('SH0010', 'S00075', 'R00002', 0),  -- Seat booked
    ('SH0010', 'S00076', 'R00002', 1), 
    ('SH0010', 'S00077', 'R00002', 1), 
    ('SH0010', 'S00078', 'R00002', 1), 
    ('SH0010', 'S00079', 'R00002', 0),  -- Seat booked
    ('SH0010', 'S00080', 'R00002', 1),
    ('SH0011', 'S00081', 'R00002', 1), 
    ('SH0011', 'S00082', 'R00002', 1), 
    ('SH0011', 'S00083', 'R00002', 0),  -- Seat booked
    ('SH0011', 'S00084', 'R00002', 1), 
    ('SH0011', 'S00085', 'R00002', 1), 
    ('SH0011', 'S00086', 'R00002', 1), 
    ('SH0011', 'S00087', 'R00002', 0),  -- Seat booked
    ('SH0011', 'S00088', 'R00002', 1),
    ('SH0012', 'S00089', 'R00002', 1), 
    ('SH0012', 'S00090', 'R00002', 1), 
    ('SH0012', 'S00091', 'R00002', 0),  -- Seat booked
    ('SH0012', 'S00092', 'R00002', 1), 
    ('SH0012', 'S00093', 'R00002', 1), 
    ('SH0012', 'S00094', 'R00002', 1), 
    ('SH0012', 'S00095', 'R00002', 0),  -- Seat booked
    ('SH0012', 'S00096', 'R00002', 1),

    ('SH0013', 'S00097', 'R00003', 1), 
    ('SH0013', 'S00098', 'R00003', 1), 
    ('SH0013', 'S00099', 'R00003', 0),  -- Seat booked
    ('SH0013', 'S00100', 'R00003', 1), 
    ('SH0013', 'S00101', 'R00003', 1), 
    ('SH0013', 'S00102', 'R00003', 1), 
    ('SH0013', 'S00103', 'R00003', 0),  -- Seat booked
    ('SH0013', 'S00104', 'R00003', 1),
    ('SH0014', 'S00105', 'R00003', 1), 
    ('SH0014', 'S00106', 'R00003', 1), 
    ('SH0014', 'S00107', 'R00003', 0),  -- Seat booked
    ('SH0014', 'S00108', 'R00003', 1), 
    ('SH0014', 'S00109', 'R00003', 1), 
    ('SH0014', 'S00110', 'R00003', 1), 
    ('SH0014', 'S00111', 'R00003', 0),  -- Seat booked
    ('SH0014', 'S00112', 'R00003', 1),
    ('SH0015', 'S00113', 'R00003', 1), 
    ('SH0015', 'S00114', 'R00003', 1), 
    ('SH0015', 'S00115', 'R00003', 0),  -- Seat booked
    ('SH0015', 'S00116', 'R00003', 1), 
    ('SH0015', 'S00117', 'R00003', 1), 
    ('SH0015', 'S00118', 'R00003', 1), 
    ('SH0015', 'S00119', 'R00003', 0),  -- Seat booked
    ('SH0015', 'S00120', 'R00003', 1),
    ('SH0016', 'S00121', 'R00003', 1), 
    ('SH0016', 'S00122', 'R00003', 1), 
    ('SH0016', 'S00123', 'R00003', 0),  -- Seat booked
    ('SH0016', 'S00124', 'R00003', 1), 
    ('SH0016', 'S00125', 'R00003', 1), 
    ('SH0016', 'S00126', 'R00003', 1), 
    ('SH0016', 'S00127', 'R00003', 0),  -- Seat booked
    ('SH0016', 'S00128', 'R00003', 1),
	('SH0017', 'S00129', 'R00003', 1), 
    ('SH0017', 'S00130', 'R00003', 1), 
    ('SH0017', 'S00131', 'R00003', 0),  -- Seat booked
    ('SH0017', 'S00132', 'R00003', 1), 
    ('SH0017', 'S00133', 'R00003', 1), 
    ('SH0017', 'S00134', 'R00003', 1), 
    ('SH0017', 'S00135', 'R00003', 0),  -- Seat booked
    ('SH0017', 'S00136', 'R00003', 1),
    ('SH0018', 'S00137', 'R00003', 1), 
    ('SH0018', 'S00138', 'R00003', 1), 
    ('SH0018', 'S00139', 'R00003', 0),  -- Seat booked
    ('SH0018', 'S00140', 'R00003', 1), 
    ('SH0018', 'S00141', 'R00003', 1), 
    ('SH0018', 'S00142', 'R00003', 1), 
    ('SH0018', 'S00143', 'R00003', 0),  -- Seat booked
    ('SH0018', 'S00144', 'R00003', 1),

	('SH0019', 'S00145', 'R00004', 1), 
    ('SH0019', 'S00146', 'R00004', 1), 
    ('SH0019', 'S00147', 'R00004', 0),  -- Seat booked
    ('SH0019', 'S00148', 'R00004', 1), 
    ('SH0019', 'S00149', 'R00004', 1), 
    ('SH0019', 'S00150', 'R00004', 1), 
    ('SH0019', 'S00151', 'R00004', 0),  -- Seat booked
    ('SH0019', 'S00152', 'R00004', 1),
    ('SH0020', 'S00153', 'R00004', 1), 
    ('SH0020', 'S00154', 'R00004', 1), 
    ('SH0020', 'S00155', 'R00004', 0),  -- Seat booked
    ('SH0020', 'S00156', 'R00004', 1), 
    ('SH0020', 'S00157', 'R00004', 1), 
    ('SH0020', 'S00158', 'R00004', 1), 
    ('SH0020', 'S00159', 'R00004', 0),  -- Seat booked
    ('SH0020', 'S00160', 'R00004', 1),
    ('SH0021', 'S00161', 'R00004', 1), 
    ('SH0021', 'S00162', 'R00004', 1), 
    ('SH0021', 'S00163', 'R00004', 0),  -- Seat booked
    ('SH0021', 'S00164', 'R00004', 1), 
    ('SH0021', 'S00165', 'R00004', 1), 
    ('SH0021', 'S00166', 'R00004', 1), 
    ('SH0021', 'S00167', 'R00004', 0),  -- Seat booked
    ('SH0021', 'S00168', 'R00004', 1),
    ('SH0022', 'S00169', 'R00004', 1), 
    ('SH0022', 'S00170', 'R00004', 1), 
    ('SH0022', 'S00171', 'R00004', 0),  -- Seat booked
    ('SH0022', 'S00172', 'R00004', 1), 
    ('SH0022', 'S00173', 'R00004', 1), 
    ('SH0022', 'S00174', 'R00004', 1), 
    ('SH0022', 'S00175', 'R00004', 0),  -- Seat booked
    ('SH0022', 'S00176', 'R00004', 1),
    ('SH0023', 'S00177', 'R00004', 1), 
    ('SH0023', 'S00178', 'R00004', 1), 
    ('SH0023', 'S00179', 'R00004', 0),  -- Seat booked
    ('SH0023', 'S00180', 'R00004', 1), 
    ('SH0023', 'S00181', 'R00004', 1), 
    ('SH0023', 'S00182', 'R00004', 1), 
    ('SH0023', 'S00183', 'R00004', 0),  -- Seat booked
    ('SH0023', 'S00184', 'R00004', 1),
    ('SH0024', 'S00185', 'R00004', 1), 
    ('SH0024', 'S00186', 'R00004', 1), 
    ('SH0024', 'S00187', 'R00004', 0),  -- Seat booked
    ('SH0024', 'S00188', 'R00004', 1), 
    ('SH0024', 'S00189', 'R00004', 1), 
    ('SH0024', 'S00190', 'R00004', 1), 
    ('SH0024', 'S00191', 'R00004', 0),  -- Seat booked
    ('SH0024', 'S00192', 'R00004', 1),
	
	('SH0025', 'S00193', 'R00005', 1), 
    ('SH0025', 'S00194', 'R00005', 1), 
    ('SH0025', 'S00195', 'R00005', 0),  -- Seat booked
    ('SH0025', 'S00196', 'R00005', 1), 
    ('SH0025', 'S00197', 'R00005', 1), 
    ('SH0025', 'S00198', 'R00005', 1), 
    ('SH0025', 'S00199', 'R00005', 0),  -- Seat booked
    ('SH0025', 'S00200', 'R00005', 1),
    ('SH0026', 'S00201', 'R00005', 1), 
    ('SH0026', 'S00202', 'R00005', 1), 
    ('SH0026', 'S00203', 'R00005', 0),  -- Seat booked
    ('SH0026', 'S00204', 'R00005', 1), 
    ('SH0026', 'S00205', 'R00005', 1), 
    ('SH0026', 'S00206', 'R00005', 1), 
    ('SH0026', 'S00207', 'R00005', 0),  -- Seat booked
    ('SH0026', 'S00208', 'R00005', 1),
    ('SH0027', 'S00209', 'R00005', 1), 
    ('SH0027', 'S00210', 'R00005', 1), 
    ('SH0027', 'S00211', 'R00005', 0),  -- Seat booked
    ('SH0027', 'S00212', 'R00005', 1), 
    ('SH0027', 'S00213', 'R00005', 1), 
    ('SH0027', 'S00214', 'R00005', 1), 
    ('SH0027', 'S00215', 'R00005', 0),  -- Seat booked
    ('SH0027', 'S00216', 'R00005', 1),
    ('SH0028', 'S00217', 'R00005', 1), 
    ('SH0028', 'S00218', 'R00005', 1), 
    ('SH0028', 'S00219', 'R00005', 0),  -- Seat booked
    ('SH0028', 'S00220', 'R00005', 1), 
    ('SH0028', 'S00221', 'R00005', 1), 
    ('SH0028', 'S00222', 'R00005', 1), 
    ('SH0028', 'S00223', 'R00005', 0),  -- Seat booked
    ('SH0028', 'S00224', 'R00005', 1),
    ('SH0029', 'S00225', 'R00005', 1), 
    ('SH0029', 'S00226', 'R00005', 1), 
    ('SH0029', 'S00227', 'R00005', 0),  -- Seat booked
    ('SH0029', 'S00228', 'R00005', 1), 
    ('SH0029', 'S00229', 'R00005', 1), 
    ('SH0029', 'S00230', 'R00005', 1), 
    ('SH0029', 'S00231', 'R00005', 0),  -- Seat booked
    ('SH0029', 'S00232', 'R00005', 1),
    ('SH0030', 'S00233', 'R00005', 1), 
    ('SH0030', 'S00234', 'R00005', 1), 
    ('SH0030', 'S00235', 'R00005', 0),  -- Seat booked
    ('SH0030', 'S00236', 'R00005', 1), 
    ('SH0030', 'S00237', 'R00005', 1), 
    ('SH0030', 'S00238', 'R00005', 1), 
    ('SH0030', 'S00239', 'R00005', 0),  -- Seat booked
    ('SH0030', 'S00240', 'R00005', 1);



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
INSERT INTO Vouchers (VoucherID, Price, VoucherName, ExpiryDate)
VALUES 
('V00001', 50000, N'Voucher1', '2024-12-31'),
('V00002', 100000, N'Voucher2', '2024-11-30');

-- Thêm FoodsAndDrinks (đồ ăn và nước uống)
INSERT INTO FoodsAndDrinks (ComboID, ComboName, Price)
VALUES 
('C00001', N'Combo 1: Bắp rang + Nước ngọt', 60000),
('C00002', N'Combo 2: Bắp rang lớn + Nước ngọt lớn', 80000);

-- Thêm Booking (đơn đặt vé)
INSERT INTO Booking (BookingID, CustomerID, BookingDate)
VALUES 
('B00001', 'U00003', '2024-09-10'),
('B00002', 'U00004', '2024-09-11'),
('B00003', 'U00003', '2024-09-12'),
('B00004', 'U00004', '2024-09-12');

-- Thêm Tickets (vé đã đặt)
INSERT INTO Tickets (TicketID, BookingID, ShowID, SeatID, ComboID, VoucherID, Price, TicketStatus, BookingDate)
VALUES 
('T00001', 'B00001', 'SH0001', 'S00001', 'C00001', 'V00001', 120000,'Pending', '2024-09-10 13:00:00'),
('T00002', 'B00002', 'SH0002', 'S00004', 'C00002', 'V00002', 150000, 'Paid', '2024-09-11 14:00:00'),
('T00003', 'B00003', 'SH0003', 'S00006', 'C00001', 'V00002', 100000, 'Paid','2024-09-12 15:00:00'),
('T00004', 'B00004', 'SH0004', 'S00007', 'C00001', 'V00001', 130000, 'Paid', '2024-09-12 16:00:00'); 



select Username, Pass , UserID, Email, Phone, Sex, DateOfBirth, MoneyLeft from Users where Username = 'Admin' and Pass= '123'

select * from Rooms

DROP TABLE IF EXISTS Customer;

SELECT 
    TD.TicketID,
    S.MovieName AS ShowName,
    ST.SeatName,
    F.ComboName,
    V.VoucherName,
    TD.Price,
    TD.BookingDate
FROM 
     Tickets TD 
    JOIN Shows SH ON TD.ShowID = SH.ShowID
    JOIN Movies S ON SH.MovieID = S.MovieID
    JOIN Seats ST ON TD.SeatID = ST.SeatID
    LEFT JOIN FoodsAndDrinks F ON TD.ComboID = F.ComboID
    LEFT JOIN Vouchers V ON TD.VoucherID = V.VoucherID;

Select * from Rooms

select CustomerName, Pass, FName , LName , CustomerID, Email, Phone, Sex, DateOfBirth, MoneyLeft from Customers where CustomerName ='Admin' and Pass='123'

--Thêm trigger truy suất người tên người đặt vé khi ấn vào ô ticketOrder