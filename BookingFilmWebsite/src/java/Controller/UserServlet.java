package Controller;

import Model.UserDB;
import Model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

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
                session.setAttribute("pass", a.getPassword());
                session.setAttribute("id",a.getUserID()); //added
                session.setAttribute("role", "User");

                session.setMaxInactiveInterval(30 * 60); // Session expiry
                Cookie userName = new Cookie("user", URLEncoder.encode(a.getUsername(), "UTF-8"));
                Cookie password = new Cookie("pass", URLEncoder.encode(a.getPassword(), "UTF-8"));
                response.addCookie(userName);
                response.addCookie(password);
                String encodedURL = response.encodeRedirectURL("HomePage.jsp");
                response.sendRedirect(encodedURL);

            }else if (a.getRole().equals("Staff")) {
                // User login
                HttpSession session = request.getSession();
                session.setAttribute("user", a.getUsername());
                session.setAttribute("pass", a.getPassword());
                session.setAttribute("id",a.getUserID()); //added
                session.setAttribute("role", "Staff");

                session.setMaxInactiveInterval(30 * 60); // Session expiry
                Cookie userName = new Cookie("user", URLEncoder.encode(a.getUsername(), "UTF-8"));
                Cookie password = new Cookie("pass", URLEncoder.encode(a.getPassword(), "UTF-8"));
                response.addCookie(userName);
                response.addCookie(password);
                String encodedURL = response.encodeRedirectURL("StaffDashBoard.jsp");
                response.sendRedirect(encodedURL);
            }
            else {
                // Invalid role, handle accordingly

            }
        } else {
            request.setAttribute("errorMessage", "Wrong username or password. Please try again");
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

            if (username == null || email == null || password == null || username.isEmpty() || email.isEmpty() || password.isEmpty()) {
                request.setAttribute("errorMessage", "All fields are required.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            String role = "User"; // Default role for signup
            String id = "1"; // Should be generated or auto-incremented in the database

            UserDB db = new UserDB();
            User newUser = new User(username, password, role, email, id);
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
            response.sendRedirect("login.jsp");
            return;
        }

        UserDB userDB = new UserDB();
        User user = userDB.getUsers(username, password);
        request.setAttribute("user", user);

        RequestDispatcher dispatcher = request.getRequestDispatcher("userDBoard.jsp");
        dispatcher.forward(request, response);
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
