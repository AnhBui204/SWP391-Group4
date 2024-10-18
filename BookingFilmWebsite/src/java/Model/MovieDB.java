package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import java.sql.*;
import java.util.ArrayList;
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



  
   public static List<Movie> getMoviesByTheatreID(String theatreID) throws SQLException {
    List<Movie> movies = new ArrayList<>();
  String sql = "SELECT DISTINCT m.MovieID, m.MovieName, m.ImgPortrait, m.Rate, m.AgeRating " +
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
            movie.setAgeRating(rs.getString("AgeRating"));  
            movies.add(movie);
        }
    }

    return movies;
}


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




    // Delete a Movie from the database
    public static boolean deleteMovie(String movieID) {
        String sql = "DELETE FROM Movies WHERE MovieID = ?";
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, movieID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
  public static void main(String[] args) {
        // Thay thế theatreID bằng ID của rạp mà bạn muốn truy vấn
        String theatreID = "T00002"; // Ví dụ ID rạp

        try {
            List<Movie> movies = MovieDB.getMoviesByTheatreID(theatreID);
            for (Movie movie : movies) {
                System.out.println("Movie ID: " + movie.getMovieID());
                System.out.println("Movie Name: " + movie.getMovieName());
                System.out.println("Rate: " + movie.getRate());
                System.out.println("R:"+movie.getAgeRating());
                System.out.println("Imgae" +movie.getImgPortrait());
                System.out.println("---------------------------");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // In ra lỗi nếu có
        }
    }
}

