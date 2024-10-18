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

     public static List<FoodAndDrink> getFoodsAndDrinksByTheatreID(String theatreID) {
        List<FoodAndDrink> foodsAndDrinks = new ArrayList<>();
        String sql = "SELECT ComboID, ComboName, TheatreID, ImagePath, Price FROM FoodsAndDrinks WHERE TheatreID = ?";

        try (Connection conn = getConnect(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            pstmt.setString(1, theatreID);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                String comboID = rs.getString("ComboID");
                String comboName = rs.getString("ComboName");
                String imagePath = rs.getString("ImagePath");
                double price = rs.getDouble("Price");
                foodsAndDrinks.add(new FoodAndDrink(comboID, comboName, theatreID, imagePath, price));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return foodsAndDrinks;
    }
    // Example of how to test in the main method
    public static void main(String[] args) {
         FoodAndDrinkDB foodAndDrinkDB = new FoodAndDrinkDB();
        
        // Giả sử TheatreID bạn muốn tìm kiếm là "TH001"
        String theatreID = "T00001"; 
        List<FoodAndDrink> foodsAndDrinks = foodAndDrinkDB.getFoodsAndDrinksByTheatreID(theatreID);
        
        // In kết quả ra màn hình
        if (foodsAndDrinks.isEmpty()) {
            System.out.println("Không tìm thấy đồ ăn và thức uống nào cho TheatreID: " + theatreID);
        } else {
            System.out.println("Danh sách đồ ăn và thức uống cho TheatreID: " + theatreID);
            for (FoodAndDrink foodAndDrink : foodsAndDrinks) {
                System.out.println("ComboID: " + foodAndDrink.getComboID() +
                                   ", Tên combo: " + foodAndDrink.getComboName() +
                                   ", Giá: " + foodAndDrink.getPrice() +
                                   ", Hình ảnh: " + foodAndDrink.getImagePath());
            }
        }
    }
}
