package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class SeatDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver: " + e);
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    // Method to get a seat by SeatID
    public static Seat getSeat(String seatID) {
        Seat seat = null;
        try (Connection con = getConnect()) {
            String query = "SELECT SeatID, SeatName, RoomID, TheatreID FROM Seats WHERE SeatID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, seatID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                seat = new Seat(rs.getString("SeatID"), rs.getString("SeatName"), rs.getString("RoomID"), rs.getString("TheatreID"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return seat;
    }

    public static List<String> getSeatIDsFromNames(String seatNames, String roomID) {
        List<String> seatIDs = new ArrayList<>();
        // Tách chuỗi thành danh sách các ghế
        List<String> seatNameList = Arrays.asList(seatNames.split(",\\s*")); // Tách chuỗi và loại bỏ khoảng trắng

        String sql = "SELECT Distinct se.SeatID "
                + "FROM Seats se "
                + "JOIN ShowSeats ss ON se.SeatID = ss.SeatID "
                + "WHERE se.SeatName = ? "
                + "AND ss.RoomID = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (String seatName : seatNameList) {
                stmt.setString(1, seatName);
                stmt.setString(2, roomID);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    seatIDs.add(rs.getString("SeatID")); // Lưu SeatID vào danh sách
                }
                // Clear parameters before the next iteration
                stmt.clearParameters(); // Xóa các tham số đã đặt
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return seatIDs; // Trả về danh sách SeatID
    }

    // Method to get all seats in a specific room
    public static List<Seat> getSeatsByRoom(String roomID) {
        List<Seat> seatList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT SeatID, SeatName, RoomID, TheatreID FROM Seats WHERE RoomID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, roomID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Seat seat = new Seat(rs.getString("SeatID"), rs.getString("SeatName"), rs.getString("RoomID"), rs.getString("TheatreID"));
                seatList.add(seat);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return seatList;
    }

    // Method to insert a new seat
    public static void insert(Seat seat) {
        String sql = "INSERT INTO Seats (SeatID, SeatName, RoomID, TheatreID) VALUES (?, ?, ?, ?)";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, seat.getSeatID());
            stmt.setString(2, seat.getSeatName());
            stmt.setString(3, seat.getRoomID());
            stmt.setString(4, seat.getTheatreID());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Method to update an existing seat
    public static void update(Seat seat) {
        String sql = "UPDATE Seats SET SeatName=?, RoomID=?, TheatreID=? WHERE SeatID=?";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, seat.getSeatName());
            stmt.setString(2, seat.getRoomID());
            stmt.setString(3, seat.getTheatreID());
            stmt.setString(4, seat.getSeatID());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Method to delete a seat
    public static int delete(String seatID) {
        int rowsAffected = 0;
        try (Connection con = getConnect()) {
            String sql = "DELETE FROM Seats WHERE SeatID=?";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, seatID);
            rowsAffected = stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rowsAffected;
    }

    // Method to list all seats
    public static List<Seat> listAll() {
        List<Seat> seatList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT SeatID, SeatName, RoomID, TheatreID FROM Seats";
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Seat seat = new Seat(rs.getString("SeatID"), rs.getString("SeatName"), rs.getString("RoomID"), rs.getString("TheatreID"));
                seatList.add(seat);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return seatList;
    }

    public static void main(String[] args) {
        // Example usage
//        Seat a = getSeat("S00001");
//        System.out.println(a);
        // List all seats
        //        List<Seat> seats = listAll();
        //        for (Seat seat : seats) {
        //            System.out.println(seat);
        //        }

        List<String> seats = getSeatIDsFromNames("A1, A2, A4", "R00001");
        for(String s : seats){
            System.out.println(s);
        }
    }
}
