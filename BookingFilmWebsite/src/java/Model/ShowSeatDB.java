/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;


import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.SeatDB.getConnect;
import static Model.SeatDB.getSeat;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ShowSeatDB {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            return con;
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }
    
    public static ShowSeat getShowSeat(String seatID){
        ShowSeat showseat = null;
        try (Connection con = getConnect()){
            String query = "Select * from ShowSeats where SeatID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, seatID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                showseat = new ShowSeat(rs.getString("ShowID"), rs.getString("SeatID"), rs.getString("RoomID"), rs.getString("TheatreID"), rs.getInt("IsAvailable"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return showseat;
    }

 public static List<ShowSeat> getSeatByRoom(String roomID) {
        List<ShowSeat> seatList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT showID, seatID, roomID, theatreID, IsAvailable FROM ShowSeats WHERE RoomID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, roomID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ShowSeat showSeat = new ShowSeat(
                        rs.getString("showID"),
                        rs.getString("seatID"),
                        rs.getString("roomID"),
                        rs.getString("theatreID"),
                        rs.getInt("IsAvailable")
                );
                seatList.add(showSeat);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return seatList;
    }

    public static ShowSeat bookSeat(String seatID) {
        ShowSeat bookedSeat = null;
        try (Connection con = getConnect()) {
            String updateQuery = "UPDATE ShowSeats SET IsAvailable = 0 WHERE SeatID = ?";
            try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                updateStmt.setString(1, seatID);
                int rowsUpdated = updateStmt.executeUpdate();
                if (rowsUpdated > 0) {
                    Logger.getLogger(RoomDB.class.getName()).log(Level.INFO, "Seat updated successfully for Seat ID: " + seatID);
                    bookedSeat = getShowSeat(seatID);
                } else {
                    Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "No rows updated for Seat ID: " + seatID);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error booking seat with ID: " + seatID, ex);
        }
        return bookedSeat;
    }

    public static String insertBookingSeat(String userID, BigDecimal totalPrice, String status) {
        String seatBookingID = null;
        String insertBookingSeatSQL = "INSERT INTO Booking_Ticket(TicketBookingID, UserID, TotalPrice, Status, CreatedDate) VALUES (?, ?, ?, ?, GETDATE())";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingSeatSQL)) {
            seatBookingID = generateUniqueBookingID();
            pstmt.setString(1, seatBookingID);
            pstmt.setString(2, userID);
            pstmt.setBigDecimal(3, totalPrice);
            pstmt.setString(4, status);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error inserting booking seat: " + userID, e);
        }
        return seatBookingID;
    }

    public static boolean insertBookingTicketDetail(String bookingTicketID, String seatID, BigDecimal price, String status) throws ParseException {
        String insertBookingTicketDetailSQL = "INSERT INTO Booking_Ticket_Detail (BookingTicketID, SeatID, Price, Status) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(insertBookingTicketDetailSQL)) {
            pstmt.setString(1, bookingTicketID);
            pstmt.setString(2, seatID);
            pstmt.setBigDecimal(3, price);
            pstmt.setString(4, status);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<String> getBookingTicketIDBySeatID(String seatID) {
        List<String> bookingTicketID = new ArrayList<>();
        String query = "SELECT BookingTicketID FROM Booking_Ticket_Detail WHERE seatID = ?";
        try (Connection conn = getConnect(); PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, seatID);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    bookingTicketID.add(resultSet.getString("BookingTicketID"));
                }
            }
        } catch (SQLException e) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, "Error fetching BookingTicketIDs by SeatID: " + seatID, e);
        }
        return bookingTicketID;
    }

    private static String generateUniqueBookingID() {
        String uniqueID = UUID.randomUUID().toString().substring(0, 6);
        return uniqueID;
    }
    
    
    public static void main(String[] args) {
        // Example usage

        //List all seats
//        List<ShowSeat> seats = getSeatByRoom("R00007");
//        for (ShowSeat seat : seats) {
//            System.out.println(seat);
//        }
        bookSeat("S00001");
        ShowSeat a = getShowSeat("S00001");
        System.out.println(a);
    }
}
