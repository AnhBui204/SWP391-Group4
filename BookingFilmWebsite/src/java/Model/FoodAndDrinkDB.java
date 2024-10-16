package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.VoucherDB.getConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FoodAndDrinkDB {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Error loading driver: " + e.getMessage(), e);
        } catch (SQLException e) {
            throw new RuntimeException("Error connecting to database: " + e.getMessage(), e);
        }
    }

    public static String getNextComboID() {
        String sql = "SELECT 'C' + RIGHT('00000' + CAST(CAST(SUBSTRING(MAX(ComboID), 2, 5) AS INT) + 1 AS VARCHAR(5)), 5) AS NextID FROM FoodsAndDrinks";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("NextID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Nếu không có ID nào trước đó, trả về 'M00001' (ID đầu tiên)
        return "C00001";
    }
    
    // Create a new combo (food and drink item)
    public static boolean createCombo(FoodAndDrink combo) {
        if (combo == null) {
            throw new IllegalArgumentException("Combo cannot be null.");
        }

        String sql = "INSERT INTO FoodsAndDrinks (ComboID, ComboName, TheatreID, ImagePath, Price) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            String nextID = getNextComboID();
            pstmt.setString(1, nextID);
            pstmt.setString(2, combo.getComboName());
            pstmt.setString(3, combo.getTheatreID()); // Added theatreID
            pstmt.setString(4, combo.getImagePath()); // Added imagePath
            pstmt.setDouble(5, combo.getPrice());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error creating combo: " + e.getMessage(), e);
        }
    }

    // Get combo by ID
    public static FoodAndDrink getComboById(String comboID) {
        String sql = "SELECT * FROM FoodsAndDrinks WHERE ComboID = ?";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, comboID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new FoodAndDrink(
                    rs.getString("ComboID"),
                    rs.getString("ComboName"),
                    rs.getString("TheatreID"), // Added theatreID
                    rs.getString("ImagePath"), // Added imagePath
                    rs.getDouble("Price")
                );
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching combo by ID: " + e.getMessage(), e);
        }
        return null;
    }

    // Update combo
    public static boolean updateCombo(FoodAndDrink combo) {
        if (combo == null) {
            throw new IllegalArgumentException("Combo cannot be null.");
        }

        String sql = "UPDATE FoodsAndDrinks SET ComboName = ?, TheatreID = ?, ImagePath = ?, Price = ? WHERE ComboID = ?";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, combo.getComboName());
            pstmt.setString(2, combo.getTheatreID()); // Added theatreID
            pstmt.setString(3, combo.getImagePath()); // Added imagePath
            pstmt.setDouble(4, combo.getPrice());
            pstmt.setString(5, combo.getComboID());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating combo: " + e.getMessage(), e);
        }
    }

    // Delete combo
    public static boolean deleteCombo(String comboID) {
        String sql = "DELETE FROM FoodsAndDrinks WHERE ComboID = ?";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, comboID);
            System.out.println("Xóa thành công");
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error deleting combo: " + e.getMessage(), e);
        }
    }

    // Get all combos
    public static List<FoodAndDrink> getAllCombos() {
        List<FoodAndDrink> combos = new ArrayList<>();
        String sql = "SELECT * FROM FoodsAndDrinks";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                FoodAndDrink combo = new FoodAndDrink(
                    rs.getString("ComboID"),
                    rs.getString("ComboName"),
                    rs.getString("TheatreID"), // Added theatreID
                    rs.getString("ImagePath"), // Added imagePath
                    rs.getDouble("Price")
                );
                combos.add(combo);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all combos: " + e.getMessage(), e);
        }
        return combos;
    }
    
    //List voucher by theatreID
    public static List<FoodAndDrink> getAllCombosByTheatreID(String theatreID) {
        List<FoodAndDrink> FoodAndDrinks = new ArrayList<>();
        String sql = "SELECT * FROM FoodsAndDrinks where TheatreID = ?";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, theatreID);
            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    FoodAndDrink combo = new FoodAndDrink(
                            rs.getString("ComboID"),
                            rs.getString("ComboName"),
                            rs.getString("TheatreID"),
                            rs.getString("ImagePath"),
                            rs.getDouble("Price")
                    );
                    FoodAndDrinks.add(combo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return FoodAndDrinks;
    }
    
    public static void uploadPImage(String comboID, String CBImagePath) {
        String query = "UPDATE FoodsAndDrinks SET ImagePath = ? WHERE ComboID = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, CBImagePath);  // Save the path instead of a BLOB
            stmt.setString(2, comboID);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Image Combo updated successfully.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Failed to upload image.");
        }
    }

    // Example for testing the functionality
    public static void main(String[] args) {

        // Test getting all combos
        List<FoodAndDrink> combos = getAllCombos();
        for (FoodAndDrink combo : combos) {
            System.out.println(combo);
        }
    }
}
