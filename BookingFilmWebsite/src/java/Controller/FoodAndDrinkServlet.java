/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Theatre;
import Model.TheatreDB;
import Model.FoodAndDrink;
import Model.FoodAndDrinkDB;
import Model.WorkHistory;
import Model.WorkHistoryDB;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
public class FoodAndDrinkServlet extends HttpServlet {

    static String tempName = "";
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
        handleUpdateWorkHistory(request, response);
    }

    private void handleAddCB(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("comboName");                tempName = name; // Dien add
        String sPrice = request.getParameter("price");
        int price = Integer.parseInt(sPrice);
        String theatreID = request.getParameter("theatreID");

        // Handling image file upload
        Part filePart = request.getPart("filename");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getUploadCBDirectory(request);
        String fileURLPath = "";

        if (fileName != null && !fileName.isEmpty()) {
            String filePath = uploadPath + fileName;
            fileURLPath = "image/FoodsAndDrinks/" + fileName;
            try {
                filePart.write(filePath);
                System.out.println("File uploaded to: " + filePath);
            } catch (IOException ex) {
                System.out.println("Error writing file: " + ex.getMessage());
                request.setAttribute("message", "Error writing file: " + ex.getMessage());
            }
        }

        // Create FoodAndDrink object and store it in DB
        FoodAndDrink combo = new FoodAndDrink(null, name, theatreID, fileURLPath, price);
        FoodAndDrinkDB.createCombo(combo);

        // Set success message
        request.setAttribute("message", "Food and Drink combo added successfully!");
        request.getRequestDispatcher("crudFD.jsp").forward(request, response);
    }

    private void handleUpdateCB(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("comboID");
        String name = request.getParameter("comboName");
        String sPrice = request.getParameter("price");              tempName = name; // Dien add
        int price = Integer.parseInt(sPrice);
//        String theatreID = request.getParameter("theatreID");
        String theatreID = FoodAndDrinkDB.getComboById(id).getTheatreID();

        // Handling image file upload
        Part filePart = request.getPart("filename");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getUploadCBDirectory(request);
        FoodAndDrink existingCombo = FoodAndDrinkDB.getComboById(id);
        String fileURLPath = existingCombo.getImagePath();

        if (fileName != null && !fileName.isEmpty()) {
            String filePath = uploadPath + fileName;
            fileURLPath = "image/FoodsAndDrinks/" + fileName;
            try {
                filePart.write(filePath);
                System.out.println("File uploaded to: " + filePath);
            } catch (IOException ex) {
                System.out.println("Error writing file: " + ex.getMessage());
                request.setAttribute("message", "Error writing file: " + ex.getMessage());
            }
        }

        // Create FoodAndDrink object and store it in DB
        FoodAndDrink combo = new FoodAndDrink(id, name, theatreID, fileURLPath, price);
        FoodAndDrinkDB.updateCombo(combo);

        // Set success message
        request.setAttribute("message", "Food and Drink combo updated successfully!");
        request.getRequestDispatcher("crudFD.jsp").forward(request, response);
    }

    private void handleDeleteCB(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String comboID = request.getParameter("comboID");               tempName = FoodAndDrinkDB.getComboById(comboID).getComboName(); // Dien add
        System.out.println("Deleting combo: " + comboID);
        FoodAndDrinkDB.deleteCombo(comboID);

        // Set success message
        request.setAttribute("message", "Food and Drink combo deleted successfully!");
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
    
    private void handleUpdateWorkHistory(HttpServletRequest request, HttpServletResponse response) throws IOException{
//        String referer = request.getHeader("referer");
        
        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        String page = request.getParameter("page");
        String whDes = "";
        LocalDate dateCurr = LocalDate.now();
        LocalTime timeCurr = LocalTime.now();
        Date dateSql = Date.valueOf(dateCurr);
        Time timeSql = Time.valueOf(timeCurr);
        
        WorkHistory whs = new WorkHistory();
        if (!page.equalsIgnoreCase("setShow") || !page.equalsIgnoreCase("setRoom")){
            
            String action = request.getParameter("action");
            whDes = "Action: " + action + " " + page + " " + tempName + ", Affected page: " + page + ", Executor: " + id;
            
        } else if (page.equalsIgnoreCase("setShow")){
            whDes = "Action: set Show " + tempName + ", Affected page: " + page + ", Executor: " + id;
        } else if (page.equalsIgnoreCase("setRoom")){
            whDes = "Action: set Room in " + tempName + ", Affected page: " + page + ", Executor: " + id;
        }
        
        whs.setWorkID(WorkHistoryDB.getNextWorkHisId());
        whs.setWorkDes(whDes);
        whs.setDates(dateSql);
        whs.setTimes(timeSql);
        whs.setStaffID(id);
        
        WorkHistoryDB.addWorkHis(whs);
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
