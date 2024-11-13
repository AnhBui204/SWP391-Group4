package Controller;

import Model.EmailSender;
import Model.Theatre;
import Model.TheatreDB;
import Model.UserDB;
import Model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Date;
import java.sql.Timestamp;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
public class UserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "login"; // Default action
        }

        switch (action.toLowerCase()) {
            case "login":
                handleLogin(request, response);
                break;
            case "logout":
                handleLogout(request, response);
                break;
            case "signup":
                handleSignUp(request, response);
                break;
            case "db":
                handleDashBoard(request, response);
                break;
            case "uploadprofileimage":
                handleUploadProfileImage(request, response); // Case for image upload
                break;
            case "updateprofile":
                handleUpdateProfile(request, response); // Case for image upload
                break;

            case "changepassword":
                handleChangePassword(request, response); // Case for image upload               
                break;
            case "deposit":
                handleDeposit(request, response); // Case for image upload
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("uname");
        String pass = request.getParameter("psw");

        UserDB db = new UserDB();
        User a = db.getUsers(user, pass);

        if (a != null && a.getPassword().equals(pass)) {
            HttpSession session = request.getSession();

            if (a.getRole().equals("Admin")) {
                // Admin login
                session.setAttribute("user", a.getUsername());
                session.setAttribute("users", a);
                session.setAttribute("pass", a.getPassword());
                session.setAttribute("role", "Admin");
                session.setMaxInactiveInterval(30 * 60);
                Cookie userName = new Cookie("user", URLEncoder.encode(a.getUsername(), "UTF-8"));
                response.addCookie(userName);
                Cookie password = new Cookie("pass", URLEncoder.encode(a.getPassword(), "UTF-8"));
                response.addCookie(password);

                // Đặt thông báo thành công
                session.setAttribute("successMessage", "Đăng nhập thành công!");

                String encodedURL = response.encodeRedirectURL("AdminDashBoard.jsp");
                response.sendRedirect(encodedURL);

            } else if (a.getRole().equals("User")) {
                // User login
                session.setAttribute("email", a.getEmail());
                session.setAttribute("user", a.getUsername());
                session.setAttribute("users", a);
                session.setAttribute("pass", a.getPassword());
                session.setAttribute("id", a.getUserID());
                session.setAttribute("role", "User");
                session.setMaxInactiveInterval(30 * 60);
                System.out.println(a);
                System.out.println(a.getEmail());
                System.out.println(a.isOtp_verified());
                // Đặt thông báo thành công
                String encodedURL = "";
                //session.setAttribute("successMessage", "Đăng nhập thành công!");
                if (a.isOtp_verified()) {
                    encodedURL = response.encodeRedirectURL("HomePage.jsp");
                } else {
                    session.setAttribute("checkSendOtp", true);
                    encodedURL = response.encodeRedirectURL("otp_authentication.jsp");
                }
                response.sendRedirect(encodedURL);
            } else if (a.getRole().equals("Staff")) {
                // Staff login

                TheatreDB theatreDB = new TheatreDB();
                Theatre cinema = theatreDB.getTheatreById(a.getUserID());
                session.setAttribute("user", a.getUsername());
                session.setAttribute("users", a);
                session.setAttribute("pass", a.getPassword());
                session.setAttribute("id", a.getUserID());
                session.setAttribute("role", "Staff");
                session.setAttribute("theatre", cinema);
                session.setMaxInactiveInterval(30 * 60);

                // Đặt thông báo thành công
                session.setAttribute("successMessage", "Đăng nhập thành công!");

                String encodedURL = response.encodeRedirectURL("crudMV.jsp");
                response.sendRedirect(encodedURL);
            }
        } else {
            request.setAttribute("errorMessage", "Tên người dùng hoặc mật khẩu sai. Vui lòng thử lại.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // Clear cookies
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }

        // Đặt thông báo đăng xuất thành công
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("successMessage", "Đăng xuất thành công!");

        // Redirect to login page
        response.sendRedirect("HomePage.jsp");
    }

    private void handleSignUp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String fname = request.getParameter("firstName");
            String lname = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String sex = request.getParameter("gender");
            String dobString = request.getParameter("dob");
            Date dob = Date.valueOf(dobString);
            String role = "User"; // Default role for signup
            System.out.println("Username: " + username);
            System.out.println("Email: " + email);
            System.out.println("Password: " + password);
            System.out.println("First Name: " + fname);
            System.out.println("Last Name: " + lname);
            System.out.println("Phone: " + phone);
            System.out.println("Gender: " + sex);
            System.out.println("Date of Birth: " + dobString);

            UserDB db = new UserDB();
            User newUser = new User(null, username, password, fname, lname, email, role, phone, sex, dob);
            db.insert(newUser);

            db.uploadProfileImage(newUser.getUserID(), "image/Avatar/default.jpg");

//            // Đặt thông báo thành công
//            HttpSession session = request.getSession();
//            session.setAttribute("successMessage", "Đăng ký thành công! Bạn có thể đăng nhập ngay bây giờ.");
            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("checkSendOtp", true);

            request.setAttribute("successMessage", "Đăng ký thành công! Kiểm tra email của bạn để nhập OTP.");

            response.sendRedirect("otp_authentication.jsp");

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Đã xảy ra lỗi trong quá trình đăng ký. Vui lòng thử lại.");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
        }
    }

    private void handleDashBoard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("user");
        String password = (String) session.getAttribute("pass");

        if (username == null || password == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        UserDB userDB = new UserDB();
        User user = userDB.getUsers(username, password);
        String role = user.getRole();
        switch (role) {
            case "Admin" -> {
                request.setAttribute("admin", user.getUsername());
                RequestDispatcher dispatcher = request.getRequestDispatcher("customer.jsp");
                dispatcher.forward(request, response);
            }
            case "User" -> {
                request.setAttribute("user", user);
                RequestDispatcher dispatcher = request.getRequestDispatcher("CustomerProfile.jsp");
                dispatcher.forward(request, response);
            }
            case "Staff" -> {
                request.setAttribute("staff", user.getUsername());
                RequestDispatcher dispatcher = request.getRequestDispatcher("crudMV.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    private String getUploadDirectory(HttpServletRequest request) {
        // Lấy đường dẫn từ web.xml
        String uploadPath = getServletContext().getInitParameter("UPLOAD_DIRECTORY");

        // Kiểm tra và tạo thư mục nếu cần
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        return uploadPath;
    }

    private void handleUploadProfileImage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = request.getParameter("userID");
        Part filePart = request.getPart("profileImage");
        String fileName = getFileName(filePart);

        // Lấy đường dẫn từ method getUploadDirectory()
        String uploadPath = getUploadDirectory(request);
        User user = UserDB.getUsersByID(userID);

        String jsonResponse; // Để lưu trữ phản hồi JSON

        if (filePart != null && fileName != null && !fileName.isEmpty()) {
            String filePath = uploadPath + fileName;
            System.out.println("Upload path: " + uploadPath);

            // Ghi file vào hệ thống file
            try {
                filePart.write(filePath);
                System.out.println("File written to: " + filePath);

                // Lưu đường dẫn tương đối hoặc tuyệt đối vào database
                String fileURLPath = "image/Avatar/" + fileName;  // Có thể thay đổi theo yêu cầu
                UserDB.uploadProfileImage(userID, fileURLPath);
                System.out.println(fileURLPath);
                user.setAvatar(fileURLPath);
                HttpSession session = request.getSession();
                session.setAttribute("users", user);
                // Tạo phản hồi JSON thành công
                jsonResponse = String.format("{\"newAvatarPath\": \"%s\", \"message\": \"Image uploaded and saved successfully.\"}", fileURLPath);
            } catch (IOException ex) {
                System.out.println("Error writing file: " + ex.getMessage());
                jsonResponse = "{\"message\": \"Error writing file: " + ex.getMessage() + "\"}";
            }
        } else {
            jsonResponse = "{\"message\": \"No file selected or invalid file.\"}";
        }

        // Thiết lập loại nội dung JSON và trả về phản hồi
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }

    // Helper method to extract the file name from the part
    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }

    //Update Profile
    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = request.getParameter("userID");
        String newFirstName = request.getParameter("firstName");
        String newLastName = request.getParameter("lastName");
        String newPhone = request.getParameter("phone");
        String newGender = request.getParameter("gender");
        String dob = request.getParameter("dob");

        // Chuyển đổi chuỗi ngày sinh thành đối tượng Date SQL
        Date newDob = null;
        if (dob != null && !dob.isEmpty()) {
            newDob = Date.valueOf(dob);
        }

        // Lấy thông tin người dùng hiện tại từ session hoặc cơ sở dữ liệu
        User user = UserDB.getUsersByID(userID);

        // Kiểm tra và cập nhật từng thuộc tính nếu nó không rỗng
        user.setfName((newFirstName != null && !newFirstName.isEmpty()) ? newFirstName : user.getfName());
        user.setlName((newLastName != null && !newLastName.isEmpty()) ? newLastName : user.getlName());
        user.setPhone((newPhone != null && !newPhone.isEmpty()) ? newPhone : user.getPhone());
        user.setSex((newGender != null && !newGender.isEmpty()) ? newGender : user.getSex());
        user.setDob((newDob != null) ? newDob : user.getDob());

        // Cập nhật thông tin người dùng trong cơ sở dữ liệu
        System.out.println(user);

        UserDB.updateUserProfile(user);
        request.setAttribute("user", user); // Cập nhật lại thông tin trong session
        response.setContentType("text/plain");
        response.getWriter().write("success");

    }

    private void handleChangePassword(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String userID = request.getParameter("userID");
        User user = UserDB.getUsersByID(userID);

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");
        PrintWriter out = response.getWriter();

        if (user != null && user.getPassword().equals(currentPassword)) {
            //user.setPassword(newPassword);
            //System.out.println(user.getPassword());
            if (newPassword.equals(confirmNewPassword)) {
                if (newPassword.equals(currentPassword)) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    out.write("{\"message\": \"Mật khẩu mới trùng mật khẩu cũ.\"}");
                } else {
                    String email = request.getParameter("email");

                    HttpSession session = request.getSession();
                    session.setAttribute("isChangePassword", true);
                    session.setAttribute("checkSendOtp", true);
                    session.setAttribute("newPass", newPassword);
                    out.write("{\"message\": \"Đổi mật khẩu thành công.\"}");
//                    response.sendRedirect("otp_authentication.jsp");
                }
            } else {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write("{\"message\": \"Mật khẩu mới không trùng khớp.\"}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.write("{\"message\": \"Mật khẩu cũ không chính xác.\"}");
        }
        //out.flush();
    }

    private void handleDeposit(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "UserServlet handles user login, logout, signup, and dashboard actions.";
    }

//    public static void main(String[] args) {
//        ArrayList<User> list = UserDB.listAllUsers();
//        for (User user : list) {
//            System.out.println(user);
//        }
//        User s = UserDB.getUsers("admin","123");
//        System.out.println(s.getRole());
//    }
}
