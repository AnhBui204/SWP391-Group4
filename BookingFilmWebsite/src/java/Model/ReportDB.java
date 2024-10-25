/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.MovieDB.getConnect;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


public class ReportDB {
       private static final ReportDB reportDB = new ReportDB(); 
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
     public static boolean insertReport(String reportTitle, String reportDescription, java.util.Date timeCreate, String userId) {

    String sql = "INSERT INTO Report (ReportId, ReportTitle, ReportDescription, TimeCreate, UserId) VALUES (?, ?, ?, ?, ?)";
    String reportId = getNextReportID();
    try (Connection conn = getConnect();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
         
        // Chuyển đổi java.util.Date thành java.sql.Date
        java.sql.Date sqlDate = new java.sql.Date(timeCreate.getTime());

        // Thiết lập giá trị cho PreparedStatement
        pstmt.setString(1, reportId);
        pstmt.setString(2, reportTitle);
        pstmt.setString(3, reportDescription);
        pstmt.setDate(4, sqlDate);
        pstmt.setString(5, userId);
        
        // Thực hiện câu lệnh chèn
        int rowsInserted = pstmt.executeUpdate();
       if(rowsInserted>0){
           return true;
       }
    } catch (SQLException e) {
        e.printStackTrace(); // Xử lý lỗi
    }
    return false; // Trả về false nếu có lỗi xảy ra
}
   public static String getNextReportID() {
        String sql = "SELECT 'RP' + RIGHT('000' + CAST(CAST(SUBSTRING(MAX(ReportID), 3, 5) AS INT) + 1 AS VARCHAR(5)), 5) AS NextID FROM Report";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("NextID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Nếu không có ID nào trước đó, trả về 'M00001' (ID đầu tiên)
        return "RP0001";
    }
   
   
public List<Report> getReportHistory(String userID) {
    List<Report> reports = new ArrayList<>();
    String query = "SELECT reportId, reportTitle, reportDescription, userId, TimeCreate FROM Report WHERE userId = ? ORDER BY TimeCreate DESC";

    try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(query)) {
        stmt.setString(1, userID);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            String reportId = rs.getString("reportId");
            String reportTitle = rs.getString("reportTitle"); 
            String reportDescription = rs.getString("reportDescription"); 
            String userId = rs.getString("userId");
            java.sql.Date timeCreate = rs.getDate("TimeCreate"); 
            reports.add(new Report(reportId, reportTitle, reportDescription, userId, timeCreate));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return reports;
}

     public List<Report> listAllReports() {
    List<Report> reports = new ArrayList<>();

    String sql = "SELECT reportId, reportTitle, reportDescription, userId, timeCreate FROM Report"; // Giả định bảng tên là 'Report'

    try (Connection conn = getConnect();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ResultSet rs = ps.executeQuery();

        // Duyệt qua kết quả và thêm vào danh sách báo cáo
        while (rs.next()) {
            String reportId = rs.getString("reportId");
            String reportTitle = rs.getString("reportTitle");
            String reportDescription = rs.getString("reportDescription");
            String userId = rs.getString("userId");
            java.sql.Date timeCreate = rs.getDate("timeCreate"); // Lấy ngày tháng năm từ DB

            // Tạo đối tượng Report và thêm vào danh sách
            Report report = new Report(reportId, reportTitle, reportDescription, userId, timeCreate);
            reports.add(report);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return reports;
}


public List<Report> getReportsByUserId(String userId) {
    List<Report> reports = new ArrayList<>();
    String sql = "SELECT ReportId, ReportTitle, ReportDescription, TimeCreate, UserId FROM Report WHERE UserId = ?";

    try (Connection conn = getConnect();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
              
        pstmt.setString(1, userId);
        
      
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            String reportId = rs.getString("ReportId");
            String reportTitle = rs.getString("ReportTitle");
            String reportDescription = rs.getString("ReportDescription");
            Date timeCreate = rs.getDate("TimeCreate");
            String retrievedUserId = rs.getString("UserId");

            reports.add(new Report(reportId, reportTitle, reportDescription, retrievedUserId, (java.sql.Date) timeCreate));
        }
    } catch (SQLException e) {
        System.err.println("Lỗi SQL: " + e.getMessage());
        e.printStackTrace();
    } catch (IllegalArgumentException e) {
        System.err.println("Lỗi tham số: " + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    return reports;
}
public Report getReportById(String reportId) {
    Report report = null;
    String sql = "SELECT reportId, reportTitle, reportDescription, userId, timeCreate FROM Report WHERE reportId = ?";
    
    try (Connection conn = getConnect();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setString(1, reportId);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            String reportTitle = rs.getString("reportTitle");
            String reportDescription = rs.getString("reportDescription");
            String userId = rs.getString("userId");
            java.sql.Date timeCreate = rs.getDate("timeCreate");
            
            report = new Report(reportId, reportTitle, reportDescription, userId, timeCreate);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return report;
}
public boolean deleteReport(String reportId) {
    String sql = "DELETE FROM Report WHERE reportId = ?";

    try (Connection conn = getConnect();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, reportId);
        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0; // Trả về true nếu có ít nhất 1 hàng bị xóa
    } catch (SQLException e) {
        e.printStackTrace();
        return false; // Xử lý lỗi
    }
}


public static void main(String[] args) {
       ReportDB reportDB = new ReportDB();

        // Example data
        String reportTitle = "Monthly Report";
        String reportDescription = "This is the monthly financial report.";
        java.util.Date timeCreate = Calendar.getInstance().getTime(); // Current date/time
        String userId = "U00003";

        // Call insertReport and display result
        boolean result = insertReport(reportTitle, reportDescription, timeCreate, userId);
        if (result) {
            System.out.println("Report inserted successfully.");
        } else {
            System.out.println("Failed to insert report.");
        }

        String id = getNextReportID();
        System.out.println(id);
        
        List<Report> list = reportDB.listAllReports();
        for(Report s : list){
            System.out.println(s);
        }
    }

}

