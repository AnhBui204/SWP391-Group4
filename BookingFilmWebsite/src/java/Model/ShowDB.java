package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.SeatDB.getSeat;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
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

public static List<Show> getAllShows() {
    List<Show> showList = new ArrayList<>();
    String sql = "SELECT ShowID, ShowDate, StartTime, MovieID FROM Shows"; 

    try (Connection conn = getConnect(); 
         PreparedStatement ps = conn.prepareStatement(sql); 
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            String showID = rs.getString("ShowID");
            LocalDate showDate = rs.getDate("ShowDate").toLocalDate(); // Lấy ngày chiếu
            LocalTime startTime = rs.getTime("StartTime").toLocalTime(); // Lấy giờ bắt đầu
            String movieID = rs.getString("MovieID");

            // Tạo đối tượng Show và thêm vào danh sách
            Show show = new Show(showID, showDate, startTime, movieID); // EndTime là null
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
public static String getShowIDFromDateAndTime(Date showDate, Time startTime) {
    String showID = null;
    String sql = "SELECT ShowID FROM Shows WHERE ShowDate = ? AND StartTime = ?"; // Cập nhật để sử dụng showDate và startTime

    try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setDate(1, new java.sql.Date(showDate.getTime())); // Chuyển đổi Date sang java.sql.Date
        stmt.setTime(2, startTime); // Sử dụng startTime

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            showID = rs.getString("ShowID");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return showID; // Trả về ShowID
}







    // Xóa một show theo ID
    public static boolean deleteShow(String showID) {
        String sql = "DELETE FROM Shows WHERE ShowID = ?";

        try (Connection conn = getConnect(); 
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, showID);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
 public static List<String> getStartTimes(String movieID, String theatreID, String showDate) {
    List<String> startTimes = new ArrayList<>();
    String sql = "SELECT StartTime FROM Shows " +
                 "WHERE MovieID = ? AND ShowDate = ? AND ShowID IN " +
                 "(SELECT ShowID FROM ShowSeats WHERE TheatreID = ? AND IsAvailable = 1)";

    try {
       Connection conn = getConnect(); 
    PreparedStatement    pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, movieID);
        pstmt.setDate(2, java.sql.Date.valueOf(showDate));
        pstmt.setString(3, theatreID);

   ResultSet resultSet = pstmt.executeQuery(); // Thực thi truy vấn

        // Lấy thời gian bắt đầu và thêm vào danh sách
        while (resultSet.next()) {
            startTimes.add(resultSet.getTime("StartTime").toString()); // Chuyển đổi thành chuỗi
        }
    } catch (SQLException e) {
        // Ghi lại lỗi nếu có
        
    } 

    return startTimes; // Trả về danh sách thời gian bắt đầu
}

 public static void main(String[] args) {
        // Ví dụ gọi phương thức getStartTimes
     
     
        String showDate = "2024-09-13"; // Ngày chiếu
        String startTime = "16:30:00";
       
       String showID = getShowID(showDate, startTime);

        // Kiểm tra và hiển thị kết quả
        if (showID != null) {
            System.out.println("ShowID: " + showID);
        } else {
            System.out.println("Không tìm thấy ShowID cho ngày và giờ đã nhập.");
        }
    }
}