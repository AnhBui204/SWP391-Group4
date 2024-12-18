/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

public class BookingDB {

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

    public static boolean insertBooking(String bookingID, String userID, Date bookingDate) {
        String sql = "INSERT INTO Booking (BookingID, UserID, BookingDate) VALUES (?, ?, ?)";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bookingID);
            stmt.setString(2, userID);
            stmt.setTimestamp(3, new java.sql.Timestamp(bookingDate.getTime())); // Đảm bảo sử dụng Timestamp cho DATETIME
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean insertBookingSeats(String bookingID, List<String> seatIDs, String showID, BigDecimal price) {
        String sql = "INSERT INTO Booking_Seats (BookingSeatID, BookingID, SeatID, ShowID, Price) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            conn.setAutoCommit(false); // Tắt chế độ tự động commit

            for (String seatID : seatIDs) {
                String bookingSeatID = generateBookingSeatID(); // Tạo BookingSeatID duy nhất cho mỗi hàng

                stmt.setString(1, bookingSeatID);  // BookingSeatID (mỗi bản ghi phải có một ID duy nhất)
                stmt.setString(2, bookingID);      // BookingID
                stmt.setString(3, seatID);         // SeatID
                stmt.setString(4, showID);         // ShowID
                stmt.setBigDecimal(5, price);      // Price
                stmt.addBatch(); // Thêm vào batch
            }

            int[] result = stmt.executeBatch(); // Thực hiện batch
            conn.commit(); // Commit sau khi chèn thành công

            return result.length == seatIDs.size(); // Kiểm tra nếu số hàng chèn thành công bằng số ghế
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<String> getBookingComboIDs(String bookingID) {
        List<String> comboIDs = new ArrayList<>();
        String sql = "SELECT BookingComboID FROM Booking_Combos WHERE BookingID = ?";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, bookingID); // Set the booking ID parameter

            try (ResultSet rs = pstmt.executeQuery()) {
                // Collect the results
                while (rs.next()) {
                    comboIDs.add(rs.getString("BookingComboID"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exceptions
        }

        return comboIDs; // Return the list of ComboIDs
    }

    public static boolean insertBookingCombos(String bookingID, List<String> comboIDs, List<Integer> quantities, List<BigDecimal> prices) {
        String sql = "INSERT INTO Booking_Combos (BookingComboID, BookingID, ComboID, Quantity, Price) VALUES (?, ?, ?, ?, ?)";
        int addedCount = 0; // Biến đếm số lượng combo hợp lệ đã thêm
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Tắt tự động commit để quản lý transaction
            conn.setAutoCommit(false);
            for (int i = 0; i < comboIDs.size(); i++) {
                String comboID = comboIDs.get(i);
                int quantity = quantities.get(i);
                BigDecimal price = prices.get(i);

                // Kiểm tra nếu comboID không phải NULL và quantity > 0
                if (comboID != null && !comboID.isEmpty() && quantity > 0) {
                    // Tạo BookingComboID (có thể tùy chỉnh logic tạo ID)
                    String bookingComboID = generateBookingComboID();

                    stmt.setString(1, bookingComboID); // BookingComboID (unique ID cho mỗi bản ghi)
                    stmt.setString(2, bookingID);      // BookingID
                    stmt.setString(3, comboID);        // ComboID (NOT NULL)
                    stmt.setInt(4, quantity);          // Quantity
                    stmt.setBigDecimal(5, price);      // Price
                    stmt.addBatch(); // Thêm vào batch
                    addedCount++; // Tăng biến đếm
                }
            }

            // Thực hiện batch insert nếu có combo hợp lệ
            if (addedCount > 0) {
                int[] result = stmt.executeBatch(); // Thực hiện batch insert
                conn.commit(); // Commit nếu thành công
                return result.length == addedCount; // Kiểm tra nếu tất cả các dòng đã được chèn
            } else {
                System.out.println("Không có combo nào hợp lệ để chèn.");
                return true; // Không có combo nào để chèn, coi như thành công
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean bookTicket(String bookingID, String userID, String seatNames, String showID, String showDate, String startTime, List<String> comboIDs, List<Integer> quantities, Date bookingDate, String theatreID) {
        boolean success = true;

        // Khởi tạo kết nối và bắt đầu transaction
        try (Connection conn = getConnect()) {
            conn.setAutoCommit(false);

            // Bước 1: Chèn vào bảng Booking
            success &= insertBooking(bookingID, userID, bookingDate);
            if (!success) {
                conn.rollback();
                System.out.println("Insert Booking failed.");
                return false;
            }

            // Bước 2: Lấy RoomID từ SeatNames, ShowDate và StartTime
            String roomID = RoomDB.getRoomIdBySeatNamesAndShowDateAndTime(seatNames, showDate, startTime, theatreID);
            if (roomID == null) {
                conn.rollback();
                System.out.println("RoomID không tồn tại.");
                return false;
            }

            // Bước 3: Lấy danh sách SeatID từ danh sách seatNames
            List<String> seatIDs = SeatDB.getSeatIDsFromNames(seatNames, roomID);
            if (seatIDs.isEmpty()) {
                conn.rollback();
                System.out.println("SeatIDs không tồn tại.");
                return false;
            }

            // Bước 4: Chèn vào bảng Booking_Seats
            List<String> bookingSeatIDs = new ArrayList<>();
            for (String seatID : seatIDs) {
                BigDecimal seatPrice = getSeatPrice(seatID);
                if (seatPrice == null) {
                    conn.rollback();
                    System.out.println("Giá của ghế " + seatID + " không tìm thấy.");
                    return false;
                }
                // Thực hiện chèn và lưu ID ghế
                success &= insertBookingSeats(bookingID, Arrays.asList(seatID), showID, seatPrice);
                if (!success) {
                    conn.rollback();
                    System.out.println("Insert Booking_Seats failed.");
                    return false;
                }
                bookingSeatIDs.add(seatID); // Lưu lại SeatID
                success &= ShowSeatDB.updateSeatAvailability(seatID, false);
            }
            // Bước 5: Chèn vào bảng Booking_Combos
            List<String> bookingComboIDs = new ArrayList<>();
            if (comboIDs != null && !comboIDs.isEmpty()) {
                List<BigDecimal> comboPrices = getComboPrices(comboIDs);
                if (comboPrices.isEmpty()) {
                    conn.rollback();
                    System.out.println("Combo giá không tìm thấy.");
                    return false;
                }
                success &= insertBookingCombos(bookingID, comboIDs, quantities, comboPrices);
                if (!success) {
                    conn.rollback();
                    System.out.println("Insert Booking_Combos failed.");
                    return false;
                }
                // Lưu ID combo (giả định là comboIDs có cùng kích thước với quantities)
                bookingComboIDs.addAll(comboIDs);
            }
            // Commit nếu thành công
            conn.commit();
            System.out.println("Transaction committed successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            success = false;
        }

        return success;
    }

    public static List<String> getBookingSeatIDsByBookingID(String bookingID) {
        List<String> seatIDs = new ArrayList<>();
        String sql = "SELECT BookingSeatID FROM Booking_Seats WHERE BookingID = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, bookingID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String seatID = rs.getString("BookingSeatID");
                seatIDs.add(seatID);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return seatIDs;
    }

    public static BigDecimal getSeatPrice(String seatID) {
        BigDecimal seatPrice = null; // Biến để lưu giá của ghế

        // Bước 1: Tạo câu lệnh SQL để lấy Price từ bảng ShowSeats dựa trên SeatID
        String Sql = "SELECT Price FROM ShowSeats WHERE SeatID = ?";

        // Bước 2: Thực hiện truy vấn SQL
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(Sql)) {
            // Thiết lập giá trị cho tham số dấu ? trong câu truy vấn
            stmt.setString(1, seatID); // Đặt seatID vào truy vấn

            // Thực hiện truy vấn
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                seatPrice = rs.getBigDecimal("Price"); // Lấy giá trị của cột Price
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Trả về giá ghế, hoặc trả về BigDecimal.ZERO nếu không tìm thấy
        return seatPrice != null ? seatPrice : BigDecimal.ZERO;
    }

    public static List<BigDecimal> getComboPrices(List<String> comboIDs) {
        List<BigDecimal> prices = new ArrayList<>();
        String sql = "SELECT Price FROM FoodsAndDrinks WHERE ComboID = ?";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (String comboID : comboIDs) {
                if (comboID != null) {
                    stmt.setString(1, comboID);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            prices.add(rs.getBigDecimal("Price"));
                        } else {
                            prices.add(BigDecimal.ZERO); // Trả về 0 nếu không tìm thấy
                        }
                    }
                } else {
                    prices.add(BigDecimal.ZERO); // Trả về 0 nếu comboID là null
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            for (int i = prices.size(); i < comboIDs.size(); i++) {
                prices.add(BigDecimal.ZERO); // Trả về 0 cho các giá trị chưa có nếu xảy ra lỗi
            }
        }

        return prices;
    }

    public static BigDecimal calculateTotalPrice(String seatID, List<String> bookingComboIDs) {
        BigDecimal seatPrice = getSeatPrice(seatID); // Lấy giá ghế
        BigDecimal totalComboPrice = BigDecimal.ZERO; // Khởi tạo tổng giá combo

        // Duyệt qua danh sách bookingComboIDs để tính tổng giá
        for (String comboID : bookingComboIDs) {
            BigDecimal comboPrice = getComboPrices(Arrays.asList(comboID)).get(0); // Lấy giá của combo
            totalComboPrice = totalComboPrice.add(comboPrice); // Cộng giá combo vào tổng
        }

        return seatPrice.add(totalComboPrice);
    }

    public static String generateBookingID() {
        String sql = "SELECT MAX(BookingID) AS MAXID FROM BOOKING";
        String newID = "B00001"; // Giá trị mặc định nếu không có BookingID nào

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String maxID = rs.getString("MAXID"); // Sửa thành "MAXID" để khớp với alias
                if (maxID != null) {
                    // Xóa ký tự "B" và khoảng trắng
                    String numericPart = maxID.replace("B", "").trim();

                    // Kiểm tra xem phần số có hợp lệ không
                    if (!numericPart.isEmpty()) {
                        // Chuyển đổi sang số nguyên
                        int idNumber = Integer.parseInt(numericPart) + 1;
                        // Tạo ID mới với định dạng "Bxxxx"
                        newID = String.format("B%05d", idNumber); // Đảm bảo 5 chữ số
                    } else {
                        System.out.println("Lỗi: maxID không hợp lệ, không thể chuyển đổi.");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NumberFormatException e) {
            System.out.println("Lỗi: Không thể chuyển đổi maxID thành số: " + e.getMessage());
        }

        return newID;
    }

    public static boolean comboExists(String bookingID, String comboID) {
        String sql = "SELECT COUNT(*) FROM Booking_Combos WHERE BookingID = ? AND ComboID = ?";
        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bookingID);
            stmt.setString(2, comboID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu tồn tại
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Trả về false nếu không tồn tại
    }

    public static String generateBookingComboID() {
        String newID = null;
        boolean unique = false;

        while (!unique) {
            String sql = "SELECT COUNT(*) AS COUNT FROM BOOKING_Combos WHERE BookingComboID = ?";

            // Tạo ID mới
            int randomNumber = (int) (Math.random() * 10000); // Tạo số ngẫu nhiên từ 0 đến 9999
            newID = String.format("BC%04d", randomNumber);

            try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setString(1, newID);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    int count = rs.getInt("COUNT");
                    unique = (count == 0); // Nếu không có bản ghi nào với ID này, thì unique
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return newID;
    }

    public static String generateBookingSeatID() {
        String sql = "SELECT MAX(BookingSeatID) AS MAXID FROM BOOKING_Seats";
        String newID = "BS0001";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String maxID = rs.getString("MaxID");
                if (maxID != null) {
                    int idNumber = Integer.parseInt(maxID.replace("BS", "").trim()) + 1;
                    newID = String.format("BS%04d", idNumber);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newID;
    }

    public static String generateTicketID(String maxTicketID) {
        String newID = "TK0001";
        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement("SELECT MAX(TicketID) AS MAXID FROM Tickets")) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String maxID = rs.getString("MaxID");
                if (maxID != null) {
                    int idNumber = Integer.parseInt(maxID.replace("TK", "").trim()) + 1;
                    newID = String.format("TK%04d", idNumber);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return newID;
    }

    public static List<String> getComboIDsByNames(List<String> comboNames, String theatreID) {
        List<String> comboIDs = new ArrayList<>();

        // Prepare SQL with IN clause for multiple names
        String sql = "SELECT ComboID FROM FoodsAndDrinks WHERE ComboName IN (";

        // Append placeholders for each comboName
        for (int i = 0; i < comboNames.size(); i++) {
            sql += "?";
            if (i < comboNames.size() - 1) {
                sql += ",";
            }
        }
        sql += ") And theatreID = ?";

        // Try-with-resources to ensure resources are closed
        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set the values for the placeholders
            for (int i = 0; i < comboNames.size(); i++) {
                pstmt.setString(i + 1, comboNames.get(i));
            }
            pstmt.setString(comboNames.size() + 1, theatreID);

            ResultSet rs = pstmt.executeQuery();

            // Collect the results
            while (rs.next()) {
                comboIDs.add(rs.getString("ComboID"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle SQL exceptions
        }

        return comboIDs; // Return the list of ComboIDs
    }

    public static void insertTickets(String userID, String bookingID, List<String> bookingSeatIDs, String roomID, List<String> bookingComboIDs, BigDecimal totalPrices, Date bookingDate) {
        String sql = "INSERT INTO Tickets (TicketID, UserID, BookingID, BookingSeatID, RoomID, BookingComboID, TotalPrice, BookingDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnect(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            // Get the maximum existing TicketID
            String maxTicketID = getMaxTicketID(conn); // Retrieve the max Ticket ID from the database
            int ticketCount = 0; // Start count for unique Ticket ID generation
            int batchSize = 1000; // Set a batch size limit

            // Create a unique TicketID for each seat and insert information for each ticket
            for (int i = 0; i < bookingSeatIDs.size(); i++) {
                // Generate a unique TicketID for each seat
                String currentTicketID = generateTicketID(maxTicketID, ticketCount); // Generate based on max ID and increment count

                stmt.setString(1, currentTicketID); // Set the unique TicketID for each ticket
                stmt.setString(2, userID); // UserID            
                stmt.setString(3, bookingID); // BookingID
                stmt.setString(4, bookingSeatIDs.get(i)); // BookingSeatID
                stmt.setString(5, roomID); // RoomID
                stmt.setString(6, (i < bookingComboIDs.size()) ? bookingComboIDs.get(i) : null); // BookingComboID (could be NULL)
                stmt.setBigDecimal(7, totalPrices); // TotalPrice
                stmt.setDate(8, new java.sql.Date(bookingDate.getTime())); // BookingDate

                stmt.addBatch(); // Add to batch

                ticketCount++; // Increment the ticket count for the next unique TicketID

                // Execute the batch periodically
                if (i > 0 && i % batchSize == 0) {
                    stmt.executeBatch(); // Execute batch insert
                }
            }

            stmt.executeBatch(); // Execute any remaining inserts
        } catch (SQLException e) {
            // Consider logging the exception or rethrowing it
            e.printStackTrace();
        }
    }

    public static String generateTicketID(String maxTicketID, int ticketCount) {
        String newID = "TK0001"; // Default ID if maxID is null
        if (maxTicketID != null) {
            int idNumber = Integer.parseInt(maxTicketID.replace("TK", "").trim()) + ticketCount + 1; // Increment based on current count
            newID = String.format("TK%04d", idNumber); // Format ID with leading zeros
        } else {
            // If no existing TicketID, just use the starting ID.
            newID = String.format("TK%04d", ticketCount + 1); // Starting ID with the ticket count
        }
        return newID;
    }

    public static String getMaxTicketID(Connection conn) {
        String sql = "SELECT MAX(TicketID) AS MAXID FROM Tickets";
        String maxID = null; // Initialize to null

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                maxID = rs.getString("MAXID"); // Get the maximum TicketID
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions appropriately
        }

        return maxID; // Return the maximum TicketID found, or null if none exists
    }

    public static String deductMoneyLeft(String userID, BigDecimal totalPrice) {
        String queryCheckBalance = "SELECT MoneyLeft FROM Users WHERE UserID = ?";
        String queryUpdateBalance = "UPDATE Users SET MoneyLeft = MoneyLeft - ? WHERE UserID = ?";

        try (
                Connection conn = getConnect(); PreparedStatement checkStmt = conn.prepareStatement(queryCheckBalance); PreparedStatement updateStmt = conn.prepareStatement(queryUpdateBalance)) {

            // Check current MoneyLeft
            checkStmt.setString(1, userID);
            ResultSet resultSet = checkStmt.executeQuery();

            if (resultSet.next()) {
                BigDecimal moneyLeft = resultSet.getBigDecimal("MoneyLeft");

                // Check if sufficient funds are available
                if (moneyLeft.compareTo(totalPrice) >= 0) {
                    // Deduct the money
                    updateStmt.setBigDecimal(1, totalPrice);
                    updateStmt.setString(2, userID);
                    updateStmt.executeUpdate();

                    return "Transaction successful. Money deducted.";
                } else {
                    return "Insufficient funds.";
                }
            } else {
                return "User not found.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return "An error occurred while processing the transaction.";
        }
    }

    public static List<BookingInfo> getBookingDetailsByUserID(String userID) throws SQLException {
        List<BookingInfo> bookingDetails = new ArrayList<>();
        String query = "SELECT DISTINCT b.BookingID, b.BookingDate, b.Status, t.TotalPrice "
                + "FROM Booking b "
                + "JOIN Tickets t ON b.BookingID = t.BookingID "
                + "WHERE b.UserID = ?";

        try (Connection conn = getConnect(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, userID);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String bookingID = rs.getString("BookingID");
                    String bookingDate = rs.getString("BookingDate");
                    String status = rs.getString("Status");
                    double totalPrice = rs.getDouble("TotalPrice");
                    BookingInfo info = new BookingInfo(bookingID, bookingDate, totalPrice, status);
                    bookingDetails.add(info);
                }
            }
        }

        return bookingDetails;
    }

    public static void main(String[] args) {
        String userID = "U00003"; // Thay thế bằng UserID thực tế bạn muốn tìm
        try {
            List<BookingInfo> bookingDetails = getBookingDetailsByUserID(userID);
            for (BookingInfo info : bookingDetails) {
                System.out.println(info);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
//
//   public static void main(String[] args) {
//        // Dữ liệu mẫu để chèn vào bảng Tickets
//        String userID = "U00003"; // ID người dùng
//        String bookingID = "B00001"; // ID đặt chỗ
//        String roomID = "R00001"; // ID phòng
//        
//        // Danh sách ghế đã đặt
//        List<String> bookingSeatIDs = new ArrayList<>();
//        bookingSeatIDs.add("BS0001");
//        bookingSeatIDs.add("BS0002");
//        bookingSeatIDs.add("BS0003");
//
//        // Danh sách combo đã đặt
//        List<String> bookingComboIDs = new ArrayList<>();
//        bookingComboIDs.add("BC5463");
//        bookingComboIDs.add("BC8984"); // Cần nhiều hơn số ghế nếu có
//
//        // Danh sách tổng giá cho từng vé
//        List<BigDecimal> totalPrices = new ArrayList<>();
//        totalPrices.add(new BigDecimal("15.00"));
//        totalPrices.add(new BigDecimal("20.00"));
//        totalPrices.add(new BigDecimal("10.00"));
//
//        // Ngày đặt
//        Date bookingDate = new Date(); // Lấy ngày hiện tại
//
//        // Gọi phương thức insertTickets
//        insertTickets(userID, bookingID, bookingSeatIDs, roomID, bookingComboIDs, totalPrices, bookingDate);
//    }

}
//boolean result = insertBookingCombos("B00001", null, 0, new BigDecimal("10.00"));
//if (result) {
//    System.out.println("Chèn thành công.");
//} else {
//    System.out.println("Chèn không thành công.");
//}
//    }

// BookingID cần thiết để kiểm tra
//        String bookingID = "B00001";
//
//        // Danh sách combo trống (không mua combo nào)
//        List<String> comboIDs = new ArrayList<>();
//        List<Integer> quantities = new ArrayList<>();
//        List<BigDecimal> prices = new ArrayList<>();
//
//        // Gọi method insertBookingCombos với danh sách trống
//        boolean success = insertBookingCombos(bookingID, comboIDs, quantities, prices);
//
//        // Kiểm tra kết quả
//        if (success) {
//            System.out.println("Insert thành công (không có combo nào được mua).");
//        } else {
//            System.out.println("Insert thất bại.");
//        }
//    }

