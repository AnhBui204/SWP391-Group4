/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Theatre;
import Model.TheatreDB;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ANH BUI
 */
public class TheatreServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the action parameter to decide the operation
        String action = request.getParameter("action");
        String theatreID = request.getParameter("cinemaID");

        TheatreDB theatreDB = new TheatreDB();

        if ("update".equals(action)) {
            // Redirect to the update page
            request.setAttribute(theatreID, theatreID);
            response.sendRedirect("updateTheatre.jsp?theatreID=" + theatreID);
        } else if ("delete".equals(action)) {
            // Perform the deletion of the theatre
            theatreDB.deleteTheatre(theatreID);
            // Redirect back to the list of theatres
            response.sendRedirect("cinema.jsp");
        } else if ("add".equals(action)) {
            // Handle adding a new theatre
            String name = request.getParameter("theatreName");
            String location = request.getParameter("theatreLocation");

            Theatre newTheatre = new Theatre();
            newTheatre.setTheatreName(name);
            newTheatre.setTheatreLocation(location);

            theatreDB.addTheatre(newTheatre);
            // Redirect back to the theatre list
            response.sendRedirect("cinema.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Default behavior is to forward to the cinema.jsp
        response.sendRedirect("cinema.jsp");
    }
}
