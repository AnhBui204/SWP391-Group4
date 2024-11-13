package Controller;

import Model.RevenueDB;
import Model.Revenue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import com.google.gson.Gson;
import java.io.BufferedReader;
import java.util.HashMap;
import java.util.Map;

public class RevenueServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ body của yêu cầu
        StringBuilder jsonString = new StringBuilder();
        String line;
        BufferedReader reader = request.getReader();
        while ((line = reader.readLine()) != null) {
            jsonString.append(line);
        }

        // Sử dụng Gson để chuyển đổi dữ liệu JSON thành đối tượng Java
        Gson gson = new Gson();
        Map<String, String> data = gson.fromJson(jsonString.toString(), Map.class);
        String selectedDate = data.get("date");
        String cinemaID = data.get("theatreID");

        System.out.println("Date" + selectedDate);
        System.out.println("ID" + cinemaID);
        RevenueDB revenueDB = new RevenueDB();
        List<Revenue> totalRevenue = revenueDB.getTotalRevenueByTheatre(cinemaID);
        List<Revenue> totalRevenue2 = revenueDB.getTotalRevenue();
        List<Revenue> dailyRevenue = revenueDB.getDailyRevenueByCinemaAndDate(cinemaID, selectedDate);
        
        System.out.println(dailyRevenue);
        System.out.println(totalRevenue2);
        // Chuyển đổi dữ liệu trả về thành JSON
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("totalRevenue", totalRevenue2);
        responseData.put("dailyRevenue", dailyRevenue);
        
        // Chuyển dữ liệu thành JSON và gửi về client
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.println(gson.toJson(responseData));
    }
}
