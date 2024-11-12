/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package OTP;

import Model.EmailSender;
import Model.UserDB;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;

/**
 *
 * @author pc
 */
@MultipartConfig
public class SendOtp extends HttpServlet {

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
            out.println("<title>Servlet SendOtp</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SendOtp at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
        HttpSession session = request.getSession();
        boolean checkChangePassword = false;
        boolean checkSendOtp = false;
        if (session.getAttribute("checkSendOtp") != null) {
            checkSendOtp = (boolean) session.getAttribute("checkSendOtp");
        }
        if (checkSendOtp) {
            String email = (String) session.getAttribute("email");
            String otp = OTP.generateOTP();
            String userID = UserDB.getUserIdByEmail(email);
            Timestamp expiryTime = new Timestamp(System.currentTimeMillis() + (15 * 60 * 1000));
            if (session.getAttribute("isChangePassword") != null) {
                checkChangePassword = (boolean) session.getAttribute("isChangePassword");
            }
            if (checkChangePassword) {
                OTP.saveOtpToDatabase(userID, otp, expiryTime, true);
            } else {
                OTP.saveOtpToDatabase(userID, otp, expiryTime, false);
            }
            EmailSender.sendOtpToEmail(email, otp);
            session.setAttribute("checkSendOtp", false);
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