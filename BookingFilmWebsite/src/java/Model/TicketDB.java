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

    // Private method to generate a unique ID
    private static String generateUniqueTicketDetailID() {
        return UUID.randomUUID().toString().substring(0, 6);
    }
}
