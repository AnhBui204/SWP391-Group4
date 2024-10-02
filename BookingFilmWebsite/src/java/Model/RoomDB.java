package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.ShowSeatDB.getConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class RoomDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    // Method to get room details by RoomID
    public static Room getRoom(String roomID) {
        Room room = null;
        try (Connection con = getConnect()) {
            String query = "SELECT RoomID, RoomName, t.TheatreName FROM Rooms "
                    + "r inner join Theatres t on r.TheatreID = t.TheatreID\n"
                    + "WHERE RoomID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, roomID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                room = new Room(rs.getString("RoomID"), rs.getString("RoomName"), rs.getString("TheatreName"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return room;
    }
    
    //Get room by showID
    public static List<Room> getRoomByShow(String ShowID) {
        List<Room> roomlist = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT DISTINCT r.RoomID, r.RoomName, r.theatreID "
                         + "FROM ROOMS r INNER JOIN ShowSeats ss "
                         + "ON r.RoomID = ss.RoomID WHERE ShowID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, ShowID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Room room = new Room(
                        rs.getString("RoomID"),
                        rs.getString("RoomName"),
                        rs.getString("theatreID")
                );
                roomlist.add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SeatDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return roomlist;
    }

    // Method to get all rooms by CinemaID
    public static List<Room> getRoomsByCinema(String cinemaID) {
        List<Room> roomList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT RoomID, RoomName, t.TheatreName FROM Rooms "
                    + "r inner join Theatres t on r.TheatreID = t.TheatreID\n"
                    + "WHERE r.TheatreID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, cinemaID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Room room = new Room(rs.getString("RoomID"),
                        rs.getString("RoomName"),
                        rs.getString("TheatreName"));
                roomList.add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return roomList;
    }

    public static int deleteRoom(String roomID) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("DELETE FROM Rooms WHERE RoomID=?");
            stmt.setString(1, roomID);
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public static void insertRoom(Room room) {
        String sql = "INSERT INTO Rooms (RoomID, RoomName, TheatreID) VALUES (?, ?, ?)";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, room.getRoomID());
            stmt.setString(2, room.getRoomName());
            stmt.setString(3, room.getCinemaID());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void updateRoom(Room room) {
        String sql = "UPDATE Rooms SET RoomName=?, TheatreID=? WHERE RoomID=?";
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, room.getRoomName());
            stmt.setString(2, room.getCinemaID());
            stmt.setString(3, room.getRoomID());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        // Example usage (you can uncomment to test):
        Room room = getRoom("R00001");
        System.out.println(room);
        System.out.println("-----------");
//        List<Room> rooms = getRoomsByCinema("T00001");
//        for (Room r : rooms) {
//            System.out.println(r);
//        }
        List<Room> rooms = getRoomByShow("SH0001");
        for (Room r : rooms) {
            System.out.println(r);
        }
    }
}
