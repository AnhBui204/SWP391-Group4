package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.MovieDB.getConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VoucherDB {

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

    public static String getNextVoucherID() {
        String sql = "SELECT 'V' + RIGHT('00000' + CAST(CAST(SUBSTRING(MAX(VoucherID), 2, 5) AS INT) + 1 AS VARCHAR(5)), 5) AS NextID FROM Vouchers";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("NextID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Nếu không có ID nào trước đó, trả về 'M00001' (ID đầu tiên)
        return "V00001";
    }

    // Create a new voucher
    public static boolean createVoucher(Voucher voucher) {
        String sql = "INSERT INTO Vouchers (VoucherID, VoucherName, TheatreID, ImagePath, ExpiryDate) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            String nextID = getNextVoucherID();
            pstmt.setString(1, nextID);
            pstmt.setString(2, voucher.getVoucherName());
            pstmt.setString(3, voucher.getTheatreID());
            pstmt.setString(4, voucher.getImgPath());
            pstmt.setDate(5, voucher.getExpiryDate());

            return pstmt.executeUpdate() > 0; // return true if the insert was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Read/Get a voucher by voucherID
    public static Voucher getVoucherById(String voucherID) {
        String sql = "SELECT * FROM Vouchers WHERE VoucherID = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, voucherID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new Voucher(
                        rs.getString("VoucherID"),
                        rs.getString("VoucherName"),
                        rs.getString("TheatreID"),
                        rs.getString("ImagePath"),
                        rs.getDate("ExpiryDate")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update a voucher
    public static boolean updateVoucher(Voucher voucher) {
        String sql = "UPDATE Vouchers SET VoucherName = ?, TheatreID = ?, ImagePath = ?, ExpiryDate = ? WHERE VoucherID = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, voucher.getVoucherName());
            pstmt.setString(2, voucher.getTheatreID());
            pstmt.setString(3, voucher.getImgPath());
            pstmt.setDate(4, voucher.getExpiryDate());
            pstmt.setString(5, voucher.getVoucherID());

            return pstmt.executeUpdate() > 0; // return true if the update was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a voucher
    public static boolean deleteVoucher(String voucherID) {
        String sql = "DELETE FROM Vouchers WHERE VoucherID = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, voucherID);
            return pstmt.executeUpdate() > 0; // return true if the deletion was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // List all vouchers
    public static List<Voucher> getAllVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Voucher voucher = new Voucher(
                        rs.getString("VoucherID"),
                        rs.getString("VoucherName"),
                        rs.getString("TheatreID"),
                        rs.getString("ImagePath"),
                        rs.getDate("ExpiryDate")
                );
                vouchers.add(voucher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vouchers;
    }

    public List<Voucher> getVouchersByPage(String theatreID, int page, int vouchersPerPage) {
        List<Voucher> vouchers = new ArrayList<>();
        String query = "SELECT * FROM Vouchers WHERE TheatreID = ? ORDER BY VoucherID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = getConnect().prepareStatement(query);
            ps.setString(1, theatreID);
            ps.setInt(2, (page - 1) * vouchersPerPage); // Tính toán offset
            ps.setInt(3, vouchersPerPage); // Số voucher mỗi trang
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                vouchers.add(new Voucher(rs.getString("VoucherID"), rs.getString("VoucherName"), rs.getString("TheatreID"), rs.getString("ImagePath"), rs.getDate("ExpiryDate")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vouchers;
    }

    public int getTotalVouchersByTheatre(String theatreID) {
        String query = "SELECT COUNT(*) FROM Vouchers WHERE TheatreID = ?";
        try {
            PreparedStatement ps = getConnect().prepareStatement(query);
            ps.setString(1, theatreID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về tổng số voucher
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    //List voucher by theatreID
    public static List<Voucher> getAllVouchersByTheatreID(String theatreID) {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM Vouchers where TheatreID = ?";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, theatreID);
            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    Voucher voucher = new Voucher(
                            rs.getString("VoucherID"),
                            rs.getString("VoucherName"),
                            rs.getString("TheatreID"),
                            rs.getString("ImagePath"),
                            rs.getDate("ExpiryDate")
                    );
                    vouchers.add(voucher);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vouchers;
    }

    public static void uploadPImage(String voucherID, String VcImagePath) {
        String query = "UPDATE Vouchers SET ImagePath = ? WHERE VoucherID = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, VcImagePath);  // Save the path instead of a BLOB
            stmt.setString(2, voucherID);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Image Voucher updated successfully.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Failed to upload image.");
        }
    }

    public static void main(String[] args) {
        // Test getting all vouchers
//        List<Voucher> vouchers = getAllVouchers();
//        for (Voucher voucher : vouchers) {
//            System.out.println(voucher);
//        }
//        String nextId = getNextVoucherID();
//        System.out.println(nextId);
//
        List<Voucher> vouchersID = getAllVouchersByTheatreID("T00001");
        for (Voucher voucher : vouchersID) {
            System.out.println(voucher);
        }

//        VoucherDB voucherDB = new VoucherDB();
//
//        // Giả sử TheatreID là 1 (bạn có thể thay đổi thành TheatreID hợp lệ)
//        String theatreID = "T00001";
//        int page = 1; // Trang hiện tại
//        int vouchersPerPage = 8; // Số lượng voucher mỗi trang
//
//        // Gọi phương thức lấy danh sách voucher theo trang
//        List<Voucher> vouchers = voucherDB.getVouchersByPage(theatreID, page, vouchersPerPage);
//
//        // In ra tổng số voucher của rạp
//        int totalVouchers = voucherDB.getTotalVouchersByTheatre(theatreID);
//        System.out.println("Tổng số voucher: " + totalVouchers);
//
//        // In ra thông tin từng voucher
//        System.out.println("Danh sách voucher ở trang " + page + ":");
//        for (Voucher voucher : vouchers) {
//            System.out.println("VoucherID: " + voucher.getVoucherID());
//            System.out.println("VoucherName: " + voucher.getVoucherName());
//            System.out.println("ExpiryDate: " + voucher.getExpiryDate());
//            System.out.println("ImgPath: " + voucher.getImgPath());
//            System.out.println("-------------------------");
//        }
    }

}
