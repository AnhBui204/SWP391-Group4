package Controller;

import Model.TicketDB;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class TicketServlet extends HttpServlet {

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
            out.println("<title>Servlet TicketServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TicketServlet at " + request.getContextPath() + "</h1>");
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
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    String bookingID = request.getParameter("bookingID");

    if (bookingID != null && !bookingID.isEmpty()) {
        if ("approve".equals(action)) {
            TicketDB.approveRefund(bookingID);
            TicketDB.addBalanceToUser(bookingID);
            System.out.println("Đã chấp thuận hoàn tiền cho vé ID: " + bookingID);
        } else if ("reject".equals(action)) {
            TicketDB.rejectRefund(bookingID);   // Gọi phương thức reject từ TicketDB
            System.out.println("Đã từ chối hoàn tiền cho vé ID: " + bookingID);
        }
    }

    response.sendRedirect("ticket.jsp"); // Trả về trang ticket.jsp sau khi xử lý xong
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
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    
    if ("requestRefund".equals(action)) {
        String bookingID = request.getParameter("bookingID");
        System.out.println("BookingID "+ bookingID);
        TicketDB.requestRefund(bookingID);
        response.sendRedirect("summaryBooking.jsp");
    }
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