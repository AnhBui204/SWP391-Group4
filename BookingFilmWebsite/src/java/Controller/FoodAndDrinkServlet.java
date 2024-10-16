/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Theatre;
import Model.TheatreDB;
import Model.FoodAndDrink;
import Model.FoodAndDrinkDB;
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
public class FoodAndDrinkServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                handleAddCB(request, response);
                break;
            case "update":
                handleUpdateCB(request, response);
                break;
            case "delete":
                handleDeleteCB(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleAddCB(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("comboName");
        String sPrice = request.getParameter("price");
        int price = Integer.parseInt(sPrice);
        String theatreID = request.getParameter("theatreID");
        
        // Handling imageL file upload
        Part filePart = request.getPart("filename");
        String fileName = filePart.getSubmittedFileName();  // Use getSubmittedFileName() to get the original file name
        String uploadPath = getUploadCBDirectory(request);
        String fileURLPath = "";

        if (fileName != null && !fileName.isEmpty()) {
            String filePath = uploadPath + fileName;  // Append the file name to the directory
            fileURLPath = "image/FoodsAndDrinks/" + fileName;
            try {
                filePart.write(filePath);  // Save the file
                System.out.println("File uploaded to: " + filePath);
                request.setAttribute("message", "Image uploaded and saved successfully.");
            } catch (IOException ex) {
                System.out.println("Error writing fileL: " + ex.getMessage());
                request.setAttribute("message", "Error writing fileL: " + ex.getMessage());
            }
        } else {
            request.setAttribute("message", "No image file selected or invalid file.");
        }

        // Create Movie object and store it in DB
        FoodAndDrink combo = new FoodAndDrink(null, name, theatreID, fileURLPath, price);
        FoodAndDrinkDB.createCombo(combo);
        request.getRequestDispatcher("crudFD.jsp").forward(request, response);
    }
    
    private void handleUpdateCB(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("comboID");
        String name = request.getParameter("comboName");
        String sPrice = request.getParameter("price");
        int price = Integer.parseInt(sPrice);
        String theatreID = request.getParameter("theatreID");
        
        // Handling imageL file upload
        Part filePart = request.getPart("filename");
        String fileName = filePart.getSubmittedFileName();  // Use getSubmittedFileName() to get the original file name
        String uploadPath = getUploadCBDirectory(request);
        FoodAndDrink s = FoodAndDrinkDB.getComboById(id);
        String fileURLPath = s.getImagePath();
        if (fileName != null && !fileName.isEmpty()) {
            String filePath = uploadPath + fileName;  // Append the file name to the directory
            fileURLPath = "image/FoodsAndDrinks/" + fileName;
            try {
                filePart.write(filePath);  // Save the file
                System.out.println("File uploaded to: " + filePath);
                request.setAttribute("message", "ImageL uploaded and saved successfully.");
            } catch (IOException ex) {
                System.out.println("Error writing fileL: " + ex.getMessage());
                request.setAttribute("message", "Error writing fileL: " + ex.getMessage());
            }
        } else {
            request.setAttribute("message", "No imageL file selected or invalid file.");
        }

        // Create Movie object and store it in DB
        FoodAndDrink combo = new FoodAndDrink(id, name, theatreID, fileURLPath, price);
        FoodAndDrinkDB.updateCombo(combo);
        request.getRequestDispatcher("crudFD.jsp").forward(request, response);
    }
    
    private void handleDeleteCB(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String comboID = request.getParameter("comboID");
        System.out.println("Hello"+comboID);
        FoodAndDrinkDB.deleteCombo(comboID);
        request.getRequestDispatcher("crudFD.jsp").forward(request, response);

    }

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

    private String getUploadCBDirectory(HttpServletRequest request) {
        // Lấy đường dẫn từ web.xml
        String uploadPath = getServletContext().getInitParameter("UPLOAD_CBDIRECTORY");

        // Kiểm tra và tạo thư mục nếu cần
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        return uploadPath;
    }

}
