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
import java.sql.*;
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

    public static ShowSeat getShowSeat(String seatID) {
        ShowSeat showseat = null;
        try (Connection con = getConnect()) {
            String query = "Select * from ShowSeats where SeatID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, seatID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                showseat = new ShowSeat(rs.getString("ShowID"), rs.getString("SeatID"), rs.getString("RoomID"), rs.getString("TheatreID"), rs.getInt("price"), rs.getInt("IsAvailable"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return showseat;
    }

    public static List<ShowSeat> getSeatByRoom(String roomID) {
        List<ShowSeat> seatList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT showID, seatID, roomID, theatreID, price, IsAvailable FROM ShowSeats WHERE RoomID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, roomID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ShowSeat showSeat = new ShowSeat(
                        rs.getString("showID"),
                        rs.getString("seatID"),
                        rs.getString("roomID"),
                        rs.getString("theatreID"),
                        rs.getInt("price"),
                        rs.getInt("IsAvailable")
                );
                seatList.add(showSeat);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return seatList;
    }

    public static List<ShowInfo> getShowsByRoomAndDate(String roomID, String showDate) {
        // Initialize an empty list to hold the results
        List<ShowInfo> showList = new ArrayList<>();

        // Start the try-with-resources block for handling database connection and resources
        try (Connection con = getConnect()) {
            // Prepare the SQL query with parameters for RoomID and ShowDate
            String query = "SELECT DISTINCT sh.showID, m.movieName, sh.ShowDate, sh.StartTime "
                    + "FROM ShowSeats ss "
                    + "INNER JOIN Shows sh ON ss.ShowID = sh.ShowID "
                    + "INNER JOIN Movies m ON sh.MovieID = m.MovieID "
                    + "WHERE ss.RoomID = ? "
                    + "AND sh.ShowDate = ?";

            // Create a PreparedStatement to securely execute the query with parameters
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, roomID);    // Set the RoomID parameter
            stmt.setString(2, showDate);  // Set the ShowDate parameter

            // Execute the query and get the ResultSet
            ResultSet rs = stmt.executeQuery();

            // Iterate over the ResultSet and build ShowInfo objects
            while (rs.next()) {
                // Extract values from the current row of the result set
                String showID = rs.getString("showID");
                String movieName = rs.getString("movieName");
                Date showDateValue = rs.getDate("ShowDate");
                Time startTime = rs.getTime("StartTime");

                // Create a new ShowInfo object and populate it with values
                ShowInfo showInfo = new ShowInfo(showID, movieName, showDateValue, startTime);

                // Add the ShowInfo object to the list
                showList.add(showInfo);
            }
        } catch (SQLException ex) {
            // Log any SQLException that occurs during database access
            Logger.getLogger(ShowDB.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Return the populated list of ShowInfo objects
        return showList;
    }

    public static boolean setShowSeat(String showID, String roomID, String theatreID, int money) {
        String insertQuery = "INSERT INTO ShowSeats (ShowID, SeatID, RoomID, TheatreID, price, IsAvailable) "
                + "SELECT ?, SeatID, RoomID, TheatreID, ?, 1 "
                + "FROM Seats "
                + "WHERE RoomID = ? AND TheatreID = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(insertQuery)) {

            stmt.setString(1, showID); // Set the showID parameter
            stmt.setInt(2, money); // Set the roomID parameter
            stmt.setString(3, roomID); // Set the roomID parameter
            stmt.setString(4, theatreID); // Set the theatreID parameter
            

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Return true if rows were affected
        } catch (SQLException e) {
            Logger.getLogger(ShowSeatDB.class.getName()).log(Level.SEVERE, "Error setting show seats: ", e);
        }
        return false;
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

    public static List<SeatDetail> getSeatsForShow(String movieID, String theatreID, String startTime, String showDate) {
        List<SeatDetail> seats = new ArrayList<>();

        String query = "SELECT DISTINCT s.SeatName, ss.IsAvailable, ss.Price "
                + "FROM Seats s "
                + "JOIN ShowSeats ss ON s.SeatID = ss.SeatID "
                + "JOIN Rooms r ON s.RoomID = r.RoomID "
                + "JOIN Theatres t ON r.TheatreID = t.TheatreID "
                + "JOIN Shows sh ON ss.ShowID = sh.ShowID "
                + "WHERE sh.MovieID = ? "
                + "AND t.TheatreID = ? "
                + "AND sh.StartTime = ? "
                + "AND sh.ShowDate = ?";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, movieID);
            pstmt.setString(2, theatreID);
            pstmt.setString(3, startTime);
            pstmt.setString(4, showDate);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                String seatName = rs.getString("SeatName");
                int isAvailable = rs.getInt("IsAvailable");
                int price = rs.getInt("Price");

                SeatDetail seatDetails = new SeatDetail(seatName, isAvailable, price);
                seats.add(seatDetails);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return seats;
    }

    private static String generateUniqueBookingID() {
        String uniqueID = UUID.randomUUID().toString().substring(0, 6);
        return uniqueID;
    }

    public static boolean updateSeatAvailability(String seatId, boolean isAvailable) throws SQLException {
        String sql = "UPDATE ShowSeats SET IsAvailable = ? WHERE SeatID = ?";
        try (
                Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, isAvailable); // Set availability (true or false)
            stmt.setString(2, seatId);       // Set the SeatID to identify the seat

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;  // Return true if the update was successful
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
    }

    public static void main(String[] args) {
        // Example usage

        //List all seats
        List<ShowSeat> seats = getSeatByRoom("R00010");
        for (ShowSeat seat : seats) {
            System.out.println(seat);
        }
//        boolean result = setShowSeat("SH0002", "R00010", "T00002", 80000);
//        if (result) {
//            System.out.println("Seats set successfully.");
//        } else {
//            System.out.println("Failed to set seats.");
//        }
    }
}
