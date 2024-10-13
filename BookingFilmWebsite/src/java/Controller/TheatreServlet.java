package Controller;

import Model.Theatre;
import Model.TheatreDB;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class TheatreServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the action parameter to decide the operation
        String action = request.getParameter("action");

        if (action == null) {
            action = "view"; // Default action
        }

        switch (action.toLowerCase()) {
            case "add":
                handleAddTheatre(request, response);
                break;
            case "update":
                handleUpdateTheatre(request, response);
                break;
            case "delete":
                handleDeleteTheatre(request, response);
                break;
            case "view":
                response.sendRedirect("cinema.jsp");
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleAddTheatre(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle adding a new theatre
        String name = request.getParameter("theatreName");
        String location = request.getParameter("theatreLocation");

        TheatreDB theatreDB = new TheatreDB();
        theatreDB.addTheatre(name, location);
        response.sendRedirect("cinema.jsp");
    }

    private void handleUpdateTheatre(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String theatreID = request.getParameter("theatreID");
        String name = request.getParameter("newTheatreName");
        String location = request.getParameter("newTheatreLocation");

        TheatreDB theatreDB = new TheatreDB();
        theatreDB.updateTheatre(theatreID, name, location);
        response.sendRedirect("cinema.jsp?theatreID=" + theatreID);
    }

    private void handleDeleteTheatre(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String theatreID = request.getParameter("theatreID");

        TheatreDB theatreDB = new TheatreDB();
        theatreDB.deleteTheatre(theatreID);
        response.sendRedirect("cinema.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
