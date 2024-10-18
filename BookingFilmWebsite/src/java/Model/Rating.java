package Model;

import java.sql.Date;

public class Rating {
    private String userID;
    private String movieID;
    private double ratingValue;
    private Date ratingDate;

    public Rating(String userID, String movieID, double ratingValue, Date ratingDate) {
        this.userID = userID;
        this.movieID = movieID;
        this.ratingValue = ratingValue;
        this.ratingDate = ratingDate;
    }

    public String getUserID() {
        return userID;
    }

    public String getMovieID() {
        return movieID;
    }

    public double getRatingValue() {
        return ratingValue;
    }

    public Date getRatingDate() {
        return ratingDate;
    }

    @Override
    public String toString() {
        return "Rating{" +
                "userID='" + userID + '\'' +
                ", movieID='" + movieID + '\'' +
                ", ratingValue=" + ratingValue +
                ", ratingDate=" + ratingDate +
                '}';
    }
}
