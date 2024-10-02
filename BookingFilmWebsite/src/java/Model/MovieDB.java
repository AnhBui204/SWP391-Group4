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

    // Add Movie to the database
    public static boolean addMovie(Movie movie) {
        String sql = "INSERT INTO Movies (MovieID, MovieName, Duration, Country, Director, MovieType, ReleaseDate, Rate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, movie.getMovieID());
            ps.setString(2, movie.getMovieName());
            ps.setInt(3, movie.getDuration());
            ps.setString(4, movie.getCountry());
            ps.setString(5, movie.getDirector());
            ps.setString(6, movie.getMovieType());
            ps.setDate(7, movie.getReleaseDate());
            ps.setDouble(8, movie.getRate());
            
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
        try (Connection conn = getConnect();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
             
            while (rs.next()) {
                String movieID = rs.getString("MovieID");
                String movieName = rs.getString("MovieName");
                int duration = rs.getInt("Duration");
                String country = rs.getString("Country");
                String director = rs.getString("Director");
                String movieType = rs.getString("MovieType");
                Date releaseDate = rs.getDate("ReleaseDate");
                double rate = rs.getDouble("Rate");
                
                Movie movie = new Movie(movieID, movieName, duration, country, director, movieType, releaseDate, rate);
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
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, movieID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String movieName = rs.getString("MovieName");
                int duration = rs.getInt("Duration");
                String country = rs.getString("Country");
                String director = rs.getString("Director");
                String movieType = rs.getString("MovieType");
                Date releaseDate = rs.getDate("ReleaseDate");
                double rate = rs.getDouble("Rate");
                
                return new Movie(movieID, movieName, duration, country, director, movieType, releaseDate, rate);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update a Movie in the database
    public static boolean updateMovie(Movie movie) {
        String sql = "UPDATE Movies SET MovieName = ?, Duration = ?, Country = ?, Director = ?, MovieType = ?, ReleaseDate = ?, Rate = ? WHERE MovieID = ?";
        try (Connection conn = getConnect();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setString(1, movie.getMovieName());
            ps.setInt(2, movie.getDuration());
            ps.setString(3, movie.getCountry());
            ps.setString(4, movie.getDirector());
            ps.setString(5, movie.getMovieType());
            ps.setDate(6, movie.getReleaseDate());
            ps.setDouble(7, movie.getRate());
            ps.setString(8, movie.getMovieID());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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
        // Adding a movie
        Movie newMovie = new Movie("M12345", "Inception", 148, "USA", "Christopher Nolan", "Sci-Fi", Date.valueOf("2010-07-16"), 8.8);
        MovieDB.addMovie(newMovie);
        
        // Listing all movies
        List<Movie> movies = MovieDB.getAllMovies();
        for (Movie movie : movies) {
            System.out.println(movie);
        }
        
        // Fetching a single movie by ID
        Movie fetchedMovie = MovieDB.getMovieById("M12345");
        System.out.println(fetchedMovie);
        
        // Updating a movie
        fetchedMovie.setRate(9.0);
        MovieDB.updateMovie(fetchedMovie);
        System.out.println(fetchedMovie);
        // Deleting a movie
        MovieDB.deleteMovie("M12345");
    }

}
