/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Movie;
import Model.MovieDB;
import Model.Show;
import Model.ShowDB;
import Model.Theatre;
import Model.TheatreDB;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.Date;
import java.util.List;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
public class MovieServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                handleAddMV(request, response);
                break;
            case "update":
                handleUpdateMV(request, response);
                break;
            case "delete":
                handleDeleteMV(request, response);
                break;
//            case "display":
//                handleDisplayMV(request, response);
//                break;
            case "booking":
                handleBooking(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleAddMV(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("movieName");
        String dur = request.getParameter("duration");
        String country = request.getParameter("country");
        int duration = Integer.parseInt(dur);
        String manufacturer = request.getParameter("manufacturer");
        String director = request.getParameter("director");
        String rlDate = request.getParameter("rldate");
        Date releaseDate = Date.valueOf(rlDate);
        String des = request.getParameter("movieDes");

        // Handling imageP file upload
        Part filePartP = request.getPart("imageP");
        String fileNameP = filePartP.getSubmittedFileName();  // Use getSubmittedFileName() to get the original file name
        String uploadPathP = getUploadPDirectory(request);
        String fileURLPathP = "";

        if (fileNameP != null && !fileNameP.isEmpty()) {
            String filePathP = uploadPathP + fileNameP;  // Append the file name to the directory
            fileURLPathP = "image/MovieImg/P/" + fileNameP;
            try {
                filePartP.write(filePathP);  // Save the file
                System.out.println("File uploaded to: " + filePathP);
                request.setAttribute("message", "ImageP uploaded and saved successfully.");
            } catch (IOException ex) {
                System.out.println("Error writing fileP: " + ex.getMessage());
                request.setAttribute("message", "Error writing fileP: " + ex.getMessage());
            }
        } else {
            request.setAttribute("message", "No imageP file selected or invalid file.");
        }

        // Handling imageL file upload
        Part filePartL = request.getPart("imageL");
        String fileNameL = filePartL.getSubmittedFileName();  // Use getSubmittedFileName() to get the original file name
        String uploadPathL = getUploadLDirectory(request);
        String fileURLPathL = "";

        if (fileNameL != null && !fileNameL.isEmpty()) {
            String filePathL = uploadPathL + fileNameL;  // Append the file name to the directory
            fileURLPathL = "image/MovieImg/P/" + fileNameL;
            try {
                filePartL.write(filePathL);  // Save the file
                System.out.println("File uploaded to: " + filePathL);
                request.setAttribute("message", "ImageL uploaded and saved successfully.");
            } catch (IOException ex) {
                System.out.println("Error writing fileL: " + ex.getMessage());
                request.setAttribute("message", "Error writing fileL: " + ex.getMessage());
            }
        } else {
            request.setAttribute("message", "No imageL file selected or invalid file.");
        }

        // Create Movie object and store it in DB
        Movie movie = new Movie(null, name, duration, country, manufacturer, director, fileURLPathP, fileURLPathL, releaseDate, des);
        MovieDB.addMovie(movie);
        request.getRequestDispatcher("crudMV.jsp").forward(request, response);
    }
    
    private void handleUpdateMV(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("movieID");
        String name = request.getParameter("movieName");
        String dur = request.getParameter("duration");
        String country = request.getParameter("country");
        int duration = Integer.parseInt(dur);
        String manufacturer = request.getParameter("manufacturer");
        String director = request.getParameter("director");
        String rlDate = request.getParameter("rldate");
        Date releaseDate = Date.valueOf(rlDate);
        String des = request.getParameter("movieDes");
        
        Movie oldMovie = MovieDB.getMovieById(id);
        // Handling imageP file upload
        Part filePartP = request.getPart("imageP");
        String fileNameP = filePartP.getSubmittedFileName();  // Use getSubmittedFileName() to get the original file name
        String uploadPathP = getUploadPDirectory(request);
        String fileURLPathP = oldMovie.getImgPortrait();
        
        if (fileNameP != null && !fileNameP.isEmpty()) {
            String filePathP = uploadPathP + fileNameP;  // Append the file name to the directory
            fileURLPathP = "image/MovieImg/P/" + fileNameP;
            try {
                filePartP.write(filePathP);  // Save the file
                System.out.println("File uploaded to: " + filePathP);
                request.setAttribute("message", "ImageP uploaded and saved successfully.");
            } catch (IOException ex) {
                System.out.println("Error writing fileP: " + ex.getMessage());
                request.setAttribute("message", "Error writing fileP: " + ex.getMessage());
            }
        } else {
            request.setAttribute("message", "No imageP file selected or invalid file.");
        }

        // Handling imageL file upload
        Part filePartL = request.getPart("imageL");
        String fileNameL = filePartL.getSubmittedFileName();  // Use getSubmittedFileName() to get the original file name
        String uploadPathL = getUploadLDirectory(request);
        String fileURLPathL = oldMovie.getImgLandscape();

        if (fileNameL != null && !fileNameL.isEmpty()) {
            String filePathL = uploadPathL + fileNameL;  // Append the file name to the directory
            fileURLPathL = "image/MovieImg/P/" + fileNameL;
            try {
                filePartL.write(filePathL);  // Save the file
                System.out.println("File uploaded to: " + filePathL);
                request.setAttribute("message", "ImageL uploaded and saved successfully.");
            } catch (IOException ex) {
                System.out.println("Error writing fileL: " + ex.getMessage());
                request.setAttribute("message", "Error writing fileL: " + ex.getMessage());
            }
        } else {
            request.setAttribute("message", "No imageL file selected or invalid file.");
        }
        // Create Movie object and store it in DB
        Movie movie = new Movie(id, name, duration, country, manufacturer, director, fileURLPathP, fileURLPathL, releaseDate, des);
        MovieDB.updateMovie(movie);
        request.getRequestDispatcher("crudMV.jsp").forward(request, response);
    }
    
    private void handleDeleteMV(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieID = request.getParameter("movieID");
        
        MovieDB.deleteMovie(movieID);
        request.getRequestDispatcher("crudMV.jsp").forward(request, response);

    }
    
    private void handleBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Movie> movie = MovieDB.getAllMovies();
        List<Theatre> theatre = TheatreDB.listAllTheatres();
        List<Show> shows = ShowDB.getAllShows();
        request.setAttribute("movie", movie);
        request.setAttribute("theatre", theatre);
        request.setAttribute("shows", shows);
        request.getRequestDispatcher("Booking.jsp").forward(request, response);

    }

//    private void handleUploadPImage(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String userID = request.getParameter("userID");
//        Part filePart = request.getPart("profileImage");
//        String fileName = getFileName(filePart);
//
//        // Lấy đường dẫn từ method getUploadDirectory()
//        String uploadPath = getUploadDirectory(request);
//
//        if (filePart != null && fileName != null && !fileName.isEmpty()) {
//            String filePath = uploadPath + fileName;
//            System.out.println("Upload path: " + uploadPath);
//
//            try {
//                filePart.write(filePath);
//                System.out.println("File written to: " + filePath);
//
//                // Lưu đường dẫn tương đối hoặc tuyệt đối vào database
//                String fileURLPath = "image/MovieImg/P/" + fileName;  // Có thể thay đổi theo yêu cầu
//                MovieDB.uploadPImage(userID, fileURLPath);
//
//                request.setAttribute("message", "Image uploaded and saved successfully.");
//            } catch (IOException ex) {
//                System.out.println("Error writing file: " + ex.getMessage());
//                request.setAttribute("message", "Error writing file: " + ex.getMessage());
//            }
//        } else {
//            request.setAttribute("message", "No file selected or invalid file.");
//        }
//
//        // Chuyển hướng lại trang hồ sơ sau khi upload ảnh
//        request.getRequestDispatcher("/CustomerProfile.jsp").forward(request, response);
//    }
//
//    private void handleUploadLImage(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String userID = request.getParameter("userID");
//        Part filePart = request.getPart("profileImage");
//        String fileName = getFileName(filePart);
//
//        // Lấy đường dẫn từ method getUploadDirectory()
//        String uploadPath = getUploadDirectory(request);
//
//        if (filePart != null && fileName != null && !fileName.isEmpty()) {
//            String filePath = uploadPath + fileName;
//            System.out.println("Upload path: " + uploadPath);
//
//            // Ghi file vào hệ thống file
//            try {
//                filePart.write(filePath);
//                System.out.println("File written to: " + filePath);
//
//                // Lưu đường dẫn tương đối hoặc tuyệt đối vào database
//                String fileURLPath = "image/MovieImg/P/" + fileName;  // Có thể thay đổi theo yêu cầu
//                MovieDB.uploadPImage(userID, fileURLPath);
//
//                request.setAttribute("message", "Image uploaded and saved successfully.");
//            } catch (IOException ex) {
//                System.out.println("Error writing file: " + ex.getMessage());
//                request.setAttribute("message", "Error writing file: " + ex.getMessage());
//            }
//        } else {
//            request.setAttribute("message", "No file selected or invalid file.");
//        }
//
//        // Chuyển hướng lại trang hồ sơ sau khi upload ảnh
//        request.getRequestDispatcher("/CustomerProfile.jsp").forward(request, response);
//    }
    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
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
        return "Short description";
    }

    private String getUploadPDirectory(HttpServletRequest request) {
        // Lấy đường dẫn từ web.xml
        String uploadPath = getServletContext().getInitParameter("UPLOAD_PDIRECTORY");

        // Kiểm tra và tạo thư mục nếu cần
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        return uploadPath;
    }

    private String getUploadLDirectory(HttpServletRequest request) {
        // Lấy đường dẫn từ web.xml
        String uploadPath = getServletContext().getInitParameter("UPLOAD_LDIRECTORY");

        // Kiểm tra và tạo thư mục nếu cần
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        return uploadPath;
    }
}
