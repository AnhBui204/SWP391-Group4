package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class MovieDB {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            return con;
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }

    public static String getNextMovieID() {
        String sql = "SELECT 'M' + RIGHT('00000' + CAST(CAST(SUBSTRING(MAX(MovieID), 2, 5) AS INT) + 1 AS VARCHAR(5)), 5) AS NextID FROM Movies";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("NextID");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Nếu không có ID nào trước đó, trả về 'M00001' (ID đầu tiên)
        return "M00001";
    }

    // Add Movie to the database
    public static boolean addMovie(Movie movie) {
        String sql = "INSERT INTO Movies (MovieID, MovieName, Duration, Country, Manufacturer, Director, ReleaseDate, ImgPortrait, ImgLandscape) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            // Lấy MovieID tiếp theo
            String nextMovieID = getNextMovieID();

            // Set các giá trị cho PreparedStatement
            ps.setString(1, nextMovieID);  // MovieID mới
            ps.setString(2, movie.getMovieName());
            ps.setInt(3, movie.getDuration());
            ps.setString(4, movie.getCountry());
            ps.setString(5, movie.getManufacturer());
            ps.setString(6, movie.getDirector());
            ps.setDate(7, movie.getReleaseDate());
            ps.setString(8, movie.getImgPortrait());
            ps.setString(9, movie.getImgLandscape());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get all Movies from the database
    public static List<Movie> getAllMovies() {
        List<Movie> movieList = new ArrayList<>();
        String sql = "SELECT * FROM Movies";
        try (Connection conn = getConnect(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                String movieID = rs.getString("MovieID");
                String movieName = rs.getString("MovieName");
                int duration = rs.getInt("Duration");
                String country = rs.getString("Country");
                String manufacturer = rs.getString("Manufacturer");
                String director = rs.getString("Director");
                Date releaseDate = rs.getDate("ReleaseDate");
                String imgPortrait = rs.getString("ImgPortrait");
                String imgLandscape = rs.getString("ImgPortrait");

                Movie movie = new Movie(movieID, movieName, duration, country, manufacturer, director, imgPortrait, imgLandscape, releaseDate);
                movieList.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movieList;
    }

    // Get a Movie by ID
    public static Movie getMovieById(String movieID) {
        String sql = "SELECT * FROM Movies WHERE MovieID = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movieID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String movieName = rs.getString("MovieName");
                int duration = rs.getInt("Duration");
                String country = rs.getString("Country");
                String manufacturer = rs.getString("Manufacturer");
                String director = rs.getString("Director");
                String imgPortrait = rs.getString("ImgPortrait");
                String imgLandscape = rs.getString("ImgLandscape");
                Date releaseDate = rs.getDate("ReleaseDate");

                return new Movie(movieID, movieName, duration, country, manufacturer, director, imgPortrait, imgLandscape, releaseDate);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update a Movie in the database
    public static boolean updateMovie(Movie movie) {
        String sql = "UPDATE Movies SET MovieName = ?, Duration = ?, Country = ?, Manufacturer = ?, Director = ?, ReleaseDate = ?, ImgPortrait = ?, ImgLandscape = ? WHERE MovieID = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            // Set các giá trị cần cập nhật cho PreparedStatement
            ps.setString(1, movie.getMovieName());
            ps.setInt(2, movie.getDuration());
            ps.setString(3, movie.getCountry());
            ps.setString(4, movie.getManufacturer());
            ps.setString(5, movie.getDirector());
            ps.setDate(6, movie.getReleaseDate());
            ps.setString(7, movie.getImgPortrait());
            ps.setString(8, movie.getImgLandscape());
            ps.setString(9, movie.getMovieID());  // Điều kiện WHERE MovieID

            return ps.executeUpdate() > 0;  // Nếu có dòng nào bị ảnh hưởng thì trả về true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean deleteMovie(String movieID) {
        String sql = "DELETE FROM Movies WHERE MovieID = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            // Set MovieID để xác định bộ phim cần xóa
            ps.setString(1, movieID);

            return ps.executeUpdate() > 0;  // Nếu có dòng nào bị xóa thì trả về true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Rate a Movie
    public static boolean rateMovie(Rating rating) {
        String sql = "INSERT INTO Ratings (UserID, MovieID, Rating) VALUES (?, ?, ?)";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, rating.getUserID());
            ps.setString(2, rating.getMovieID());
            ps.setDouble(3, rating.getRatingValue());

            boolean result = ps.executeUpdate() > 0;
            if (result) {
                // After rating, update the movie's average rate
                updateMovieRate(rating.getMovieID());
            }
            return result;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update the movie's average rating
    public static void updateMovieRate(String movieID) {
        String sql = "UPDATE Movies SET Rate = (SELECT AVG(Rating) FROM Ratings WHERE MovieID = ?) WHERE MovieID = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movieID);
            ps.setString(2, movieID);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static List<String> getMovieGenre(String movieId){
        String sql = "select * from MovieGenres inner join Genres on Genres.GenreID = MovieGenres.GenreID where MovieGenres.MovieID = ?";
        List<String> listGenre = new ArrayList<>();
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movieId);

            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                listGenre.add(rs.getString("GenreName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listGenre;
    }

    public static HashMap<String, HashMap<String, List<String>>> getTimelineDB(String movieId){
        String sql = "select Shows.ShowID, MovieID, ShowDate, StartTime, ShowSeats.TheatreID, TheatreName from Shows inner join ShowSeats on Shows.ShowID = ShowSeats.ShowID inner join Theatres on Theatres.TheatreID = ShowSeats.TheatreID where Shows.MovieID = ? order by ShowDate asc, TheatreName asc";
        
        List<String> listTime = new ArrayList<>();
        HashMap <String, List<String>> hashTheatreNameList = new HashMap<>();
        HashMap <String, HashMap<String, List<String>>> hashListTime = new HashMap<>();
        
        Date showDateB4 = new Date(0,0,0);
        String theatreNameB4 = null;
        
        Date showDate = null;
        Time startTime = null;
        String theatreName = null;
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movieId);

            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                showDate = rs.getDate("ShowDate");
                startTime = rs.getTime("StartTime");
                theatreName = rs.getString("TheatreName");
                
//                System.out.println(showDate.toString());
//                System.out.println(startTime.toString());
                if (listTime.isEmpty()){
                    showDateB4 = showDate;
                    theatreNameB4 = theatreName;
                }
                
//                if (showDate.equals(showDateB4)){
//                    if (listTime.contains(startTime.toString()))
//                        continue;
//                    listTime.add(startTime.toString());
//                    continue;
//                }
//                hashListTime.put(showDateB4.toString(), listTime);
//                listTime = new ArrayList<>();
//                listTime.add(startTime.toString());
//                showDateB4 = showDate; 
                if (showDate.equals(showDateB4)){
                    if (theatreName.equals(theatreNameB4)){
                        if (listTime.contains(startTime.toString()))
                            continue;
                        listTime.add(startTime.toString());
                        continue;
                    }
                    hashTheatreNameList.put(theatreNameB4, listTime);
                    listTime = new ArrayList<>();
                    listTime.add(startTime.toString());
                    
                    theatreNameB4 = theatreName;
                    continue;
                }
                hashTheatreNameList.put(theatreNameB4, listTime);
                hashListTime.put(showDateB4.toString(), hashTheatreNameList);
                hashTheatreNameList = new HashMap<>();
                listTime = new ArrayList<>();
                listTime.add(startTime.toString());
                
                showDateB4 = showDate; 
                theatreNameB4 = theatreName;
            }
            if (!hashTheatreNameList.isEmpty()){
                hashTheatreNameList.put(theatreNameB4, listTime);
                hashListTime.put(showDateB4.toString(), hashTheatreNameList);
            }
            if (showDate == null)
                return new HashMap<String, HashMap<String, List<String>>>();
            hashListTime.put(showDate.toString(), hashTheatreNameList);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hashListTime;
    }
    
    public static double getAvgRate(){
        String sql = "";
    }
    
    public static void main(String[] args) {
        // Thêm một bộ phim mới
//        System.out.println("Thêm bộ phim mới:");
//        Movie newMovie = new Movie(null, "Inception", 148, "USA", "Warner Bros", "Christopher Nolan", "inception_portrait.jpg", "inception_landscape.jpg",  Date.valueOf("2010-07-16"));
//        if (MovieDB.addMovie(newMovie)) {
//            System.out.println("Thêm bộ phim thành công!");
//        } else {
//            System.out.println("Thêm bộ phim thất bại!");
//        }

//        // Lấy danh sách tất cả các bộ phim
//        System.out.println("\nDanh sách tất cả các bộ phim:");
//        List<Movie> movies = MovieDB.getAllMovies();
//        for (Movie movie : movies) {
//            System.out.println(movie);
//        }
//
//        Movie fetchedMovie = MovieDB.getMovieById("M00016");
//        if (fetchedMovie != null) {
//            System.out.println("Bộ phim: " + fetchedMovie);
//        } else {
//            System.out.println("Không tìm thấy bộ phim với ID 'M00016'.");
//        }
//
//        // Cập nhật bộ phim
//        System.out.println("\nCập nhật bộ phim:");
//        if (fetchedMovie != null) {
//            fetchedMovie.setMovieName("Inception (Updated)");
//            fetchedMovie.setDuration(150);  // Thay đổi thời gian
//            if (MovieDB.updateMovie(fetchedMovie)) {
//                System.out.println("Cập nhật bộ phim thành công!");
//                System.out.println(fetchedMovie);
//            } else {
//                System.out.println("Cập nhật bộ phim thất bại!");
//            }
//        }
//
//        // Xóa bộ phim
//        System.out.println("\nXóa bộ phim với ID 'M00001':");
//        if (MovieDB.deleteMovie("M00001")) {
//            System.out.println("Xóa bộ phim thành công!");
//        } else {
//            System.out.println("Xóa bộ phim thất bại!");
//        }
//
//        // Kiểm tra lại danh sách bộ phim sau khi xóa
//        System.out.println("\nDanh sách tất cả các bộ phim sau khi xóa:");
//        movies = MovieDB.getAllMovies();
//        for (Movie movie : movies) {
//            System.out.println(movie);
//        }
//        List<String> listGenre = getMovieGenre("M00001");
//        for(String str: listGenre){
//            System.out.print(str);
//        }

        HashMap<String, HashMap<String, List<String>>> hm = getTimelineDB("M00001");
        
        System.out.println(hm.size());
        
        for(String str: hm.keySet()){
            System.out.println(str);
            HashMap<String, List<String>> hmm = hm.get(str);
            System.out.println(hmm.size());
            for (String strr: hmm.keySet()){
                System.out.println(strr);
                System.out.println(hmm.get(strr));
            }
        }
            
    }

}
