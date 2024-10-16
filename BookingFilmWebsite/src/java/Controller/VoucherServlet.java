/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Theatre;
import Model.TheatreDB;
import Model.Voucher;
import Model.VoucherDB;
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
public class VoucherServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                handleAddVC(request, response);
                break;
            case "update":
                handleUpdateVC(request, response);
                break;
            case "delete":
                handleDeleteVC(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleAddVC(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("voucherName");
        String sPrice = request.getParameter("price");
        int price = Integer.parseInt(sPrice);
        String expDate = request.getParameter("expiryDate");
        Date expiryDate = Date.valueOf(expDate);
        String theatreID = request.getParameter("theatreID");
        
        // Handling imageL file upload
        Part filePart = request.getPart("voucherImage");
        String fileName = filePart.getSubmittedFileName();  // Use getSubmittedFileName() to get the original file name
        String uploadPath = getUploadVDirectory(request);
        String fileURLPath = "";

        if (fileName != null && !fileName.isEmpty()) {
            String filePath = uploadPath + fileName;  // Append the file name to the directory
            fileURLPath = "image/Voucher/" + fileName;
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
        Voucher voucher = new Voucher(null, name, theatreID, fileURLPath, price, expiryDate);
        VoucherDB.createVoucher(voucher);
        request.getRequestDispatcher("Offers.jsp").forward(request, response);
    }
    
    private void handleUpdateVC(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("voucherID");
        String name = request.getParameter("voucherName");
        String sPrice = request.getParameter("price");
        int price = Integer.parseInt(sPrice);
        String expDate = request.getParameter("expiryDate");
        Date expiryDate = Date.valueOf(expDate);
        String theatreID = request.getParameter("theatreID");
        
        // Handling imageL file upload
        Part filePart = request.getPart("voucherImage");
        String fileName = filePart.getSubmittedFileName();  // Use getSubmittedFileName() to get the original file name
        String uploadPath = getUploadVDirectory(request);
        Voucher s = VoucherDB.getVoucherById(id);
        String fileURLPath = s.getImgPath();
        if (fileName != null && !fileName.isEmpty()) {
            String filePath = uploadPath + fileName;  // Append the file name to the directory
            fileURLPath = "image/Voucher/" + fileName;
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
        Voucher voucher = new Voucher(id, name, theatreID, fileURLPath, price, expiryDate);
        VoucherDB.updateVoucher(voucher);
        request.getRequestDispatcher("Offers.jsp").forward(request, response);
    }
    
    private void handleDeleteVC(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String voucherID = request.getParameter("voucherID");
        
        VoucherDB.deleteVoucher(voucherID);
        request.getRequestDispatcher("Offers.jsp").forward(request, response);

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

    private String getUploadVDirectory(HttpServletRequest request) {
        // Lấy đường dẫn từ web.xml
        String uploadPath = getServletContext().getInitParameter("UPLOAD_VDIRECTORY");

        // Kiểm tra và tạo thư mục nếu cần
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        return uploadPath;
    }

}
