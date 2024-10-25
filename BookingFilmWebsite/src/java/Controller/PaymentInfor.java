package Controller;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParseException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
/**
 *
 * @author ADMIN
 */
public class PaymentInfor extends HttpServlet {
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
            out.println("<title>Servlet PaymentInfor</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentInfor at " + request.getContextPath() + "</h1>");
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
    // Lấy các tham số từ request (theatreID, movieName, selectedDate, selectedTime, selectedSeats, selectedFood, totalPrice, paymentMethod)
    String theatreID = request.getParameter("theatreID");
    String movieName = request.getParameter("movieName");
    String selectedDate = request.getParameter("selectedDate");
    String selectedTime = request.getParameter("selectedTime");
    String selectedSeats = request.getParameter("selectedSeats");
    String selectedFood = request.getParameter("selectedFood");
    String totalPrice = request.getParameter("totalPrice");
    String paymentMethod = request.getParameter("paymentMethod");
    // Đọc JSON từ request body cho foodQuantities
    StringBuilder jsonBuilder = new StringBuilder();
    String line;
    try (BufferedReader reader = request.getReader()) {
        while ((line = reader.readLine()) != null) {
            jsonBuilder.append(line);
        }
    }
    String foodQuantitiesJson = jsonBuilder.toString();
        System.out.println(foodQuantitiesJson);
    // Kiểm tra nếu JSON không hợp lệ hoặc rỗng
    if (foodQuantitiesJson == null || foodQuantitiesJson.isEmpty()) {
        request.setAttribute("error", "Dữ liệu foodQuantities không hợp lệ");
        request.getRequestDispatcher("HomePage.jsp").forward(request, response);
        return;
    }
    // Lưu foodQuantities vào session
    HttpSession session = request.getSession();
    session.setAttribute("foodQuantities", foodQuantitiesJson);
    // Kiểm tra xem có thiếu thông tin nào không từ request
    if (theatreID == null || movieName == null || selectedDate == null ||
        selectedTime == null || selectedSeats == null || totalPrice == null) {
        request.setAttribute("error", "Thiếu thông tin");
        request.getRequestDispatcher("HomePage.jsp").forward(request, response);
        return;
    }
    // Lưu thông tin vào request để gửi tới JSP
    request.setAttribute("theatreID", theatreID);
    request.setAttribute("movieName", movieName);
    request.setAttribute("selectedDate", selectedDate);
    request.setAttribute("selectedTime", selectedTime);
    request.setAttribute("selectedSeats", selectedSeats);
    request.setAttribute("selectedFood", selectedFood);
    request.setAttribute("totalPrice", totalPrice);
    request.setAttribute("paymentMethod", paymentMethod);
    // Chuyển tiếp đến trang xác nhận
    request.getRequestDispatcher("Payment.jsp").forward(request, response);
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