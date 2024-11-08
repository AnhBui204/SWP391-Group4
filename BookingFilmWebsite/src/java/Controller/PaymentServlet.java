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
// Step 1: Parse request parameters for seat names, price, show details, and user info
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

// Retrieve show date, time, and user ID from session
        String theatreID = request.getParameter("theatreID");
        System.out.println(theatreID);
        String showDate = request.getParameter("selectedDate");
        String startTime = request.getParameter("selectedTime");
        HttpSession session = request.getSession();
        String userID = (String) session.getAttribute("id");

// Retrieve and parse selected food data
        String selectedFoodData = request.getParameter("selectedFood");
        List<FoodItem> foodItems = new ArrayList<>();
        if (selectedFoodData != null) {
            JSONArray foodArray = new JSONArray(selectedFoodData);
            for (int i = 0; i < foodArray.length(); i++) {
                JSONObject foodItem = foodArray.getJSONObject(i);
                String foodName = foodItem.getString("name");
                int quantity = Integer.parseInt(foodItem.getString("quantity"));
                System.out.println("Fooddddddddđ: " + foodName);
                foodItems.add(new FoodItem(Arrays.asList(foodName.trim()), quantity));
            }
        }

// Prepare lists for combo IDs and quantities
        List<String> allComboIDs = new ArrayList<>();
        List<Integer> allQuantities = new ArrayList<>();

        for (FoodItem item : foodItems) {
            List<String> trimmedFoodNames = item.getNames().stream().map(String::trim).collect(Collectors.toList());
            for (String foodName : trimmedFoodNames) {
                List<String> comboIDsForFoodName = BookingDB.getComboIDsByNames(Arrays.asList(foodName), theatreID);
                if (comboIDsForFoodName != null && !comboIDsForFoodName.isEmpty()) {
                    allComboIDs.addAll(comboIDsForFoodName);
                } else {
                    System.out.println("Combo IDs not found for: " + foodName);
                }
            }
            allQuantities.add(item.getQuantity());
        }

// Debugging output for parameters
        System.out.println("Ghế đã chọn: " + seatNames);
        System.out.println("Giá: " + priceString);
        System.out.println("Ngày suất chiếu: " + showDate);
        System.out.println("Thời gian bắt đầu: " + startTime);
        System.out.println("ID người dùng: " + userID);
        System.out.println("ID combo: " + allComboIDs);

        BigDecimal currentBalance = UserDB.getCurrentBalance(userID);
        if (currentBalance.compareTo(totalPrice) < 0) {
            session.setAttribute("message", "Đặt vé không thành công! Số tiền không đủ để đặt vé. Vui lòng nạp thêm tiền.");
            request.getRequestDispatcher("PaymentResult.jsp").forward(request, response);
            return;
        }

        if (totalPrice == null) {
            session.setAttribute("message", "Không thể xác định tổng tiền.");
            request.getRequestDispatcher("PaymentResult.jsp").forward(request, response);
            return;
        }
// Đoạn mã kiểm tra đủ tiền mới thực hiện đặt vé
        if (currentBalance.compareTo(totalPrice) >= 0) {  // Điều kiện chỉnh sửa >=
            String bookingID = BookingDB.generateBookingID();
            String showID = ShowDB.getShowID(showDate, startTime);
            String roomID = RoomDB.getRoomIDFromShow(showID);
            List<String> seatID = SeatDB.getSeatIDsFromNames(seatNames, roomID);

            if (seatID.isEmpty()) {
                request.setAttribute("message", "Không tìm thấy ghế.");
                request.getRequestDispatcher("PaymentResult.jsp").forward(request, response);
                return;
            }

            boolean isSuccess = BookingDB.bookTicket(bookingID, userID, seatNames, showID, showDate, startTime, allComboIDs, allQuantities, new Date(), null);

            if (isSuccess) {
                List<String> bookingSeatID = BookingDB.getBookingSeatIDsByBookingID(bookingID);
                List<String> bookingComboID = BookingDB.getBookingComboIDs(bookingID);
                for (String s : bookingComboID) {
                    System.out.println("Booking combo: " + s);
                }
                System.out.println("Total Price before insert: " + totalPrice);
                BookingDB.insertTickets(userID, bookingID, bookingSeatID, roomID, bookingComboID, totalPrice, new Date());
                BookingDB.deductMoneyLeft(userID, totalPrice);
                session.setAttribute("message", "Thanh toán của bạn đã được xử lý thành công! Cảm ơn bạn đã đặt vé xem phim.");
            } else {
                session.setAttribute("errorMessage", "Đặt vé thất bại! Vui lòng thử lại.");
            }
            System.out.println("Message: " + session.getAttribute("message"));
            session.setAttribute("Thành công", "message");
            request.getRequestDispatcher("PaymentResult.jsp").forward(request, response);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}