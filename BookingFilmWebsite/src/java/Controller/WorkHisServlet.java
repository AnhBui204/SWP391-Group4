/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.WorkHistory;
import Model.WorkHistoryDB;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
//import java.util.Date;
import java.time.LocalTime;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;

/**
 *
 * @author HongD
 */
public class WorkHisServlet extends HttpServlet {

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
            out.println("<title>Servlet WorkHisServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WorkHisServlet at " + request.getContextPath() + "</h1>");
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
        String referer = request.getHeader("referer");
        
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        String page = request.getParameter("page");
        String whDes = "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
        LocalDate dateCurr = LocalDate.now();
        LocalTime timeCurr = LocalTime.now();
        Date dateSql = Date.valueOf(dateCurr);
        Time timeSql = Time.valueOf(timeCurr);
        
        WorkHistory whs = new WorkHistory();
        if (page.equalsIgnoreCase(" set Show") || page.equalsIgnoreCase("set Room")){
            
            String action = request.getParameter("action");
            whDes = "Action: " + action + ", affected page: " + page + ", Day: " + dateCurr.toString() + ", Time: " + timeCurr.toString();
            
        } else if (page.equalsIgnoreCase("setShow")){
            whDes = "Action: set Show, affected page: " + page + ", Day: " + dateCurr.toString() + ", Time: " + timeCurr.toString();
        } else if (page.equalsIgnoreCase("setRoom")){
            whDes = "Action: set Room , affected page: " + page + ", Day: " + dateCurr.toString() + ", Time: " + timeCurr.toString();
        }
        
        whs.setWorkID(WorkHistoryDB.getNextWorkHisId());
        whs.setWorkDes(whDes);
        whs.setDates(dateSql);
        whs.setTimes(timeSql);
        whs.setStaffID(page);
        
        if (referer != null)
            response.sendRedirect(referer);
        else
            response.sendRedirect("HomePage.jsp");
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