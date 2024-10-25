package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
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


    // Read - Lấy một chi tiết vé


  
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
public static List<ShowInfo1> getShowInfoByUserID(String userID) {
    List<ShowInfo1> showInfos = new ArrayList<>();
    String sql = "SELECT th.TheatreName, s.SeatName, sh.ShowDate, sh.StartTime, r.RoomName, bs.Price " +
                 "FROM Tickets t " +
                 "JOIN Booking b ON t.BookingID = b.BookingID " +
                 "JOIN Booking_Seats bs ON t.BookingSeatID = bs.BookingSeatID " +
                 "JOIN Seats s ON bs.SeatID = s.SeatID " +
                 "JOIN ShowSeats ss ON bs.ShowID = ss.ShowID AND bs.SeatID = ss.SeatID " +
                 "JOIN Shows sh ON ss.ShowID = sh.ShowID " +
                 "JOIN Theatres th ON ss.TheatreID = th.TheatreID " +
                 "JOIN Rooms r ON s.RoomID = r.RoomID " +
                 "WHERE t.UserID = ?";

    try (Connection conn = getConnect();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, userID);
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
            BigDecimal price = rs.getBigDecimal("Price"); // Lấy giá tiền

            // Tạo đối tượng ShowInfo và thêm vào danh sách
            ShowInfo1 showInfo = new ShowInfo1(theatreName, seatName, showDate, startTime, roomName, price);
            showInfos.add(showInfo);
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi truy vấn thông tin suất chiếu: " + e.getMessage());
    }

    return showInfos;
}


    // Private method to generate a unique ID
    public static String generateUniqueTicketDetailID() {
        return UUID.randomUUID().toString().substring(0, 6);
    }
    
   public static void main(String[] args) {
        // Thay thế userID bằng một ID hợp lệ
        String userID = "U00003"; // Đảm bảo rằng userID này tồn tại trong cơ sở dữ liệu

        // Gọi phương thức getTicketsByUserID
       List<ShowInfo1> showInfos = TicketDB.getShowInfoByUserID(userID);
for (ShowInfo1 showInfo : showInfos) {
    System.out.println("Theatre Name: " + showInfo.getTheatreName());
    System.out.println("Seat Name: " + showInfo.getSeatName());
    System.out.println("Show Date: " + showInfo.getShowDate());
    System.out.println("Start Time: " + showInfo.getStartTime());
    System.out.println("Room Name: " + showInfo.getRoomName());
}
   }
   
   
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

}