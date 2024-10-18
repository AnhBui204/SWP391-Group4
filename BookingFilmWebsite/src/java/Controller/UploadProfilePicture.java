import Model.UserDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.*;
import java.sql.*;

@MultipartConfig(maxFileSize = 16177215) // Max file size: 16MB
public class UploadProfilePicture extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userID = request.getParameter("userID");

        if (userID != null) {
            response.setContentType("image/png");  // Set response type as image
            UserDB.displayProfileImage(userID, response);
        } else {
            response.getWriter().println("User ID missing.");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieves the image file part from the request
        Part filePart = request.getPart("profileImage");
        String userID = request.getParameter("userID");

        if (filePart != null && userID != null) {
            InputStream inputStream = filePart.getInputStream();
            UserDB.uploadProfileImage(userID, inputStream);
            response.sendRedirect("CustomerProfile.jsp?userID=" + userID);  // Redirect to the profile page
        } else {
            response.getWriter().println("File or user ID missing.");
        }
    }
}
