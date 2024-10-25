package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.MovieDB.getConnect;
import static Model.SeatDB.getSeat;
import java.sql.*;
import java.text.SimpleDateFormat;
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

    // Lấy danh sách tất cả các Show
    public static List<Show> getAllShows() {
        List<Show> showList = new ArrayList<>();
        String sql = "SELECT * FROM Shows";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String showID = rs.getString("ShowID");
                Date date = rs.getDate("ShowDate");
                Time time = rs.getTime("StartTime");
                String movieID = rs.getString("MovieID");

                Show show = new Show(showID, date, time, movieID);
                showList.add(show);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return showList;
    }
public static String getShowID(String showDate, String startTime) {
    String showID = null;
    String sql = "SELECT ShowID FROM Shows WHERE ShowDate = ? AND StartTime = ? ";

    try (Connection conn = getConnect(); 
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, showDate);
        pstmt.setString(2, startTime);
      

        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                showID = rs.getString("ShowID"); // Lấy giá trị ShowID từ kết quả truy vấn
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return showID;
}
    public static List<Show> getAllShowsByMovieID(String movieID) {
        List<Show> showList = new ArrayList<>();
        String sql = "SELECT * FROM Shows where MovieID = ?";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movieID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String showID = rs.getString("ShowID");
                Date date = rs.getDate("ShowDate");
                Time time = rs.getTime("StartTime");

                Show show = new Show(showID, date, time, movieID);
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
                Time startTime = rs.getTime("StartTime");
                Date date = rs.getDate("ShowDate");
                String movieID = rs.getString("MovieID");

                show = new Show(showID, date, startTime, movieID);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return show;
    }

    public static String getNextShowID() {
        String sql = "SELECT 'SH' + RIGHT('0000' + CAST(CAST(SUBSTRING(MAX(ShowID), 3, 4) AS INT) + 1 AS VARCHAR(4)), 4) AS NextID FROM Shows";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getString("NextID");
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving next ShowID: " + e.getMessage());
        }

        return "SH0001"; // Default ID when the table is empty
    }

    // Thêm mới một show
    public static boolean addShow(Show show) {
        String sql = "INSERT INTO Shows (ShowID, ShowDate, StartTime, MovieID) VALUES (?, ?, ?, ?)";

        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, getNextShowID());
            ps.setDate(2, show.getShowDate());
            ps.setTime(3, show.getShowTime());
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

            ps.setString(1, show.getShowID());
            ps.setDate(2, show.getShowDate());
            ps.setTime(3, show.getShowTime());
            ps.setString(4, show.getMovieID());

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

  
 public static List<String> getShowDatesByMovieAndTheatre(String movieID, String theatreID) {
        List<String> showDates = new ArrayList<>();
        String sql = "SELECT DISTINCT s.ShowDate " +
                     "FROM Shows s " +
                     "JOIN ShowSeats ss ON s.ShowID = ss.ShowID " +
                     "WHERE ss.TheatreID = ? AND s.MovieID = ?";

        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, theatreID);
            pstmt.setString(2, movieID); 

            ResultSet rs = pstmt.executeQuery();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // Định dạng ngày

            while (rs.next()) {
                Date showDate = rs.getDate("ShowDate");
                if (showDate != null) {
                    showDates.add(dateFormat.format(showDate)); 
                }
            }
            
        } catch (SQLException e) {
        }
        
        return showDates; 
    }

    public static List<Time> getStartTimes(String movieID, String theatreID, String showDate) {
        List<Time> startTimes = new ArrayList<>();
        String sql = "SELECT StartTime FROM Shows "
                + "WHERE MovieID = ? AND ShowDate = ? AND ShowID IN "
                + "(SELECT ShowID FROM ShowSeats WHERE TheatreID = ? AND IsAvailable = 1)";

        try {
            Connection conn = getConnect(); // Lấy kết nối từ phương thức getConnect()
            PreparedStatement pstmt = conn.prepareStatement(sql); // Tạo PreparedStatement

            pstmt.setString(1, movieID);
            pstmt.setDate(2, java.sql.Date.valueOf(showDate));
            pstmt.setString(3, theatreID);

            ResultSet resultSet = pstmt.executeQuery(); // Thực thi truy vấn

            // Lấy thời gian bắt đầu và thêm vào danh sách
            while (resultSet.next()) {
                startTimes.add(resultSet.getTime("StartTime")); // Chuyển đổi thành chuỗi
            }
        } catch (SQLException e) {
            // Ghi lại lỗi nếu có

        }
        return startTimes; // Trả về danh sách thời gian bắt đầu
    }

    public static void main(String[] args) {
        String s = getNextShowID();
        System.out.println(s);
        Show newShow = new Show(s, Date.valueOf("2024-06-30"), Time.valueOf("10:10:10"), "M00002");
        ShowDB.addShow(newShow);
        System.out.println(newShow);
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
        List<String> allShows = ShowDB.getShowDatesByMovieAndTheatre("M00001","T00001");
        allShows.forEach(System.out::println);

    }
}
