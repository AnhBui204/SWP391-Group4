package Model;

import static Model.MovieDB.getConnect;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
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
        String query = "select UserName, FName , LName, Pass , UserID, Email,Role, Phone, Sex, DateOfBirth, MoneyLeft, Avatar, otp_verified "
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
                Date DOB = rs.getDate(10);
                String money = rs.getString(11);
                String avatar = rs.getString(12);
                Boolean verify = rs.getBoolean("otp_verified");

                user = new User(id, username, fName, lName, password, email, role, phone, sex, DOB, money, avatar, verify);
            }

        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public static BigDecimal getCurrentBalance(String userID) {
        BigDecimal balance = null;
        String sql = "SELECT MoneyLeft FROM Users WHERE userID = ?"; // Thay đổi theo cấu trúc bảng của bạn

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userID);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                balance = rs.getBigDecimal("MoneyLeft");
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi truy vấn số tiền của người dùng: " + e.getMessage());
        }

        return balance;
    }
    
    public void addMoneyToBalance(int amount, String userID) {
        String query = "Update Users set MoneyLeft = MoneyLeft + ? where userID = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, amount);
            ps.setString(2, userID);
            try {
                ps.executeUpdate();
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception err) {
            System.out.println(err);
        }
    }

    public static User getUsersByID(String userID) {
        User user = null;
        String query = "select UserName, FName , LName, Pass , UserID, Email, Role, Phone, Sex, DateOfBirth, MoneyLeft, Avatar "
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
                Date DOB = rs.getDate(10);
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

    // Phương thức để tạo ID mới hoặc lấy lại ID bị thiếu
    public static String getNextUserID() {
        String sql = "SELECT 'U' + RIGHT('00000' + CAST(CAST(SUBSTRING(MAX(UserID), 2, 5) AS INT) + 1 AS VARCHAR(5)), 5) AS NextID FROM Users";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("NextID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Nếu không có ID nào trước đó, trả về 'M00001' (ID đầu tiên)
        return "U00001";
    }

    // Phương thức để thêm người dùng mới
    public boolean insert(User user) {
        String newUserId = getNextUserID();
        user.setUserID(newUserId);
        String sql = "INSERT INTO Users (UserID, UserName, Pass, FName, LName, Email, Phone, Sex, DateOfBirth, Role) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, user.getUserID());
            stmt.setString(2, user.getUsername());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getfName());
            stmt.setString(5, user.getfName());
            stmt.setString(6, user.getEmail());
            stmt.setString(7, user.getPhone());
            stmt.setString(8, user.getSex());
            stmt.setDate(9, user.getDob());
            stmt.setString(10, user.getRole());
            stmt.executeUpdate();
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

//-----------------------------------------------------------------------------------
    public static User updateUserProfile(User user) {
        String query = "UPDATE Users SET FName=?, LName=?, phone=?, sex=?, DateOfBirth=? WHERE UserID=?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, user.getfName());
            stmt.setString(2, user.getlName());
            stmt.setString(3, user.getPhone()); // sửa lại thành setPhone
            stmt.setString(4, user.getSex());
            stmt.setDate(5, user.getDob()); // sửa lại vị trí đúng của Date
            stmt.setString(6, user.getUserID()); // UserID tại vị trí cuối cùng

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

    public static User updatePassword(User user) {
        String query = "UPDATE Users SET Pass = ? WHERE UserID=?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, user.getPassword());
            stmt.setString(2, user.getUserID());

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
                Date dob = rs.getDate("DateOfBirth");
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

    public static void deposit(String userID, int money) {
        String selectQuery = "SELECT moneyleft FROM Users WHERE UserID = ?";
        String updateQuery = "UPDATE Users SET moneyleft = ? WHERE UserID = ?";

        try (Connection con = getConnect(); PreparedStatement selectStmt = con.prepareStatement(selectQuery); PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {

            // Get the current balance
            selectStmt.setString(1, userID);
            ResultSet rs = selectStmt.executeQuery();
            int currentBalance = 0;
            if (rs.next()) {
                currentBalance = rs.getInt("moneyleft");
            }

            // Calculate new balance
            int newBalance = currentBalance + money;

            // Update the balance in the database
            updateStmt.setInt(1, newBalance);
            updateStmt.setString(2, userID);
            int rowsUpdated = updateStmt.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Deposit successfully.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Failed to Deposit.");
        }
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

    public static ArrayList<WorkHistory> listAllWorkHistory(String staffID) {
        ArrayList<WorkHistory> workList = new ArrayList<>();
        String query = "SELECT * FROM WorkHis where StaffID = ?";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, staffID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String workID = rs.getString("WorkId");
                String des = rs.getString("WorkDescription");
                Time time = rs.getTime("Times");
                Date date = rs.getDate("Dates");

                WorkHistory s = new WorkHistory(workID, des, time, date, staffID);
                workList.add(s);
            }
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return workList;
    }

    public static ArrayList<WorkHistory> listWorkHistoryByDate(String staffID, String date) {
        ArrayList<WorkHistory> list = new ArrayList<>();
        // Your database connection logic here

        try {
            String query = "SELECT * FROM WorkHis WHERE StaffID = ? AND Dates = ?";
            PreparedStatement ps = getConnect().prepareStatement(query);
            ps.setString(1, staffID);
            ps.setString(2, date);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                WorkHistory work = new WorkHistory();
                work.setWorkID(rs.getString("WorkID"));
                work.setWorkDes(rs.getString("WorkDescription"));
                work.setDates(rs.getDate("Dates"));
                work.setTimes(rs.getTime("Times"));
                work.setStaffID(rs.getString("StaffID"));
                list.add(work);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close your connection here
        }
        return list;
    }

    //Lấy người dùng theo email
    public User findByEmail(String email) {
        String query = "SELECT * FROM Users WHERE email=?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String username = rs.getString("UserName");
                    String fName = rs.getString("FName");
                    String lName = rs.getString("LName");
                    String password = rs.getString("Pass");
                    String id = rs.getString("UserID");
                    String role = rs.getString("Role");
                    String phone = rs.getString("Phone");
                    String sex = rs.getString("Sex");
                    Date DOB = rs.getDate("DateOfBirth");
                    String money = rs.getString("MoneyLeft");
                    String avatar = rs.getString("Avatar");

                    User user = new User(id, username, fName, lName, password, email, role, phone, sex, DOB, money, avatar);
                    return user;
                }
            }
        } catch (Exception e) {
            
        }
        return null;
    }

    //Phương thức lấy userId user bằng email
    public static String getUserIdByEmail(String email) {
        String userId = ""; // Default value if user_id is not found

        String query = "SELECT userID FROM Users WHERE email = ?";
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getString("userID");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userId;
    }

    public static void main(String[] args) {
//        ArrayList<User> list = UserDB.listAllUsers();
//        for (User user : list) {
//            System.out.println(user);
//        }
        User user = new UserDB().findByEmail("user2@example.com");
        System.out.println(user.toString());
        
        
//
//        String newUserId = getNextUserID();
//        System.out.println(newUserId);
//        User s = UserDB.getUsers("user2", "123");
//        System.out.println(s);
//        System.out.println(s.getRole());
//
//        User v = UserDB.getUsersByID("U00003");
//        System.out.println(v);

//        ArrayList<WorkHistory> list = UserDB.listWorkHistoryByDate("T00001", "2024-10-16");
//        for (WorkHistory s : list) {
//            System.out.println(s);
//        }
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

