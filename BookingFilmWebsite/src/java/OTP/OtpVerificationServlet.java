/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package OTP;

import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import Model.UserDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author pc
 */
@WebServlet("/VerifyOtpServlet")
public class OtpVerificationServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        String otpEntered = request.getParameter("otp");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        // Verify OTP
        if (OTP.verifyOtp(email, otpEntered)) {
            // OTP verified successfully
            boolean checkChangePassword = false;
            String pass = null;
            if (session.getAttribute("isChangePassword") != null) {
                checkChangePassword = (boolean) session.getAttribute("isChangePassword");
            }
            OTP.updateOtpVerificationStatus(email, true);
//            if (session.getAttribute("pass") != null) {
//                pass = (String) session.getAttribute("pass");
//            }
            User user = new UserDB().findByEmail(email);
            session.setAttribute("user", user.getUsername());
            session.setAttribute("users", user);
            session.setAttribute("pass", user.getPassword());
            session.setAttribute("id", user.getUserID());
            session.setAttribute("role", "User");
            session.setMaxInactiveInterval(30 * 60);
            if (checkChangePassword) {
                pass = (String) session.getAttribute("newPass");
                user.setPassword(pass);
                UserDB.updatePassword(user);
                session.setAttribute("pass", user.getPassword());
                session.setAttribute("email", email);
                session.setAttribute("user", user.getUsername());
                session.setAttribute("pass", pass);
                session.setAttribute("isChangePassword", false);
                session.setAttribute("users", user);
                request.getRequestDispatcher("UserServlet?action=db").forward(request, response);

            } //            session.setAttribute("otp_verified", true);
            else {
                response.sendRedirect("HomePage.jsp");
            }
        } else {
            // OTP verification failed
            session.setAttribute("verificationError", "OTP sai. Vui lòng thử lại.");
            response.sendRedirect("otp_authentication.jsp");
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