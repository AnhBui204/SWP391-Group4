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
        String sql = "INSERT INTO Vouchers (VoucherID, VoucherName, TheatreID, ImagePath, Price, ExpiryDate) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            String nextID = getNextVoucherID();
            pstmt.setString(1, nextID);
            pstmt.setString(2, voucher.getVoucherName());
            pstmt.setString(3, voucher.getTheatreID());
            pstmt.setString(4, voucher.getImgPath());
            pstmt.setDouble(5, voucher.getPrice());
            pstmt.setDate(6, voucher.getExpiryDate());

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
                        rs.getDouble("Price"),
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
        String sql = "UPDATE Vouchers SET VoucherName = ?, TheatreID = ?, ImagePath = ?, Price = ?, ExpiryDate = ? WHERE VoucherID = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, voucher.getVoucherName());
            pstmt.setString(2, voucher.getTheatreID());
            pstmt.setString(3, voucher.getImgPath());
            pstmt.setDouble(4, voucher.getPrice());
            pstmt.setDate(5, voucher.getExpiryDate());
            pstmt.setString(6, voucher.getVoucherID());

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
                        rs.getDouble("Price"),
                        rs.getDate("ExpiryDate")
                );
                vouchers.add(voucher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vouchers;
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
                            rs.getDouble("Price"),
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
        
        List<Voucher> vouchersID = getAllVouchersByTheatreID("T00001");
        for (Voucher voucher : vouchersID) {
            System.out.println(voucher);
        }
    }
}
