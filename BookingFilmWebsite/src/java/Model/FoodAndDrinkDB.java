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

public class FoodAndDrinkDB {

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
    public static boolean createCombo(FoodAndDrink combo) {
        String sql = "INSERT INTO FoodsAndDrinks (ComboID, ComboName, Price) VALUES (?, ?, ?)";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, combo.getComboID());
            pstmt.setString(2, combo.getComboName());
            pstmt.setDouble(3, combo.getPrice());

            return pstmt.executeUpdate() > 0; // return true if the insert was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Read/Get a voucher by voucherID
    public static FoodAndDrink getComboById(String ComboID) {
        String sql = "SELECT * FROM FoodsAndDrinks WHERE ComboID = ?";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, ComboID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new FoodAndDrink(
                    rs.getString("ComboID"),
                    rs.getString("ComboName"),
                    rs.getDouble("Price")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update a combo
    public static boolean updateCombo(FoodAndDrink combo) {
        String sql = "UPDATE FoodsAndDrinks SET ComboName = ?, Price = ? WHERE ComboID = ?";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, combo.getComboName());
            pstmt.setDouble(2, combo.getPrice());
            pstmt.setString(3, combo.getComboID());

            return pstmt.executeUpdate() > 0; // return true if the update was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a voucher
    public static boolean deleteCombo(String comboID) {
        String sql = "DELETE FROM FoodsAndDrinks WHERE ComboID = ?";
        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, comboID);
            return pstmt.executeUpdate() > 0; // return true if the deletion was successful
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<FoodAndDrink> getAllCombo() {
        List<FoodAndDrink> combos = new ArrayList<>();
        String sql = "SELECT * FROM FoodsAndDrinks";

        try (Connection conn = getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                FoodAndDrink combo = new FoodAndDrink(
                    rs.getString("ComboID"),
                    rs.getString("ComboName"),
                    rs.getDouble("Price")
                );
                combos.add(combo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return combos;
    }
    
    // Example of how to test in the main method
    public static void main(String[] args) {
        // Test creating a voucher
        FoodAndDrink newCombo = new FoodAndDrink("C12345", "Bắp rang big size + Pepsi bigsize", 150000.0);
        if (createCombo(newCombo)) {
            System.out.println("Combo created successfully");
        }

        // Test getting all vouchers
        List<FoodAndDrink> combos = getAllCombo();
        for (FoodAndDrink combo : combos) {
            System.out.println(combo);
        }

        // Test updating a voucher
        FoodAndDrink updatedCombo = getComboById("C12345");
        if (updatedCombo != null) {
            updatedCombo.setPrice(160.0);
            if (updateCombo(updatedCombo)) {
                System.out.println(updatedCombo);
                System.out.println("Combo updated successfully");
            }
        }

        // Test deleting a voucher
        if (deleteCombo("C12345")) {
            System.out.println("Voucher deleted successfully");
        }
    }
}
