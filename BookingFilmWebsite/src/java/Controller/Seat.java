/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.ShowSeatDB;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

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
        System.out.println(movieID);
        System.out.println("theatreID: "+theatreID);
System.out.println("Theatre Name: " + theatreName);
System.out.println("Movie Name: " + movieName);
System.out.println("Show Date: " + showDate);
System.out.println("Start Time: " + startTime);

    List<String> availableSeats = ShowSeatDB.getSeatsForShow(movieID, theatreID, startTime, showDate);
    List<String> rowLabels = new ArrayList<>();
for (String seat : availableSeats) {
    String rowLabel = seat.substring(0, 1);
    if (!rowLabels.contains(rowLabel)) {
        rowLabels.add(rowLabel);
    }
}
    System.out.println("Available Seats: " + availableSeats);
    
    HttpSession session = request.getSession();
    session.setAttribute("theatreName", theatreName);
    session.setAttribute("movieName", movieName);
    session.setAttribute("selectedDate", showDate);
    session.setAttribute("selectedTime", startTime);
    session.setAttribute("theatreID",theatreID);
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
