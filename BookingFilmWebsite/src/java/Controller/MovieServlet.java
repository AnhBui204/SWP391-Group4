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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;


public class MovieServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MovieServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MovieServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

 @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {   
        List<Movie> movie = MovieDB.getAllMovies();
        List<Theatre> theatre = TheatreDB.listAllTheatres();
        List<Show> shows = ShowDB.getAllShows();
        request.setAttribute("movie", movie);
        request.setAttribute("theatre", theatre);
        request.setAttribute("shows", shows);
        request.getRequestDispatcher("Booking.jsp").forward(request, response);
    
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

}
