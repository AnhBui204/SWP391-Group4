package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.SeatDB.getSeat;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class ShowDB {

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

    // Định dạng cho LocalDateTime
    private static DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

    // Lấy danh sách tất cả các Show
    public static List<Show> getAllShows() {
        List<Show> showList = new ArrayList<>();
        String sql = "SELECT * FROM Shows"; // Giả sử bảng của bạn tên là 'Shows'

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String showID = rs.getString("ShowID");

                // Chuyển chuỗi thời gian thành LocalDateTime
                LocalDateTime startTime = LocalDateTime.parse(rs.getString("StartTime"), formatter);
                LocalDateTime endTime = LocalDateTime.parse(rs.getString("EndTime"), formatter);

                String movieID = rs.getString("MovieID");

                Show show = new Show(showID, startTime, endTime, movieID);
                showList.add(show);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return showList;
    }

    // Lấy thông tin show theo ID
    public static Show getShowById(String showID) {
        String sql = "SELECT * FROM Shows WHERE ShowID = ?";
        Show show = null;

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, showID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                LocalDateTime startTime = LocalDateTime.parse(rs.getString("StartTime"), formatter);
                LocalDateTime endTime = LocalDateTime.parse(rs.getString("EndTime"), formatter);
                String movieID = rs.getString("MovieID");

                show = new Show(showID, startTime, endTime, movieID);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return show;
    }

    // Thêm mới một show
    public static boolean addShow(Show show) {
        String sql = "INSERT INTO Shows (ShowID, StartTime, EndTime, MovieID) VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, show.getShowID());
            ps.setString(2, show.getStartTime().format(formatter));
            ps.setString(3, show.getEndTime().format(formatter));
            ps.setString(4, show.getMovieID());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Cập nhật thông tin show
    public static boolean updateShow(Show show) {
        String sql = "UPDATE Shows SET StartTime = ?, EndTime = ?, MovieID = ? WHERE ShowID = ?";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, show.getStartTime().format(formatter));
            ps.setString(2, show.getEndTime().format(formatter));
            ps.setString(3, show.getMovieID());
            ps.setString(4, show.getShowID());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Xóa một show theo ID
    public static boolean deleteShow(String showID) {
        String sql = "DELETE FROM Shows WHERE ShowID = ?";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, showID);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public static void main(String[] args) {
//        Show newShow = new Show("SH001", LocalDateTime.now(), LocalDateTime.now().plusHours(2), "MV001");
//        ShowDB.addShow(newShow);
//
//    // Lấy show theo ID
//        Show show = ShowDB.getShowById("SH001");
//        System.out.println(show);
//
//    // Cập nhật show
//        show.setMovieID("MV002");
//        ShowDB.updateShow(show);
//
//    // Xóa show
//        ShowDB.deleteShow("SH001");

        // Lấy danh sách tất cả các show
        List<Show> allShows = ShowDB.getAllShows();
        allShows.forEach(System.out::println);
    }
}
