package Model;
import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class RevenueDB {
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

     public static BigDecimal calculateTotalRevenueByDateAndTheatre(String bookingDate, String theatreID) {
        BigDecimal totalRevenue = BigDecimal.ZERO;

        // SQL query to get the total revenue for a specific date and theater
        String query = """
            SELECT SUM(t.TotalPrice) AS TotalRevenue
            FROM Tickets t
            JOIN Booking_Seats bs ON t.BookingSeatID = bs.BookingSeatID
            JOIN ShowSeats ss ON bs.SeatID = ss.SeatID AND bs.ShowID = ss.ShowID
            WHERE t.BookingDate = ? AND ss.TheatreID = ?
        """;

        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            // Set the date and theater ID parameters
            pstmt.setDate(1, java.sql.Date.valueOf(bookingDate));
            pstmt.setString(2, theatreID);

            // Execute the query and retrieve the result
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    totalRevenue = rs.getBigDecimal("TotalRevenue");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalRevenue != null ? totalRevenue : BigDecimal.ZERO;
    }
    public List<Revenue> getDailyRevenueByCinemaAndDate(String cinemaID, String selectedDate) {
        List<Revenue> revenueList = new ArrayList<>();
        
        // SQL Query để lấy doanh thu hàng ngày cho một rạp chiếu phim và ngày cụ thể
        String query = """
            SELECT t.BookingDate, SUM(t.TotalPrice) AS dailyRevenue
            FROM Tickets t
            JOIN Booking_Seats bs ON t.BookingSeatID = bs.BookingSeatID
            JOIN ShowSeats ss ON bs.SeatID = ss.SeatID AND bs.ShowID = ss.ShowID
            WHERE ss.TheatreID = ? AND t.BookingDate = ?
            GROUP BY t.BookingDate
            ORDER BY t.BookingDate ASC
        """;
    
        try (Connection conn = getConnect(); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, cinemaID);
            stmt.setString(2, selectedDate);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Date bookingDate = rs.getDate("BookingDate"); // Convert to Date type
                    double dailyRevenue = rs.getDouble("dailyRevenue");
                    revenueList.add(new Revenue(bookingDate, dailyRevenue));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log lỗi nếu có
        }
        return revenueList;
    }
    
public List<Revenue> getTotalRevenueByTheatre(String theatreID) {
    List<Revenue> revenueList = new ArrayList<>();
    
    // SQL Query để lấy doanh thu tổng cho một rạp cụ thể
    String query = """
        SELECT ss.TheatreID, SUM(t.TotalPrice) AS totalRevenue
        FROM Tickets t
        JOIN Booking_Seats bs ON t.BookingSeatID = bs.BookingSeatID
        JOIN ShowSeats ss ON bs.SeatID = ss.SeatID AND bs.ShowID = ss.ShowID
        WHERE ss.TheatreID = ?
        GROUP BY ss.TheatreID
    """;

    try (Connection conn = getConnect(); 
         PreparedStatement stmt = conn.prepareStatement(query)) {
        stmt.setString(1, theatreID);
        
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                theatreID = rs.getString("TheatreID");
                double totalRevenue = rs.getDouble("totalRevenue");
                revenueList.add(new Revenue(null, totalRevenue)); // Pass null for date
            }
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Log lỗi nếu có
    }
    return revenueList;
}


public static void main(String[] args) {
    String cinemaID = "T00001"; // Thay thế bằng TheatreID thực tế
    String selectedDate = "2024-10-25"; // Thay thế bằng ngày thực tế

    // Khởi tạo đối tượng RevenueDB để gọi phương thức
    RevenueDB revenueDB = new RevenueDB();

    // Gọi phương thức để lấy doanh thu tổng cho rạp chiếu phim
    List<Revenue> totalRevenueList = revenueDB.getTotalRevenueByTheatre(cinemaID);
    System.out.println("Total Revenue for Theatre " + cinemaID + ":");
    for (Revenue revenue : totalRevenueList) {
        System.out.println(revenue);
    }

    // Gọi phương thức để lấy doanh thu hàng ngày cho rạp chiếu phim và ngày
    List<Revenue> dailyRevenueList = revenueDB.getDailyRevenueByCinemaAndDate(cinemaID, selectedDate);
    System.out.println("\nDaily Revenue for Theatre " + cinemaID + " on " + selectedDate + ":");
    for (Revenue revenue : dailyRevenueList) {
        System.out.println(revenue);
    }
}


   
}
