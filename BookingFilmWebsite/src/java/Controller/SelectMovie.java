package Controller;
import Model.Show;
import Model.ShowDB;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author ADMIN
 */
public class SelectMovie extends HttpServlet {
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SelectMovie</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SelectMovie at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     
    }
    
    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      try {
        JsonObject jsonObject = new Gson().fromJson(request.getReader(), JsonObject.class);
        String movieID = jsonObject.get("movieID").getAsString();
        String theatreID = jsonObject.get("theatreID").getAsString();
        if (movieID.isEmpty() || theatreID.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
            return;
        }
        System.out.println("Received movieID: " + movieID + ", theatreID: " + theatreID);
        List<String> showList = ShowDB.getShowDatesByMovieAndTheatre(movieID, theatreID);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        new Gson().toJson(showList, response.getWriter());
    }catch (JsonIOException | JsonSyntaxException | IOException e) {
        // Xử lý các lỗi khác
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
        
}
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}