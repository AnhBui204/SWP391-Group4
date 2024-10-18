package Controller;

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
            case "displayprofileimage":
                handleDisplayProfileImage(request, response); // Case for image display
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
            if (a.getRole().equals("Admin")) {
                // Admin login
                HttpSession session = request.getSession();
                session.setAttribute("user", a.getUsername());
                session.setAttribute("users", a);
                session.setAttribute("pass", a.getPassword());
                session.setAttribute("role", "Admin");

                session.setMaxInactiveInterval(30 * 60); // Session expiry
                Cookie userName = new Cookie("user", URLEncoder.encode(a.getUsername(), "UTF-8"));
                Cookie password = new Cookie("pass", URLEncoder.encode(a.getPassword(), "UTF-8"));
                response.addCookie(userName);
                response.addCookie(password);
                String encodedURL = response.encodeRedirectURL("AdminDashBoard.jsp");
                response.sendRedirect(encodedURL);

            } else if (a.getRole().equals("User")) {
                // User login
                HttpSession session = request.getSession();
                session.setAttribute("user", a.getUsername());
                session.setAttribute("users", a);
                session.setAttribute("pass", a.getPassword());
                session.setAttribute("id", a.getUserID()); //added
                session.setAttribute("role", "User");

                session.setMaxInactiveInterval(30 * 60); // Session expiry
                Cookie userName = new Cookie("user", URLEncoder.encode(a.getUsername(), "UTF-8"));
                Cookie password = new Cookie("pass", URLEncoder.encode(a.getPassword(), "UTF-8"));
                response.addCookie(userName);
                response.addCookie(password);
                String encodedURL = response.encodeRedirectURL("HomePage.jsp");
                response.sendRedirect(encodedURL);

            } else if (a.getRole().equals("Staff")) {
                // Staff login
                HttpSession session = request.getSession();
                session.setAttribute("user", a.getUsername());
                session.setAttribute("users", a);
                session.setAttribute("pass", a.getPassword());
                session.setAttribute("id", a.getUserID()); //added
                session.setAttribute("role", "Staff");

                session.setMaxInactiveInterval(30 * 60); // Session expiry
                Cookie userName = new Cookie("user", URLEncoder.encode(a.getUsername(), "UTF-8"));
                Cookie password = new Cookie("pass", URLEncoder.encode(a.getPassword(), "UTF-8"));
                response.addCookie(userName);
                response.addCookie(password);
                String encodedURL = response.encodeRedirectURL("StaffDashBoard.jsp");
                response.sendRedirect(encodedURL);
            }
        } else {
            request.setAttribute("errorMessage", "Wrong username or password. Please try again.");
            request.getRequestDispatcher("HomePage.jsp").forward(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Invalidate the session
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

        // Redirect to login page
        response.sendRedirect("HomePage.jsp");
    }

    private void handleSignUp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("uname");
            String email = request.getParameter("email");
            String password = request.getParameter("psw");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");

            if (username == null || email == null || password == null || username.isEmpty() || email.isEmpty() || password.isEmpty()) {
                request.setAttribute("errorMessage", "All fields are required.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            String role = "User"; // Default role for signup
            String id = "1"; // Should be generated or auto-incremented in the database

            UserDB db = new UserDB();
            User newUser = new User(username, password, fname, lname, role, email, id);
            db.insert(newUser);
            response.sendRedirect("HomePage.jsp");
        } catch (Exception e) {
            request.setAttribute("error", "Error adding user: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
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
                RequestDispatcher dispatcher = request.getRequestDispatcher("AdminDashBoard.jsp");
                dispatcher.forward(request, response);
            }
            case "User" -> {
                request.setAttribute("user", user);
                RequestDispatcher dispatcher = request.getRequestDispatcher("CustomerProfile.jsp");
                dispatcher.forward(request, response);
            }
            case "Staff" -> {
                request.setAttribute("staff", user.getUsername());
                RequestDispatcher dispatcher = request.getRequestDispatcher("StaffDBoard.jsp");
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

    // Method to handle profile image display
    private void handleDisplayProfileImage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = request.getParameter("userID");

        // Fetch the avatar path from the database
        String avatarPath = UserDB.getAvatarByUserID(userID);

        if (avatarPath != null) {
            // Set the image path for display
            request.setAttribute("avatarPath", avatarPath);
            // Forward to a JSP to display the image
            request.getRequestDispatcher("/uploadResult.jsp").forward(request, response);
        } else {
            // Handle case where there is no image
            response.getWriter().write("No image found.");
        }
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
