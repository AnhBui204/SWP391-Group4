package Controller;

import Model.SeatDetail;
import Model.ShowSeatDB;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 *
 * @author ADMIN
 */
public class Seat extends HttpServlet {

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
            out.println("<title>Servlet Seat</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Seat at " + request.getContextPath() + "</h1>");
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
    String theatreName = request.getParameter("theatreName");
    String showDate = request.getParameter("selectedDate");
    String movieName = request.getParameter("movieName"); 
    String startTime = request.getParameter("selectedTime");
    String movieID = request.getParameter("movieID");
    String theatreID = request.getParameter("theatreID");
    String movieImg= request.getParameter("movieImg");
        System.out.println(movieID);
        System.out.println("theatreID: "+theatreID);
        System.out.println(movieImg);
System.out.println("Theatre Name: " + theatreName);
System.out.println("Movie Name: " + movieName);
System.out.println("Show Date: " + showDate);
System.out.println("Start Time: " + startTime);
List<SeatDetail> availableSeats = ShowSeatDB.getSeatsForShow(movieID, theatreID, startTime, showDate);
Set<String> rowLabels = new HashSet<>();
if (availableSeats != null) {
    for (SeatDetail seat : availableSeats) {
        String seatName = seat.getSeatName();
        if (seatName != null && seatName.length() > 0) {
            String rowLabel = seatName.substring(0, 1);
            rowLabels.add(rowLabel);
        }
    }
}
if (availableSeats != null && !availableSeats.isEmpty()) {
    for (SeatDetail seat : availableSeats) {
        String seatName = seat.getSeatName();
        int isAvailable = seat.getIsAvailables();
        double price = seat.getPrice();


        System.out.println("Seat: " + seatName + ", Available: " + isAvailable + ", Price: " + price);
    }
} else {
    System.out.println("Không có ghế nào có sẵn.");
}
List<String> rowLabelList = new ArrayList<>(rowLabels);

Collections.sort(rowLabelList);

    System.out.println("Available Seats: " + availableSeats);
    
    HttpSession session = request.getSession();
    session.setAttribute("theatreName", theatreName);
    session.setAttribute("movieName", movieName);
    session.setAttribute("selectedDate", showDate);
    session.setAttribute("selectedTime", startTime);
    session.setAttribute("theatreID",theatreID);
    session.setAttribute("movieImg", movieImg);
    request.setAttribute("rowLabels", rowLabels);
    request.setAttribute("availableSeats", availableSeats);
  
    
   request.getRequestDispatcher("SeatSelect.jsp").forward(request, response);
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