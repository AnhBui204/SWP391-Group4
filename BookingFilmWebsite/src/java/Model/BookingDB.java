/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ANH BUI
 */
public class BookingDB {
    
}
<<<<<<< Updated upstream
=======

public static String generateBookingSeatID(){
    String sql = "SELECT MAX(BookingSeatID) AS MAXID FROM BOOKING_Seats";
    String newID = "BS0001";
    try(Connection con = getConnect();
        PreparedStatement stmt = con.prepareStatement(sql)){
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
            String maxID = rs.getString("MaxID");
            if(maxID != null){
                  int idNumber = Integer.parseInt(maxID.replace("BS", "").trim()) + 1;
                newID = String.format("BS%04d", idNumber);
            }
        }
    }catch(SQLException e){
        e.printStackTrace();
    }
    return newID;          
}
public static String generateTicketID(String maxTicketID) {
    String newID = "TK0001";
    try (Connection con = getConnect();
         PreparedStatement stmt = con.prepareStatement("SELECT MAX(TicketID) AS MAXID FROM Tickets")) {
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

 public static List<String> getComboIDsByNames(List<String> comboNames) {
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
        sql += ")";

        // Try-with-resources to ensure resources are closed
        try (Connection conn =getConnect();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
             
            // Set the values for the placeholders
            for (int i = 0; i < comboNames.size(); i++) {
                pstmt.setString(i + 1, comboNames.get(i));
            }
            
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

public static void insertTickets(String userID, String bookingID, List<String> bookingSeatIDs, String roomID, List<String> bookingComboIDs, List<BigDecimal> totalPrices, Date bookingDate) {
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
            stmt.setBigDecimal(7, totalPrices.get(i)); // TotalPrice
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
                Connection conn = getConnect();
                PreparedStatement checkStmt = conn.prepareStatement(queryCheckBalance);
             PreparedStatement updateStmt = conn.prepareStatement(queryUpdateBalance)) {

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
        String query = "SELECT BookingID, BookingDate, TotalPrice FROM Tickets WHERE UserID = ?";
       
        try (Connection conn = getConnect();
                PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, userID);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    String bookingID = rs.getString("BookingID");
                    String bookingDate = rs.getString("BookingDate");
                    double totalPrice = rs.getDouble("TotalPrice");

                    // Assuming BookingInfo is a POJO to hold booking details
                    BookingInfo info = new BookingInfo(bookingID, bookingDate, totalPrice);
                    bookingDetails.add(info);
                }
            }
        }

        return bookingDetails;
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
  public static void main(String[] args) {
        // Prepare a list of combo names to retrieve their IDs
        List<String> comboNames = Arrays.asList("Bắp rang + Nước ngọt", "Bắp rang + 2 Nước ngọt"); // Thay thế bằng các tên combo thực tế của bạn

        // Call the method to get combo IDs
        List<String> comboIDs = BookingDB.getComboIDsByNames(comboNames);

        // Print the retrieved combo IDs
        System.out.println("Retrieved Combo IDs: " + comboIDs);
    }
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




   
>>>>>>> Stashed changes
