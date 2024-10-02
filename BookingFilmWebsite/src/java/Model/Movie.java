/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.sql.Date;

public class Movie {
    
    private String movieID;
    private String movieName;
    private int duration;
    private String country;
    private String director;
    private String movieType;
    private Date releaseDate;
    private double rate;

    public Movie() {
    }

    public Movie(String movieID, String movieName, int duration, String country, String director, String movieType, Date releaseDate, double rate) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.duration = duration;
        this.country = country;
        this.director = director;
        this.movieType = movieType;
        this.releaseDate = releaseDate;
        this.rate = rate;
    }

    public String getMovieID() {
        return movieID;
    }

    public void setMovieID(String movieID) {
        this.movieID = movieID;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getMovieType() {
        return movieType;
    }

    public void setMovieType(String movieType) {
        this.movieType = movieType;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    @Override
    public String toString() {
        return "Movie{" + "movieID=" + movieID + ", movieName=" + movieName + ", duration=" + duration + ", country=" + country + ", director=" + director + ", movieType=" + movieType + ", releaseDate=" + releaseDate + ", rate=" + rate + '}';
    }
    
    
}
