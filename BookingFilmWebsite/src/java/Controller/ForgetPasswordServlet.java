//
//import Model.EmailSender;
//import Model.UserDB;
//import java.io.IOException;
//import java.sql.Timestamp;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet(name = "ForgetPasswordServlet", urlPatterns = {"/ForgetPasswordServlet"})
//public class ForgetPasswordServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//        HttpSession session = request.getSession();
//        String email = request.getParameter("email"); // Nhận email từ form
//        boolean emailExists = UserDB.checkEmailExists(email); // Kiểm tra email trong cơ sở dữ liệu
//        
//        if (emailExists) {
//            String otp = OTP.generateOTP(); // Tạo mã OTP
//            String userID = UserDB.getUserIdByEmail(email); // Lấy user ID từ email
//            Timestamp expiryTime = new Timestamp(System.currentTimeMillis() + (15 * 60 * 1000)); // Thời hạn OTP là 15 phút
//
//            // Lưu OTP và thời hạn vào cơ sở dữ liệu
//            OTP.saveOtpToDatabase(userID, otp, expiryTime, false);
//            EmailSender.sendOtpToEmail(email, otp); // Gửi OTP qua email
//            
//            // Đặt các thuộc tính vào session để xác nhận OTP sau này
//            session.setAttribute("otp", otp);
//            session.setAttribute("expiryTime", expiryTime);
//            session.setAttribute("email", email);
//            
//            response.sendRedirect("otp_verification.jsp"); // Chuyển hướng người dùng đến trang xác thực OTP
//        } else {
//            // Nếu email không tồn tại trong hệ thống
//            session.setAttribute("errorMessage", "Email không tồn tại trong hệ thống.");
//            response.sendRedirect("forgot_password.jsp"); // Quay lại trang quên mật khẩu
//        }
//    }
//}
