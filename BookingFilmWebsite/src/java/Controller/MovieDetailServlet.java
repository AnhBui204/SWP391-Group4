/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Movie;
import Model.MovieDB;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author HongD
 */
public class MovieDetailServlet extends HttpServlet {

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
            out.println("<title>Servlet MovieDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MovieDetailServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rate = request.getParameter("rate") + "";
        if (rate.equalsIgnoreCase("null")) {
        try {
            //        processRequest(request, response);
            SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            
            String MovieId = request.getParameter("MovieId");
            String MovieName = request.getParameter("MovieName");
            String Duration = request.getParameter("Duration");
            String Country = request.getParameter("Country");
            String Manufacturer = request.getParameter("Manufacturer");
            String Director = request.getParameter("Director");
//            String MovieType = request.getParameter("MovieType");
            Date ReleaseDate = sf.parse(request.getParameter("ReleaseDate"));
            String ImgP = request.getParameter("ImgP");
            String ImgL = request.getParameter("ImgL");
//            String Rate = request.getParameter("Rate");
            
            String ReleaseDateString = sdf.format(ReleaseDate);
//        response.getWriter().println("MovieName: " + MovieName);
//        response.getWriter().println("Duration: " + Duration);
//        response.getWriter().println("Country: " + Country);
//        response.getWriter().println("Director: " + Director);
//        response.getWriter().println("MovieType: " + MovieType);
//        response.getWriter().println("ReleaseDate: " + ReleaseDate);
//        response.getWriter().println("ImgP: " + ImgP);
//        response.getWriter().println("ImgL: " + ImgL);
//        response.getWriter().println("Rate: " + Rate);

        

//            response.sendRedirect("MovieDetail.jsp?MovieId="+ MovieId +"&MovieName="+ MovieName +"&Duration="+ Duration +"&Country="+ Country +"&Director="+ Director /*+"&MovieType="+ MovieType */+"&ReleaseDate="+ ReleaseDateString +"&ImgP="+ ImgP /*+"&ImgL="+ ImgL +"&Rate="+ Rate*/);

            request.setAttribute("movieId", MovieId);
            request.setAttribute("movieName", MovieName);
            request.setAttribute("duration", Duration);
            request.setAttribute("country", Country);
            request.setAttribute("manufacturer", Manufacturer);
            request.setAttribute("director", Director);
            request.setAttribute("imgP", ImgP);
            request.setAttribute("imgL", ImgL);
            request.setAttribute("releaseDate", ReleaseDateString);
//            System.out.println(ImgL);
//            System.out.println(ImgP);
            RequestDispatcher dispatcher = request.getRequestDispatcher("MovieDetail.jsp");
            dispatcher.forward(request, response);
            
        } catch (ParseException ex) {
            response.getWriter().println(ex);
        }
        } else {
            String mvId = request.getParameter("mvId");
            MovieDB.addOrUpdateRate("T00001", mvId, Integer.parseInt(rate));

            try {
                //        processRequest(request, response);
                SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

//                String MovieId = request.getParameter("MovieId");
                Movie movie = MovieDB.getMovieById(mvId);
                String MovieName = movie.getMovieName();
                String Duration = movie.getDuration() + "";
                String Country = movie.getCountry();
                String Manufacturer = movie.getManufacturer();
                String Director = movie.getDirector();
                Date ReleaseDate = movie.getReleaseDate();
                String ImgP = movie.getImgPortrait();
            String ImgL = movie.getImgLandscape();
                
            
                String ReleaseDateString = sdf.format(ReleaseDate);

                request.setAttribute("movieId", mvId);
            request.setAttribute("movieName", MovieName);
            request.setAttribute("duration", Duration);
            request.setAttribute("country", Country);
            request.setAttribute("manufacturer", Manufacturer);
            request.setAttribute("director", Director);
            request.setAttribute("imgP", ImgP);
            request.setAttribute("imgL", ImgL);
                request.setAttribute("releaseDate", ReleaseDateString);

                RequestDispatcher dispatcher = request.getRequestDispatcher("MovieDetail.jsp");
                dispatcher.forward(request, response);

            } catch (Exception ex) {
                response.getWriter().println(ex);
            }
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