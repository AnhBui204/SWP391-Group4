package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.UserDB.getConnect;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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
        String sql = "INSERT INTO Movies (MovieID, MovieName, Duration, Country, Manufacturer, Director, ReleaseDate, ImgPortrait, ImgLandscape, MovieDescription) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            ps.setString(10, movie.getDescription());
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
                String imgLandscape = rs.getString("ImgLandscape");
                String des = rs.getString("MovieDescription");
                Movie movie = new Movie(movieID, movieName, duration, country, manufacturer, director, imgPortrait, imgLandscape, releaseDate, des);
                movieList.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movieList;
    }

    public List<Movie> getAllMoviesByPage(int page, int moviesPerPage) {
        List<Movie> list = new ArrayList<>();
        int offset = (page - 1) * moviesPerPage;  // Tính toán vị trí bắt đầu (offset)

        // Sửa câu truy vấn cho SQL Server, sử dụng OFFSET và FETCH NEXT
        String query = "SELECT * FROM Movies ORDER BY MovieID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            PreparedStatement ps = getConnect().prepareStatement(query);
            ps.setInt(1, offset);         // Vị trí bắt đầu lấy phim
            ps.setInt(2, moviesPerPage);  // Số phim mỗi trang
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Movie(rs.getString("MovieID"), rs.getString("MovieName"),
                        rs.getInt("Duration"), rs.getString("Country"), rs.getString("Manufacturer"),
                        rs.getString("Director"), rs.getString("ImgPortrait"),
                        rs.getString("ImgLandscape"), rs.getDate("ReleaseDate"), rs.getString("MovieDescription")));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalMovies() {
        String query = "SELECT COUNT(*) FROM Movies";
        try {
            PreparedStatement ps = getConnect().prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);  // Trả về tổng số phim
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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
                String des = rs.getString("MovieDescription");

                return new Movie(movieID, movieName, duration, country, manufacturer, director, imgPortrait, imgLandscape, releaseDate, des);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update a Movie in the database
    public static boolean updateMovie(Movie movie) {
        String sql = "UPDATE Movies SET MovieName = ?, Duration = ?, Country = ?, Manufacturer = ?, Director = ?, ReleaseDate = ?, ImgPortrait = ?, ImgLandscape = ?, MovieDescription = ? WHERE MovieID = ?";
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
            ps.setString(9, movie.getDescription());
            ps.setString(10, movie.getMovieID());  // Điều kiện WHERE MovieID

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

    public static void uploadPImage(String movieID, String PImagePath) {
        String query = "UPDATE Movies SET ImgPortrait = ? WHERE MovieID = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, PImagePath);  // Save the path instead of a BLOB
            stmt.setString(2, movieID);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("ImgPortrait path updated successfully.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Failed to upload avatar ImgPortrait.");
        }
    }

    public static void uploadLImage(String movieID, String LImagePath) {
        String query = "UPDATE Movies SET ImgLandscape = ? WHERE MovieID = ?";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            stmt.setString(1, LImagePath);  // Save the path instead of a BLOB
            stmt.setString(2, movieID);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("ImgLandscape path updated successfully.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
            throw new RuntimeException("Failed to upload ImgLandscape path.");
        }
    }

    public static List<String> getMovieGenre(String movieId) {
        String sql = "select * from MovieGenres inner join Genres on Genres.GenreID = MovieGenres.GenreID where MovieGenres.MovieID = ?";
        List<String> listGenre = new ArrayList<>();
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movieId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                listGenre.add(rs.getString("GenreName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listGenre;
    }

    public static HashMap<String, HashMap<String, List<String>>> getTimelineDB(String movieId) {
        String sql = "select Shows.ShowID, MovieID, ShowDate, StartTime, ShowSeats.TheatreID, TheatreName from Shows inner join ShowSeats on Shows.ShowID = ShowSeats.ShowID inner join Theatres on Theatres.TheatreID = ShowSeats.TheatreID where Shows.MovieID = ? order by ShowDate asc, TheatreName asc";

        List<String> listTime = new ArrayList<>();
        HashMap<String, List<String>> hashTheatreNameList = new HashMap<>();
        HashMap<String, HashMap<String, List<String>>> hashListTime = new HashMap<>();

        Date showDateB4 = new Date(0, 0, 0);
        String theatreNameB4 = null;

        Date showDate = null;
        Time startTime = null;
        String theatreName = null;
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movieId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                showDate = rs.getDate("ShowDate");
                startTime = rs.getTime("StartTime");
                theatreName = rs.getString("TheatreName");

//                System.out.println(showDate.toString());
//                System.out.println(startTime.toString());
                if (listTime.isEmpty()) {
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
                if (showDate.equals(showDateB4)) {
                    if (theatreName.equals(theatreNameB4)) {
                        if (listTime.contains(startTime.toString())) {
                            continue;
                        }
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
            if (!listTime.isEmpty()) {
                hashTheatreNameList.put(theatreNameB4, listTime);
                hashListTime.put(showDateB4.toString(), hashTheatreNameList);
            }
            if (showDate == null) {
                return new HashMap<String, HashMap<String, List<String>>>();
            }
            hashListTime.put(showDate.toString(), hashTheatreNameList);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hashListTime;
    }

//    public static List<Movie> getMoviesByTheatreID(String theatreID) throws SQLException {
//    List<Movie> movies = new ArrayList<>();
//  String sql = "SELECT DISTINCT m.MovieID, m.MovieName, m.ImgPortrait, m.Rate, m.AgeRating " +
//                 "FROM Movies m " +
//                 "JOIN Shows s ON m.MovieID = s.MovieID " +
//                 "JOIN ShowSeats ss ON s.ShowID = ss.ShowID " +
//                 "WHERE ss.TheatreID = ?"; 
//    
//    try (Connection conn = getConnect(); 
//         PreparedStatement stmt = conn.prepareStatement(sql)) {
//        stmt.setString(1, theatreID);
//        ResultSet rs = stmt.executeQuery();
//
//        while (rs.next()) {
//            Movie movie = new Movie();
//            movie.setMovieID(rs.getString("MovieID"));
//            movie.setMovieName(rs.getString("MovieName"));
//            movie.setImgPortrait(rs.getString("ImgPortrait"));
//            movie.setAgeRating(rs.getString("AgeRating"));  
//            movies.add(movie);
//        }
//    }
//
//    return movies;
//}


  public static List<Date> getShowDateByMovieIDAndTheatreID(String movieID, String theatreID) {
        List<Date> showDates = new ArrayList<>();
        String query = "SELECT DISTINCT S.ShowDate " +
                   "FROM Shows S " +
                   "JOIN ShowSeats SS ON S.ShowID = SS.ShowID " +
                   "WHERE S.MovieID = ? AND SS.TheatreID = ?";

        try (Connection connection = getConnect();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
             
            preparedStatement.setString(1, movieID);
            preparedStatement.setString(2, theatreID);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                showDates.add(resultSet.getDate("ShowDate"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ (in ra lỗi)
        }

        return showDates;
    }
    
    public static double getAvgRate(String movieId) {
        String sql = "select round(avg(Rating), 1) as Rating from Ratings where MovieID = ?";
        double avgRate = 0;
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movieId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                avgRate = rs.getDouble("Rating");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return avgRate;
    }

    public static int getNumRate(String movieId) {
        String sql = "select count(UserID) as Line from Ratings where MovieID = ?";
        int numRate = 0;
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movieId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                numRate = rs.getInt("Line");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return numRate;
    }

    public static boolean isUserRate(String userId, String movieId) {
        String sql = "select UserID from Ratings where UserID = ? and MovieID = ?";
        boolean result = false;
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);
            ps.setString(2, movieId);

            ResultSet rs = ps.executeQuery();

            result = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return result;
    }

    public static void addOrUpdateRate(String userId, String movieId, int rate) {

        if (isUserRate(userId, movieId)) {
            String sql = "update Ratings set Rating = ? where UserID = ? and MovieID = ?";  // chua co danh gia

            try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setInt(1, rate);
                ps.setString(2, userId);
                ps.setString(3, movieId);

                ResultSet rs = ps.executeQuery();

            } catch (SQLException e) {
                e.printStackTrace();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } else {
            String sql = "insert into Ratings(UserID, MovieID, Rating) values (?,?,?)";  // chua co danh gia

            try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

                ps.setString(1, userId);
                ps.setString(2, movieId);
                ps.setInt(3, rate);

                ResultSet rs = ps.executeQuery();

            } catch (SQLException e) {
                e.printStackTrace();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

    }
    
    public static List<String> getListActorsByMovieId(String movieId){
        List<String> actorArr = new ArrayList<>();
        String sql = "select Actors.ActorName from MovieActors inner join Actors on MovieActors.ActorID = Actors.ActorID where MovieActors.MovieID = ?";
        try (Connection conn = getConnect(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movieId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                actorArr.add(rs.getString("ActorName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return actorArr;
    }
    
  
   public static List<Movie> getMoviesByTheatreID(String theatreID) throws SQLException {
    List<Movie> movies = new ArrayList<>();
  String sql = "SELECT DISTINCT m.MovieID, m.MovieName, m.ImgPortrait, m.Rate " +
                 "FROM Movies m " +
                 "JOIN Shows s ON m.MovieID = s.MovieID " +
                 "JOIN ShowSeats ss ON s.ShowID = ss.ShowID " +
                 "WHERE ss.TheatreID = ?"; 
    
    try (Connection conn = getConnect(); 
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, theatreID);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Movie movie = new Movie();
            movie.setMovieID(rs.getString("MovieID"));
            movie.setMovieName(rs.getString("MovieName"));
            movie.setImgPortrait(rs.getString("ImgPortrait"));        
            movies.add(movie);
        }
    }

    return movies;
}

    
    public static void main(String[] args) {

        // Lấy danh sách tất cả các bộ phim
        System.out.println("\nDanh sách tất cả các bộ phim:");
        List<Movie> movies = MovieDB.getAllMovies();
        for (Movie movie : movies) {
            System.out.println(movie);
        }

//        HashMap<String, HashMap<String, List<String>>> hm = getTimelineDB("M00001");
//        
//        System.out.println(hm.size());
//        
//        for(String str: hm.keySet()){
//            System.out.println(str);
//            HashMap<String, List<String>> hmm = hm.get(str);
//            System.out.println(hmm.size());
//            for (String strr: hmm.keySet()){
//                System.out.println(strr);
//                System.out.println(hmm.get(strr));
//            }
//        }
        
    }

}