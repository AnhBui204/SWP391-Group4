package Model;

import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.TreeSet;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDB implements DatabaseInfo {

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

    public static User getUsers(String username, String password) {
        User user = null;
        String query = "select UserName, FName , LName, Pass , UserID, Email,Role, Phone, Sex, DateOfBirth, MoneyLeft, Avatar "
                + "from Users where UserName =? and Pass=? ";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // String id = rs.getString("UserId");
                username = rs.getString(1);
                String fName = rs.getString(2);
                String lName = rs.getString(3);
                password = rs.getString(4);
                String id = rs.getString(5);
                String email = rs.getString(6);
                String role = rs.getString(7);
                String phone = rs.getString(8);
                String sex = rs.getString(9);
                String DOB = rs.getString(10);
                String money = rs.getString(11);
                String avatar = rs.getString(12);

                user = new User(id, username, fName, lName, password, email, role, phone, sex, DOB, money, avatar);
            }

        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }
    
    public static User getUsersByID(String userID) {
        User user = null;
        String query = "select UserName, FName , LName, Pass , UserID, Email,Role, Phone, Sex, DateOfBirth, MoneyLeft, Avatar "
                + "from Users where UserID =? ";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // String id = rs.getString("UserId");
                String username = rs.getString(1);
                String fName = rs.getString(2);
                String lName = rs.getString(3);
                String password = rs.getString(4);
                String id = rs.getString(5);
                String email = rs.getString(6);
                String role = rs.getString(7);
                String phone = rs.getString(8);
                String sex = rs.getString(9);
                String DOB = rs.getString(10);
                String money = rs.getString(11);
                String avatar = rs.getString(12);

                user = new User(id, username, fName, lName, password, email, role, phone, sex, DOB, money, avatar);
            }

        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }
//--------------------------------------------------------------------------------------------
    // Phương thức để lấy ID lớn nhất hiện có

    public String getMaxUserId() {
        String maxId = null;
        String query = "SELECT MAX(CAST(SUBSTRING(UserId, 3, LEN(UserId) - 2) AS INT)) AS maxId FROM Users WHERE UserId LIKE 'US%'";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                maxId = rs.getString("maxId");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return maxId;
    }

    // Phương thức để tìm các ID bị thiếu
    public TreeSet<Integer> findMissingIds() {
        TreeSet<Integer> missingIds = new TreeSet<>();
        String query = "SELECT CAST(SUBSTRING(UserId, 3, LEN(UserId) - 2) AS INT) AS numId FROM Users WHERE UserId LIKE 'US%' ORDER BY numId";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            int expectedId = 1;
            while (rs.next()) {
                int actualId = rs.getInt("numId");
                while (expectedId < actualId) {
                    missingIds.add(expectedId);
                    expectedId++;
                }
                expectedId++;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return missingIds;
    }

    // Phương thức để tạo ID mới hoặc lấy lại ID bị thiếu
    public String generateNewUserId() {
        TreeSet<Integer> missingIds = findMissingIds();
        if (!missingIds.isEmpty()) {
            // Lấy ID nhỏ nhất bị thiếu
            int smallestMissingId = missingIds.first();
            return String.format("U%05d", smallestMissingId);
        }

        // Nếu không có ID nào bị thiếu, tạo ID mới dựa trên ID lớn nhất hiện có
        String maxId = getMaxUserId();
        if (maxId == null) {
            return "U00001"; // ID khởi tạo đầu tiên nếu không có bản ghi nào
        }

        // Tăng phần số của ID lên 1
        int numericId = Integer.parseInt(maxId) + 1;
        return String.format("U%05d", numericId);
    }

    // Phương thức để thêm người dùng mới
    public void insert(User user) {
        String newUserId = generateNewUserId();
        user.setUserID(newUserId);
        String sql = "INSERT INTO Users (UserID, UserName, Pass, FName, LName, Role, Email) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, user.getUserID());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getEmail());
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

//-----------------------------------------------------------------------------------
    public static User updateUserProfile(User user) {
        String query = "UPDATE Users SET FName=?, LName=?, email =? , phone=?, sex=? , DOB=? WHERE UserID=?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, user.getfName());
            stmt.setString(2, user.getlName());
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getSex());
            stmt.setString(6, user.getDob());
            stmt.setString(7, user.getUserID());

            int rc = stmt.executeUpdate();
            if (rc == 0) {
                throw new SQLException("Update failed, no rows affected.");
            }
            return user;

        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Invalid data");
        }
    }

    public static ArrayList<User> listAllUsers() {
        ArrayList<User> userList = new ArrayList<>();
        String query = "SELECT UserID, UserName, FName , LName, Pass , Email,Role, Phone, Sex, DateOfBirth, MoneyLeft, Avatar FROM Users";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String userID = rs.getString("UserID");
                String username = rs.getString("UserName");
                String password = rs.getString("Pass");
                String fname = rs.getString("FName");
                String lname = rs.getString("LName");
                String email = rs.getString("Email");
                String role = rs.getString("Role");
                String phone = rs.getString("Phone");
                String sex = rs.getString("Sex");
                String dob = rs.getString("DateOfBirth");
                String money = rs.getString("MoneyLeft");
                String avatar = rs.getString("Avatar");
                // Assuming all are regular users by default

                User user = new User(userID, username, fname, lname, password, email, role, phone, sex, dob, money, avatar);
                userList.add(user);
            }
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userList;
    }

    //Upload Image
    public static void uploadProfileImage(String userID, String avatarPath) {
        String query = "UPDATE Users SET Avatar = ? WHERE UserID = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, avatarPath);  // Save the path instead of a BLOB
            stmt.setString(2, userID);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Avatar path updated successfully.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Failed to upload avatar path.");
        }
    }

    public static String getAvatarByUserID(String userID) {
        String query = "SELECT Avatar FROM Users WHERE UserID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, userID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("Avatar"); // Return the path as a String
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null; // Return null if no avatar found
    }

    public static void main(String[] args) {
//        ArrayList<User> list = UserDB.listAllUsers();
//        for (User user : list) {
//            System.out.println(user);
//        }
        User s = UserDB.getUsers("user2", "123");
        System.out.println(s);
        System.out.println(s.getRole());
        
        User v = UserDB.getUsersByID("U00003");
        System.out.println(v);
    }
}

//--------------------------------------------------------------------------------
//    public static int deleteUser(String userId) {
//        String query = "DELETE FROM Users WHERE UserId=?";
//
//        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
//
//            stmt.setString(1, userId);
//            return stmt.executeUpdate();
//
//        } catch (Exception ex) {
//            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return 0;
//    }
////--------------------------------------------------------------------------------------------
//
//    public static ArrayList<Users> searchUsers(Predicate<Users> p) {
//        ArrayList<Users> list = listAllUsers();
//        ArrayList<Users> res = new ArrayList<>();
//
//        for (Users user : list) {
//            if (p.test(user)) {
//                res.add(user);
//            }
//        }
//        return res;
//    }
//    public static ArrayList<Users> listAllUsers() {
//        ArrayList<Users> list = new ArrayList<>();
//        String query = "SELECT UserId, username, password FROM Users";
//
//        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
//
//            while (rs.next()) {
//                list.add(new Users(
//                        //rs.getString("UserId"),
//                        rs.getString("username"),
//                        rs.getString("password")
//                ));
//            }
//
//        } catch (Exception ex) {
//            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return list;
//    }
////--------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------

