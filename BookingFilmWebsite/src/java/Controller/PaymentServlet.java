
package Controller;
import Model.FoodItem;
import Model.BookingDB;
import Model.RoomDB;
import Model.SeatDB;
import Model.ShowDB;
import Model.UserDB;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author ADMIN
 */
public class PaymentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PaymentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
 protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve selected seats
        String[] seatNamesArray = request.getParameterValues("selectedSeats");
        String seatNames = (seatNamesArray != null) ? String.join(", ", seatNamesArray) : "";

        // Retrieve total price
        String priceString = request.getParameter("totalPrice");
        BigDecimal totalPrice = null;

        if (priceString != null && !priceString.isEmpty()) {
            try {
                totalPrice = new BigDecimal(priceString.trim());
            } catch (NumberFormatException e) {
                System.out.println("Không thể chuyển đổi giá trị: " + priceString);
            }
        }

        // Retrieve show date and time
        String showDate = request.getParameter("selectedDate");
        String startTime = request.getParameter("selectedTime");
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("id");

        // Retrieve selected food data
        String selectedFoodData = request.getParameter("selectedFood");
       // Initialize the list to hold FoodItem objects
List<FoodItem> foodItems = new ArrayList<>();

// Assuming selectedFoodData is the JSON string containing food information
JSONArray foodArray = new JSONArray(selectedFoodData); // Use org.json.JSONArray

// Loop through each food item in the JSON array
for (int i = 0; i < foodArray.length(); i++) {
    JSONObject foodItem = foodArray.getJSONObject(i);

    // Get the food name(s) and quantity
    String foodName = foodItem.getString("name");
    int quantity = Integer.parseInt(foodItem.getString("quantity")); // Convert to integer

    // Assuming foodName is a single name for now; modify if it can be multiple
    List<String> namesList = new ArrayList<>();
    namesList.add(foodName); // Add the food name to the list

    // Add the food item to the list
    foodItems.add(new FoodItem(namesList, quantity));
}

// Initialize lists to hold combo IDs, quantities, and food names
// Initialize lists to hold combo IDs, quantities, and food names
List<String> allComboIDs = new ArrayList<>();
List<Integer> allQuantities = new ArrayList<>();
List<List<String>> allFoodNames = new ArrayList<>();

for (FoodItem item : foodItems) {
    // Get the list of names from the food item
    List<String> foodNames = item.getNames();

    // Trim each food name to remove any leading/trailing spaces
    List<String> trimmedFoodNames = foodNames.stream()
        .map(String::trim) // Trim each food name
        .collect(Collectors.toList());

    // Add the current food names to the allFoodNames list
    allFoodNames.add(trimmedFoodNames); // Store the trimmed food names in the overall list

    // Log the trimmed food names (optional, for debugging)
    System.out.println("Trimmed Food Names: " + trimmedFoodNames);

    // Create a set to hold combo IDs for this specific food item
    Set<String> comboIDsForItem = new HashSet<>();

    // Iterate through each trimmed food name for processing
    for (String foodName : trimmedFoodNames) {
        System.out.println("Food Name: " + foodName + ", Quantity: " + item.getQuantity());

        // Retrieve combo IDs for the current food name only
        List<String> comboIDsForFoodName = BookingDB.getComboIDsByNames(Arrays.asList(foodName)); 

        // Check if the combo IDs are not null and contain entries
        if (comboIDsForFoodName != null && !comboIDsForFoodName.isEmpty()) {
            comboIDsForItem.addAll(comboIDsForFoodName); // Add all retrieved combo IDs for this item
            allComboIDs.addAll(comboIDsForFoodName); // Also add to the global list
        } else {
            System.out.println("Combo IDs not found for: " + foodName);
        }
    }

    // Log combo IDs for the current item
    System.out.println("Combo IDs for item: " + comboIDsForItem);

    // Add the quantity for this food item to the list of all quantities
    allQuantities.add(item.getQuantity());
}

// Final logging of collected data
System.out.println("All Combo IDs: " + allComboIDs);
System.out.println("All Quantities: " + allQuantities);
System.out.println("All Food Names: " + allFoodNames); // This will now contain trimmed names





        // Print out other parameters for debugging
        System.out.println("Ghế đã chọn: " + seatNames);
        System.out.println("Giá: " + priceString);
        System.out.println("Ngày suất chiếu: " + showDate);
        System.out.println("Thời gian bắt đầu: " + startTime);
        System.out.println("ID người dùng: " + userID);
        System.out.println("ID combo: " + allComboIDs);

        Date bookingDate = new Date();
        String bookingID = BookingDB.generateBookingID();
        String voucherID = null;
        String showID = ShowDB.getShowID(showDate, startTime);
        String roomID = RoomDB.getRoomIDFromShow(showID);

        // Handle quantities from the request if necessary
        

        // Get seat IDs from seat names
        List<String> seatID = SeatDB.getSeatIDsFromNames(seatNames, roomID);

        if (seatID.isEmpty()) {
            request.setAttribute("message", "Không tìm thấy ghế.");
            request.getRequestDispatcher("PaymentResult.jsp").forward(request, response);
            return;
        }

        // Perform ticket booking
        boolean isSuccess = BookingDB.bookTicket(bookingID, userID, seatNames, showID, showDate, startTime,allComboIDs, allQuantities, bookingDate, voucherID);
        if (totalPrice == null) {
            request.setAttribute("message", "Không thể xác định tổng tiền.");
            request.getRequestDispatcher("PaymentResult.jsp").forward(request, response);
            return;
        }

        // Retrieve current balance
        BigDecimal currentBalance = UserDB.getCurrentBalance(userID); // You need to create this method in UserDB

        // Compare current balance with total price
        if (currentBalance.compareTo(totalPrice) < 0) {
            // If the current balance is less than the total price, show a message
            request.setAttribute("message", "Số tiền không đủ để đặt vé. Vui lòng nạp thêm tiền.");
            request.getRequestDispatcher("PaymentResult.jsp").forward(request, response);
            return;
        }
        if (isSuccess) {
            request.setAttribute("message", "Đặt vé thành công!");
       
            // Retrieve bookingSeatID from the database after booking
            List<String> bookingSeatID = BookingDB.getBookingSeatIDsByBookingID(bookingID);
            List<String>bookingComboID =BookingDB.getBookingComboIDs(bookingID);
            // Insert into Tickets table
            List<BigDecimal> totalPrices = new ArrayList<>();
            for (String id : seatID) {  // Loop through seatID
                BigDecimal seatPrice = BookingDB.calculateTotalPrice(id, allComboIDs);
                totalPrices.add(seatPrice);
            }

            BookingDB.insertTickets(userID, bookingID, bookingSeatID, roomID, bookingComboID, totalPrices, bookingDate);
        } else {
            request.setAttribute("message", "Đặt vé thất bại! Vui lòng thử lại.");
        }

        // Redirect to notification page
        request.getRequestDispatcher("PaymentResult.jsp").forward(request, response);
    }



    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
