package Controller;


import Model.Movie;
import Model.MovieDB;
import Model.RoomDB;
import Model.Show;
import Model.ShowDB;
import Model.ShowInfo;
import Model.ShowSeat;
import Model.ShowSeatDB;
import Model.Theatre;
import Model.TheatreDB;
import Model.WorkHistory;
import Model.WorkHistoryDB;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import jakarta.servlet.RequestDispatcher;
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
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
public class MovieServlet extends HttpServlet {
    static String tempName = "";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                handleAddMV(request, response);
                handleUpdateWorkHistory(request, response);
                break;
            case "update":
                handleUpdateMV(request, response);
                handleUpdateWorkHistory(request, response);
                break;
            case "delete":
                handleDeleteMV(request, response);
                handleUpdateWorkHistory(request, response);
                break;
            case "setShow":
                handleSetShow(request, response);
                handleUpdateWorkHistory(request, response);
                break;
            case "booking":
                handleBooking(request, response);
                break;
            case "showSeat":
                handleSetShowSeat(request, response);
                handleUpdateWorkHistory(request, response);
                break;
            case "mvList":
                handlegetMovieList(request, response);
                break;
            case "getShow":
                handleGetShow(request, response);
                break;
            case "getShowInfo":
                handleGetShowInfo(request, response);
                break;
            case "filtermovie":
                handleGetFilterMovieList(request, response);
                break;
            case "search":
                handleSearchMovie(request, response);
                break;
            default:
                response.sendRedirect("error.jsp");
                break;
        }
    }

    private void handleSearchMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchKey = request.getParameter("search");
        String redirectPage = request.getParameter("redirectPage"); // Lấy trang gọi tìm kiếm
        List<Movie> searchResults = new ArrayList<>();

        if (searchKey != null && !searchKey.trim().isEmpty()) {
            MovieDB movieDB = new MovieDB();

            // Chọn phương thức tìm kiếm dựa trên từ khóa
            if (isKeywordSearch(searchKey)) {
                searchResults = movieDB.searchByKeyWord(searchKey);
            } else {
                searchResults = movieDB.searchByName(searchKey);
            }
        }

        // Thiết lập kết quả tìm kiếm và từ khóa cho trang JSP
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("searchKey", searchKey);

        // Sử dụng redirectPage để chuyển hướng đến trang gọi tìm kiếm
        if (redirectPage == null || redirectPage.isEmpty()) {
            redirectPage = "crudMV.jsp"; // Trang mặc định nếu không có redirectPage
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(redirectPage);
        dispatcher.forward(request, response);
    }

    private boolean isKeywordSearch(String searchKey) {
        // Implement your logic to decide if it's a keyword search, e.g., check for spaces or certain characters
        return searchKey.contains(" "); // Example: Treating any input with spaces as a keyword search
    }

    private void handleAddMV(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("movieName");                tempName = name; // Dien add
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

            } catch (IOException ex) {
                System.out.println("Error writing fileP: " + ex.getMessage());

            }
        }

        // Handling imageL file upload
        Part filePartL = request.getPart("imageL");
        String fileNameL = filePartL.getSubmittedFileName();  // Use getSubmittedFileName() to get the original file name
        String uploadPathL = getUploadLDirectory(request);
        String fileURLPathL = "";

        if (fileNameL != null && !fileNameL.isEmpty()) {
            String filePathL = uploadPathL + fileNameL;  // Append the file name to the directory
            fileURLPathL = "image/MovieImg/L/" + fileNameL;
            try {
                filePartL.write(filePathL);  // Save the file
                System.out.println("File uploaded to: " + filePathL);

            } catch (IOException ex) {
                System.out.println("Error writing fileL: " + ex.getMessage());

            }
        }
        try {

            // Create Movie object and store it in DB
            Movie movie = new Movie(null, name, duration, country, manufacturer, director, fileURLPathP, fileURLPathL, releaseDate, des);
            MovieDB.addMovie(movie);
            request.setAttribute("message", "Movie added successfully!");
        } catch (Exception e) {
            // Set error message
            request.setAttribute("message", "Failed to add movie: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("crudMV.jsp").forward(request, response);
        }
    }

    private void handleUpdateMV(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("movieID");
        String name = request.getParameter("movieName");                tempName = name;
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

            } catch (IOException ex) {
                System.out.println("Error writing fileP: " + ex.getMessage());

            }
        }

        // Handling imageL file upload
        Part filePartL = request.getPart("imageL");
        String fileNameL = filePartL.getSubmittedFileName();  // Use getSubmittedFileName() to get the original file name
        String uploadPathL = getUploadLDirectory(request);
        String fileURLPathL = oldMovie.getImgLandscape();

        if (fileNameL != null && !fileNameL.isEmpty()) {
            String filePathL = uploadPathL + fileNameL;  // Append the file name to the directory
            fileURLPathL = "image/MovieImg/L/" + fileNameL;
            try {
                filePartL.write(filePathL);  // Save the file
                System.out.println("File uploaded to: " + filePathL);

            } catch (IOException ex) {
                System.out.println("Error writing fileL: " + ex.getMessage());

            }
        }
        try {
            // Create Movie object and store it in DB
            Movie movie = new Movie(id, name, duration, country, manufacturer, director, fileURLPathP, fileURLPathL, releaseDate, des);
            MovieDB.updateMovie(movie);
            request.setAttribute("message", "Movie update successfully!");
        } catch (Exception e) {
            // Set error message
            request.setAttribute("message", "Failed to update movie: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("crudMV.jsp").forward(request, response);

        }
    }

    private void handleDeleteMV(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieID = request.getParameter("movieID");               tempName = MovieDB.getMovieById(movieID).getMovieName(); //
        try {
            MovieDB.deleteMovie(movieID);
            request.setAttribute("message", "Movie delete successfully!");
        } catch (Exception e) {
            // Set error message
            request.setAttribute("message", "Failed to delete movie: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("crudMV.jsp").forward(request, response);

        }

    }

    private void handleBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Theatre> theatre = TheatreDB.listAllTheatres();
        request.setAttribute("theatres", theatre);
        request.getRequestDispatcher("Booking.jsp").forward(request, response);

    }

    private void handleSetShow(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String movieID = request.getParameter("movieID");
        String dateS = request.getParameter("showDate");
        Date date = Date.valueOf(dateS);
        String timeS = request.getParameter("showTime");
        String formattedTime = timeS + ":00";
        Time time = Time.valueOf(formattedTime);

        System.out.println("Movie ID: " + movieID);
        System.out.println("Show Date: " + dateS);
        System.out.println("Show Time: " + timeS);

        // Create show object and store it in DB
        Show show = new Show(null, date, time, movieID);
        ShowDB.addShow(show);
        request.getRequestDispatcher("crudMV.jsp").forward(request, response);
    }

    private void handleSetShowSeat(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String theatreID = request.getParameter("theatreID");
        String roomID = request.getParameter("roomID");
        String showID = request.getParameter("selectedShowtimeID");             tempName = TheatreDB.getTheatreById(theatreID).getTheatreName() + " in room " + RoomDB.getRoom(roomID).getRoomName() + " at " + ShowDB.getShowById(showID).getShowDate().toString() + " " + ShowDB.getShowById(showID).getShowTime().toString() ; // Dien add
        String getMoney = request.getParameter("money");
        System.out.println(getMoney);
        int money = Integer.parseInt(getMoney);

        List<Movie> movieList = MovieDB.getAllMovies();
        request.setAttribute("movieList", movieList);

        ShowSeatDB.setShowSeat(showID, roomID, theatreID, money);
        request.getRequestDispatcher("TrackingShowTime.jsp").forward(request, response);
    }

    private void handlegetMovieList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Movie> movieList = MovieDB.getAllMovies();
        request.setAttribute("movieList", movieList);
        request.getRequestDispatcher("TrackingShowTime.jsp").forward(request, response);
    }

    protected void handleGetShow(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String movieID = request.getParameter("movieID");
        List<Show> showList = ShowDB.getAllShowsByMovieID(movieID); // Fetch showtimes for the selected movie
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Convert showList to JSON (you can use a library like Gson)
        Gson gson = new Gson();
        String json = gson.toJson(showList);
        response.getWriter().write(json);
    }

    protected void handleGetShowInfo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String roomID = request.getParameter("roomID");
        String date = request.getParameter("date"); // Passed from the front-end

        List<ShowInfo> showInfoList = ShowSeatDB.getShowsByRoomAndDate(roomID, date);

        // Convert the show info list to JSON and send it back to the client
        response.setContentType("application/json");
        response.getWriter().write(new Gson().toJson(showInfoList));
    }

    private void handleUpdateWorkHistory(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        String referer = request.getHeader("referer");

        HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");
        String page = request.getParameter("page");
        String whDes = "";
        LocalDate dateCurr = LocalDate.now();
        LocalTime timeCurr = LocalTime.now();
        Date dateSql = Date.valueOf(dateCurr);
        Time timeSql = Time.valueOf(timeCurr);
        String action = request.getParameter("action");

        WorkHistory whs = new WorkHistory();
        System.out.println("Haha" + page);
        if ((page.equalsIgnoreCase("movie") && !action.equalsIgnoreCase("setShow")) || page.equalsIgnoreCase("food and drink") || page.equalsIgnoreCase("voucher")) {

            whDes = "Action: " + action + " " + page + " " + tempName + ", Affected page: " + page + ", Executor: " + id;

        } else if (page.equalsIgnoreCase("movie") && action.equalsIgnoreCase("setShow")) {
            whDes = "Action: set Show movie " + tempName + ", Affected page: " + page + ", Executor: " + id;
        } else if (action.equalsIgnoreCase("showSeat")) {
            whDes = "Action: set Room in " + tempName + ", Affected page: " + page + ", Executor: " + id;
        }

        whs.setWorkID(WorkHistoryDB.getNextWorkHisId());
        whs.setWorkDes(whDes);
        whs.setDates(dateSql);
        whs.setTimes(timeSql);
        whs.setStaffID(id);

        WorkHistoryDB.addWorkHis(whs);
    }

    protected void handleGetFilterMovieList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String genre = request.getParameter("genre");
        String year = request.getParameter("year");

        List<Movie> listMovie = MovieDB.getFilterMovieList(genre, year);

        request.setAttribute("genre", genre);
        request.setAttribute("year", year);
        request.setAttribute("listMovie", listMovie);
        request.getRequestDispatcher("ListMovie.jsp").forward(request, response);
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