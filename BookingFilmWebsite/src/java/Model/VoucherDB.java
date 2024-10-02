package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;

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

    // Create a new voucher
    public static boolean createVoucher(Voucher voucher) {
        String sql = "INSERT INTO Vouchers (VoucherID, VoucherName, Price, ExpiryDate) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, voucher.getVoucherID());
            pstmt.setString(2, voucher.getVoucherName());
            pstmt.setDouble(3, voucher.getPrice());
            pstmt.setDate(4, voucher.getExpiryDate());

            return pstmt.executeUpdate() > 0; // return true if the insert was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Read/Get a voucher by voucherID
    public static Voucher getVoucherById(String voucherID) {
        String sql = "SELECT * FROM Vouchers WHERE VoucherID = ?";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, voucherID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new Voucher(
                    rs.getString("VoucherID"),
                    rs.getString("VoucherName"),
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
        String sql = "UPDATE Vouchers SET VoucherName = ?, Price = ?, ExpiryDate = ? WHERE VoucherID = ?";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, voucher.getVoucherName());
            pstmt.setDouble(2, voucher.getPrice());
            pstmt.setDate(3, voucher.getExpiryDate());
            pstmt.setString(4, voucher.getVoucherID());

            return pstmt.executeUpdate() > 0; // return true if the update was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a voucher
    public static boolean deleteVoucher(String voucherID) {
        String sql = "DELETE FROM Vouchers WHERE VoucherID = ?";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

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

        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Voucher voucher = new Voucher(
                    rs.getString("VoucherID"),
                    rs.getString("VoucherName"),
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
    
    // Example of how to test in the main method
    public static void main(String[] args) {
        // Test creating a voucher
        Voucher newVoucher = new Voucher("V001", "Discount 50%", 50.0, Date.valueOf("2024-12-31"));
        if (createVoucher(newVoucher)) {
            System.out.println("Voucher created successfully");
        }

        // Test getting all vouchers
        List<Voucher> vouchers = getAllVouchers();
        for (Voucher voucher : vouchers) {
            System.out.println(voucher);
        }

        // Test updating a voucher
        Voucher updateVoucher = getVoucherById("V001");
        if (updateVoucher != null) {
            updateVoucher.setPrice(60.0);
            if (updateVoucher(updateVoucher)) {
                System.out.println(updateVoucher);
                System.out.println("Voucher updated successfully");
            }
        }

        // Test deleting a voucher
        if (deleteVoucher("V001")) {
            System.out.println("Voucher deleted successfully");
        }
    }
}
