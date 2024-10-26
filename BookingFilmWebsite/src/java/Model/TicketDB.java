package Model;

import static Model.TheatreDB.getConnect;
import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.RoomDB.getConnect;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TicketDB {

    // Kết nối cơ sở dữ liệu
    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver: " + e);
        }
        try {
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    // Create - Thêm mới chi tiết vé
    public void insert(Ticket c) {
        String sql = "INSERT INTO Tickets (TicketID, BookingID, ShowID, SeatID, ComboID, VoucherID, Price,Status, BookingDate)\n"
                + "VALUES(?,?,?,?,?,?,?)";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, c.getTicketID());
            stmt.setString(2, c.getBookingID());
            stmt.setString(3, c.getShowID());
            stmt.setString(4, c.getSeatID());
            stmt.setString(5, c.getComboID());
            stmt.setString(6, c.getVoucherID());
            stmt.setDouble(7, c.getPrice());
            stmt.setString(8, c.getStatus());
            stmt.setDate(9, (Date) c.getBookingDate());
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Read - Lấy một chi tiết vé
    public static Ticket getTicketDetail(String ticketDetailID) {
        Ticket ticket = null;
        String query = "SELECT TD.TicketDetailID, T.BookingID, M.MovieName AS ShowName, ST.SeatName, "
                + "F.ComboName, V.VoucherID, TD.Price, T.BookingDate, T.TicketStatus "
                + "FROM TicketDetails TD "
                + "JOIN Tickets T ON TD.TicketID = T.TicketID "
                + "JOIN Shows SH ON TD.ShowID = SH.ShowID "
                + "JOIN Movies M ON SH.MovieID = M.MovieID "
                + "JOIN Seats ST ON TD.SeatID = ST.SeatID "
                + "LEFT JOIN FoodsAndDrinks F ON TD.ComboID = F.ComboID "
                + "LEFT JOIN Vouchers V ON TD.VoucherID = V.VoucherID "
                + "WHERE TD.TicketDetailID = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, ticketDetailID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ticket = new Ticket(
                            rs.getString("TicketID"),
                            rs.getString("BookingID"),
                            rs.getString("ShowName"),
                            rs.getString("SeatName"),
                            rs.getString("ComboName"),
                            rs.getString("VoucherID"),
                            rs.getInt("Price"),
                            rs.getString("TicketStatus"),
                            rs.getDate("BookingDate")
                    );
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(TicketDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ticket;
    }

    public static ArrayList<TicketDetails> listAllTickets() {
        ArrayList<TicketDetails> ticketList = new ArrayList<>();
        String query = "SELECT \n"
                + "    TD.TicketID,\n"
                + "    S.MovieName AS ShowName,\n"
                + "    ST.SeatName,\n"
                + "    F.ComboName,\n"
                + "    V.VoucherName,\n"
                + "    TD.Price,\n"
                + "    TD.BookingDate,\n"
                + "    TD.TicketStatus\n"
                + "FROM \n"
                + "     Tickets TD \n"
                + "    JOIN Shows SH ON TD.ShowID = SH.ShowID\n"
                + "    JOIN Movies S ON SH.MovieID = S.MovieID\n"
                + "    JOIN Seats ST ON TD.SeatID = ST.SeatID\n"
                + "    LEFT JOIN FoodsAndDrinks F ON TD.ComboID = F.ComboID\n"
                + "    LEFT JOIN Vouchers V ON TD.VoucherID = V.VoucherID;";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String tID = rs.getString("TicketID");
                String show = rs.getString("ShowName");
                String seat = rs.getString("seatName");
                String comboname = rs.getString("comboName");
                String voucher = rs.getString("VoucherName");
                Double price = rs.getDouble("price");
                String status = rs.getString("TicketStatus");
                Date bookingDate = rs.getDate("bookingDate");
                TicketDetails ticket = new TicketDetails(tID, show, seat, comboname, voucher, price,status, bookingDate);
                ticketList.add(ticket);
            }
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ticketList;
    }

    // Update - Cập nhật chi tiết vé
    public static boolean updateTicketDetail(String ticketDetailID, String seatID, BigDecimal price, String comboID, String voucherID) {
        String updateSQL = "UPDATE TicketDetails SET SeatID = ?, Price = ?, ComboID = ?, VoucherID = ? WHERE TicketDetailID = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {
            pstmt.setString(1, seatID);
            pstmt.setBigDecimal(2, price);
            pstmt.setString(3, comboID);
            pstmt.setString(4, voucherID);
            pstmt.setString(5, ticketDetailID);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            Logger.getLogger(TicketDB.class.getName()).log(Level.SEVERE, "Error updating ticket detail", e);
            return false;
        }
    }

    // Delete - Xóa chi tiết vé
    public static boolean deleteTicketDetail(String ticketDetailID) {
        String deleteSQL = "DELETE FROM TicketDetails WHERE TicketDetailID = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(deleteSQL)) {
            pstmt.setString(1, ticketDetailID);
            int rowsDeleted = pstmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            Logger.getLogger(TicketDB.class.getName()).log(Level.SEVERE, "Error deleting ticket detail", e);
            return false;
        }
    }
<<<<<<< Updated upstream
=======
//public static boolean insertTicket(Ticket ticket) {
//    String query = "INSERT INTO Tickets (TicketID, BookingID, ShowID, TheatreID, RoomID, SeatID, VoucherID, Price, BookingDate, TicketStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
//
//    try (Connection conn = getConnect();
//         PreparedStatement stmt = conn.prepareStatement(query)) {
//
//        stmt.setString(1, ticket.getTicketID());
//        stmt.setString(2, ticket.getBookingID());
//        stmt.setString(3, ticket.getShowID());
//        stmt.setString(4, ticket.getTheatreID());
//        stmt.setString(5, ticket.getRoomID());
//        stmt.setString(6, ticket.getSeatID());
//        stmt.setString(7, ticket.getVoucherID());
//        stmt.setDouble(8, ticket.getPrice());
//        stmt.setTimestamp(9, new Timestamp(ticket.getBookingDate().getTime())); // Chuyển đổi Date thành Timestamp
//        stmt.setString(10, ticket.getTicketStatus());
//
//        int rowsInserted = stmt.executeUpdate();
//        return rowsInserted > 0; // Trả về true nếu chèn thành công
//    } catch (SQLException e) {
//        e.printStackTrace(); // Xử lý ngoại lệ
//        return false; // Trả về false nếu có lỗi xảy ra
//    }
//}
public static boolean insertTicket(String ticketID, String bookingID, String showID, String theatreID, 
                                    String roomID, String seatID, String voucherID, 
                                    double price, java.util.Date bookingDate, String ticketStatus) {
    String sql = "INSERT INTO Tickets (TicketID, BookingID, ShowID, TheatreID, RoomID, SeatID, " +
                 "VoucherID, Price, BookingDate, TicketStatus) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    try (Connection conn = getConnect(); // Đảm bảo bạn có phương thức này để lấy kết nối
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, ticketID);
        pstmt.setString(2, bookingID);
        pstmt.setString(3, showID);
        pstmt.setString(4, theatreID);
        pstmt.setString(5, roomID);
        pstmt.setString(6, seatID);
        
        // Nếu voucherID là null, đặt giá trị NULL vào câu truy vấn
        if (voucherID == null || voucherID.isEmpty()) {
            pstmt.setNull(7, java.sql.Types.CHAR); // Hoặc loại dữ liệu phù hợp với VoucherID
        } else {
            pstmt.setString(7, voucherID);
        }
        
        pstmt.setDouble(8, price);
        pstmt.setTimestamp(9, new java.sql.Timestamp(bookingDate.getTime())); // Chuyển đổi Date thành Timestamp
        pstmt.setString(10, ticketStatus);

        int rowsAffected = pstmt.executeUpdate();
        return rowsAffected > 0; // Trả về true nếu thêm thành công
    } catch (SQLException e) {
        e.printStackTrace(); // Xử lý lỗi ở đây
        return false;
    }
}

public static List<Ticket> getTicketsByUserID(String userID) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT * FROM Tickets WHERE UserID = ?"; // Truy vấn vé dựa trên UserID

        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, userID); // Thiết lập giá trị cho tham số UserID
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                // Lấy các cột từ kết quả truy vấn
                String ticketID = rs.getString("TicketID");
                String bookingID = rs.getString("BookingID");
                String bookingSeatID = rs.getString("BookingSeatID");
                String roomID = rs.getString("RoomID");
                String bookingComboID = rs.getString("BookingComboID");
                Date bookingDate = rs.getDate("BookingDate");
                BigDecimal totalPrice = rs.getBigDecimal("TotalPrice");

                // Tạo đối tượng Ticket và thêm vào danh sách
                Ticket ticket = new Ticket(ticketID, bookingID, userID, bookingSeatID, roomID, bookingComboID, bookingDate, totalPrice);
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi truy vấn vé: " + e.getMessage());
        }

        return tickets;
    }
//public static List<ShowInfo1> getShowInfoByUserID(String userID) {
//    List<ShowInfo1> showInfos = new ArrayList<>();
//    String sql = "SELECT th.TheatreName, s.SeatName, sh.ShowDate, sh.StartTime, r.RoomName, bs.Price " +
//                 "FROM Tickets t " +
//                 "JOIN Booking b ON t.BookingID = b.BookingID " +
//                 "JOIN Booking_Seats bs ON t.BookingSeatID = bs.BookingSeatID " +
//                 "JOIN Seats s ON bs.SeatID = s.SeatID " +
//                 "JOIN ShowSeats ss ON bs.ShowID = ss.ShowID AND bs.SeatID = ss.SeatID " +
//                 "JOIN Shows sh ON ss.ShowID = sh.ShowID " +
//                 "JOIN Theatres th ON ss.TheatreID = th.TheatreID " +
//                 "JOIN Rooms r ON s.RoomID = r.RoomID " +
//                 "WHERE t.UserID = ?";
//
//    try (Connection conn = getConnect();
//         PreparedStatement pstmt = conn.prepareStatement(sql)) {
//        
//        pstmt.setString(1, userID);
//        ResultSet rs = pstmt.executeQuery();
//
//        while (rs.next()) {
//            String theatreName = rs.getString("TheatreName");
//            String seatName = rs.getString("SeatName");
//            Date showDate = rs.getDate("ShowDate");
//           String startTime = rs.getString("StartTime");
//           if (startTime != null && startTime.length() > 8) {
//                startTime = startTime.substring(0, 8); // Lấy 8 ký tự đầu tiên
//            }
//            String roomName = rs.getString("RoomName");
//            BigDecimal price = rs.getBigDecimal("Price"); // Lấy giá tiền
//
//            // Tạo đối tượng ShowInfo và thêm vào danh sách
//            ShowInfo1 showInfo = new ShowInfo1(theatreName, seatName, showDate, startTime, roomName, price);
//            showInfos.add(showInfo);
//        }
//    } catch (SQLException e) {
//        System.out.println("Lỗi khi truy vấn thông tin suất chiếu: " + e.getMessage());
//    }
//
//    return showInfos;
//}

>>>>>>> Stashed changes

    // Private method to generate a unique ID
    private static String generateUniqueTicketDetailID() {
        return UUID.randomUUID().toString().substring(0, 6);
    }
<<<<<<< Updated upstream
}
=======
    
//   public static void main(String[] args) {
//        // Thay thế userID bằng một ID hợp lệ
//        String userID = "U00003"; // Đảm bảo rằng userID này tồn tại trong cơ sở dữ liệu
//
//        // Gọi phương thức getTicketsByUserID
//       List<ShowInfo1> showInfos = TicketDB.getShowInfoByUserID(userID);
//for (ShowInfo1 showInfo : showInfos) {
//    System.out.println("Theatre Name: " + showInfo.getTheatreName());
//    System.out.println("Seat Name: " + showInfo.getSeatName());
//    System.out.println("Show Date: " + showInfo.getShowDate());
//    System.out.println("Start Time: " + showInfo.getStartTime());
//    System.out.println("Room Name: " + showInfo.getRoomName());
//}
//   }
   
   
   public static List<Ticket> listAllTickets() {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT TicketID, UserID, BookingID, BookingSeatID, RoomID, BookingComboID, BookingDate, TotalPrice " +
                     "FROM Tickets";

        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                String ticketID = rs.getString("TicketID");
                String userID = rs.getString("UserID");
                String bookingID = rs.getString("BookingID");
                String bookingSeatID = rs.getString("BookingSeatID");
                String roomID = rs.getString("RoomID");
                String bookingComboID = rs.getString("BookingComboID");
                Date bookingDate = rs.getDate("BookingDate");
                BigDecimal totalPrice = rs.getBigDecimal("TotalPrice");

                // Tạo đối tượng Ticket và thêm vào danh sách
                Ticket ticket = new Ticket(ticketID, userID, bookingID, bookingSeatID, roomID, bookingComboID, bookingDate, totalPrice);
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi truy vấn thông tin vé: " + e.getMessage());
        }

        return tickets;
    }
public static List<ShowInfo1> getShowInfoByUserIDAndBookingID(String userID, String bookingID) {
    List<ShowInfo1> showInfos = new ArrayList<>();
    String sql = "SELECT th.TheatreName, s.SeatName, sh.ShowDate, sh.StartTime, r.RoomName, bs.Price, m.MovieName, t.Status,t.ticketID " +
                 "FROM Tickets t " +
                 "JOIN Booking b ON t.BookingID = b.BookingID " +
                 "JOIN Booking_Seats bs ON t.BookingSeatID = bs.BookingSeatID " +
                 "JOIN Seats s ON bs.SeatID = s.SeatID " +
                 "JOIN ShowSeats ss ON bs.ShowID = ss.ShowID AND bs.SeatID = ss.SeatID " +
                 "JOIN Shows sh ON ss.ShowID = sh.ShowID " +
                 "JOIN Theatres th ON ss.TheatreID = th.TheatreID " +
                 "JOIN Rooms r ON s.RoomID = r.RoomID " +
                 "JOIN Movies m ON sh.MovieID = m.MovieID " + 
                 "WHERE t.UserID = ? AND b.BookingID = ?";

    try (Connection conn = getConnect();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, userID);
        pstmt.setString(2, bookingID); // Thêm điều kiện cho BookingID
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            String theatreName = rs.getString("TheatreName");
            String seatName = rs.getString("SeatName");
            Date showDate = rs.getDate("ShowDate");
            String startTime = rs.getString("StartTime");
            if (startTime != null && startTime.length() > 8) {
                startTime = startTime.substring(0, 8); // Lấy 8 ký tự đầu tiên
            }
            String roomName = rs.getString("RoomName");
           BigDecimal priceDecimal = rs.getBigDecimal("Price"); // Lấy giá tiền dưới dạng BigDecimal
    int price = priceDecimal != null ? priceDecimal.intValue() : 0; 
            String movieName = rs.getString("MovieName"); // Lấy tên phim
            String status = rs.getString("Status"); // Lấy trạng thái
            String ticketID = rs.getString("ticketID");
            // Tạo đối tượng ShowInfo và thêm vào danh sách
            ShowInfo1 showInfo = new ShowInfo1(ticketID,theatreName, seatName, showDate, startTime, roomName, price, movieName, status);
            showInfos.add(showInfo);
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi truy vấn thông tin suất chiếu: " + e.getMessage());
    }

    return showInfos;
}
public static List<ShowInfo1> getAllShowInfo() {
    List<ShowInfo1> showInfos = new ArrayList<>();
    String sql = "SELECT th.TheatreName, s.SeatName, sh.ShowDate, sh.StartTime, r.RoomName, bs.Price, m.MovieName, t.Status, t.ticketID " +
                 "FROM Tickets t " +
                 "JOIN Booking b ON t.BookingID = b.BookingID " +
                 "JOIN Booking_Seats bs ON t.BookingSeatID = bs.BookingSeatID " +
                 "JOIN Seats s ON bs.SeatID = s.SeatID " +
                 "JOIN ShowSeats ss ON bs.ShowID = ss.ShowID AND bs.SeatID = ss.SeatID " +
                 "JOIN Shows sh ON ss.ShowID = sh.ShowID " +
                 "JOIN Theatres th ON ss.TheatreID = th.TheatreID " +
                 "JOIN Rooms r ON s.RoomID = r.RoomID " +
                 "JOIN Movies m ON sh.MovieID = m.MovieID";

    try (Connection conn = getConnect();
         PreparedStatement pstmt = conn.prepareStatement(sql);
         ResultSet rs = pstmt.executeQuery()) {

        while (rs.next()) {
            String theatreName = rs.getString("TheatreName");
            String seatName = rs.getString("SeatName");
            Date showDate = rs.getDate("ShowDate");
            String startTime = rs.getString("StartTime");
            if (startTime != null && startTime.length() > 8) {
                startTime = startTime.substring(0, 8); // Lấy 8 ký tự đầu tiên
            }
            String roomName = rs.getString("RoomName");
            BigDecimal priceDecimal = rs.getBigDecimal("Price"); // Lấy giá tiền dưới dạng BigDecimal
            int price = priceDecimal != null ? priceDecimal.intValue() : 0;
            String movieName = rs.getString("MovieName");
            String status = rs.getString("Status");
            String ticketID = rs.getString("ticketID");

            // Tạo đối tượng ShowInfo và thêm vào danh sách
            ShowInfo1 showInfo = new ShowInfo1(ticketID, theatreName, seatName, showDate, startTime, roomName, price, movieName, status);
            showInfos.add(showInfo);
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi truy vấn thông tin suất chiếu: " + e.getMessage());
    }

    return showInfos;
}

public static void requestRefund(String ticketID) {
    String sql = "UPDATE Tickets SET Status = N'Đang chờ' WHERE TicketID = ?";
    
    try (Connection conn = getConnect(); 
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, ticketID);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace(); // In ra chi tiết lỗi nếu có
    }
}
public static void approveRefund(String ticketID) {
    String sql = "UPDATE Tickets SET Status = N'Chấp thuận' WHERE TicketID = ?";
    
    try (Connection conn = getConnect(); 
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, ticketID);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace(); // In ra chi tiết lỗi nếu có
    }
}
public static void rejectRefund(String ticketID) {
    String sql = "UPDATE Tickets SET Status = N'Từ chối' WHERE TicketID = ?";
    
    try (Connection conn = getConnect(); 
            PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, ticketID);
        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace(); // In ra chi tiết lỗi nếu có
    }
}
public static void addBalanceToUser(String ticketID) {
    String getUserBalanceSQL = "SELECT u.UserID, u.MoneyLeft, t.TotalPrice " + // Thay TotalPrice thành Price
                               "FROM Users u " +
                               "JOIN Tickets t ON u.UserID = t.UserID " +
                               "WHERE t.ticketID = ?";

    String updateUserBalanceSQL = "UPDATE Users SET MoneyLeft = ? WHERE UserID = ?";

    try (Connection conn = getConnect();
         PreparedStatement getUserStmt = conn.prepareStatement(getUserBalanceSQL);
         PreparedStatement updateUserStmt = conn.prepareStatement(updateUserBalanceSQL)) {

        // Lấy thông tin UserID, Balance hiện tại và Price của ticket
        getUserStmt.setString(1, ticketID);
        ResultSet rs = getUserStmt.executeQuery();

        if (rs.next()) {
            String userID = rs.getString("UserID");
            BigDecimal balance = rs.getBigDecimal("MoneyLeft");
            BigDecimal ticketPrice = rs.getBigDecimal("TotalPrice"); // Lấy giá vé

            // Cộng tiền vào tài khoản người dùng
            BigDecimal newBalance = balance.add(ticketPrice);

            // Cập nhật số dư vào Users
            updateUserStmt.setBigDecimal(1, newBalance);
            updateUserStmt.setString(2, userID);
            updateUserStmt.executeUpdate();
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi cộng tiền vào tài khoản người dùng: " + e.getMessage());
    }
}


}
>>>>>>> Stashed changes
