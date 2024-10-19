/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.ShowDB;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class SelectDate extends HttpServlet {

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
            out.println("<title>Servlet SelectDate</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SelectDate at " + request.getContextPath() + "</h1>");
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
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        JsonObject jsonObject = new Gson().fromJson(request.getReader(), JsonObject.class);
        String movieID = jsonObject.get("movieID").getAsString();
        String theatreID = jsonObject.get("theatreID").getAsString();
        String showDate = jsonObject.get("showDate").getAsString(); // Giả định bạn cũng có showDate

        // Kiểm tra tính hợp lệ của movieID, theatreID và showDate
        if (movieID.isEmpty() || theatreID.isEmpty() || showDate.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Trả về mã trạng thái 400
            return;
        }

        System.out.println("Received movieID: " + movieID + ", theatreID: " + theatreID + ", showDate: " + showDate);
        
        // Lấy danh sách thời gian bắt đầu từ cơ sở dữ liệu
      List<Time> startTimes = ShowDB.getStartTimes(movieID, theatreID, showDate);

        // Thiết lập kiểu phản hồi
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Gửi danh sách thời gian bắt đầu dưới dạng JSON
        new Gson().toJson(startTimes, response.getWriter());
    }catch (JsonIOException | JsonSyntaxException | IOException  e) {
        // Xử lý ngoại lệ SQL
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
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