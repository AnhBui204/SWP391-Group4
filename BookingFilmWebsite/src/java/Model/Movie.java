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
    private String manufacturer;
    private String director;
    private Date releaseDate;
    private String imgPortrait;
    private String imgLandscape;
    private String movieDescription;
    private double rate;
    private String AgeRating;
    public Movie() {
    }


    public Movie(String movieID, String movieName, int duration, String country, String manufacturer, 
                 String director, Date releaseDate, String imgPortrait, String imgLandscape, 
                 String movieDescription, double rate, String AgeRating) {
        this.movieID = movieID;
        this.movieName = movieName;
        this.duration = duration;
        this.country = country;
        this.manufacturer = manufacturer;
        this.director = director;
        this.releaseDate = releaseDate;
        this.imgPortrait = imgPortrait;
        this.imgLandscape = imgLandscape;
        this.movieDescription = movieDescription;
        this.rate = rate;
        this.AgeRating=AgeRating;
    }

    public String getAgeRating() {
        return AgeRating;
    }

    public void setAgeRating(String AgeRating) {
        this.AgeRating = AgeRating;
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

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public String getImgPortrait() {
        return imgPortrait;
    }

    public void setImgPortrait(String imgPortrait) {
        this.imgPortrait = imgPortrait;
    }

    public String getImgLandscape() {
        return imgLandscape;
    }

    public void setImgLandscape(String imgLandscape) {
        this.imgLandscape = imgLandscape;
    }

    public String getMovieDescription() {
        return movieDescription;
    }

    public void setMovieDescription(String movieDescription) {
        this.movieDescription = movieDescription;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    @Override
    public String toString() {
        return "Movie{" + "movieID=" + movieID + ", movieName=" + movieName + ", duration=" + duration + ", country=" + country + ", manufacturer=" + manufacturer + ", director=" + director + ", releaseDate=" + releaseDate + ", imgPortrait=" + imgPortrait + ", imgLandscape=" + imgLandscape + ", movieDescription=" + movieDescription + ", rate=" + rate + '}';
    }
    
}
