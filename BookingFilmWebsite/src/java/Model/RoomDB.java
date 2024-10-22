package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.ShowSeatDB.getConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
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
public static String getRoomIdBySeatNamesAndShowDateAndTime(String seatNames, String showDate, String startTime) {
    String roomId = null;

    // Kiểm tra danh sách ghế không rỗng
    if (!seatNames.isEmpty()) {
        // Tách chuỗi và loại bỏ khoảng trắng
        List<String> seatNameList = Arrays.asList(seatNames.split(",\\s*"));

        // Tạo placeholder cho điều kiện IN
        String seatNamesPlaceholder = String.join(",", Collections.nCopies(seatNameList.size(), "?"));

        String query = "SELECT ss.RoomID " +
                       "FROM ShowSeats ss " +
                       "JOIN Seats se ON ss.SeatID = se.SeatID " +
                       "JOIN Shows sh ON ss.ShowID = sh.ShowID " +
                       "WHERE se.SeatName IN (" + seatNamesPlaceholder + ") " +
                       "AND sh.ShowDate = ? " +
                       "AND sh.StartTime = ?";

        try (Connection con = getConnect(); 
             PreparedStatement preparedStatement = con.prepareStatement(query)) {

            // Đặt giá trị cho các tham số ghế
            for (int i = 0; i < seatNameList.size(); i++) {
                preparedStatement.setString(i + 1, seatNameList.get(i).trim()); // Loại bỏ khoảng trắng
            }

            // Đặt giá trị cho tham số ngày và giờ
            preparedStatement.setString(seatNameList.size() + 1, showDate);
            preparedStatement.setString(seatNameList.size() + 2, startTime);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    roomId = resultSet.getString("RoomID");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    return roomId; // Trả về RoomID hoặc null nếu không tìm thấy
}


public static String getRoomIDFromShow(String showID) {
    String roomId = null;
    String query = "SELECT DISTINCT RoomID FROM ShowSeats WHERE ShowID = ?";

    try (Connection con = getConnect()) {
        PreparedStatement preparedStatement = con.prepareStatement(query);
        preparedStatement.setString(1, showID);

        try (ResultSet resultSet = preparedStatement.executeQuery()) {
            if (resultSet.next()) {
                roomId = resultSet.getString("RoomID");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return roomId; // Trả về RoomID hoặc null nếu không tìm thấy
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
            String query = "SELECT * FROM Rooms WHERE TheatreID=?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, cinemaID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Room room = new Room(rs.getString("RoomID"),
                        rs.getString("RoomName"),
                        cinemaID);
                roomList.add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return roomList;
    }
    
    public static List<Room> getAllRoom() {
        List<Room> roomList = new ArrayList<>();
        try (Connection con = getConnect()) {
            String query = "SELECT * FROM Rooms";
            PreparedStatement stmt = con.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Room room = new Room(rs.getString("RoomID"),
                        rs.getString("RoomName"),
                        rs.getString("TheatreID"));
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
        List<Room> rooms = getAllRoom();
        for (Room r : rooms) {
            System.out.println(r);
        }
    }
}
