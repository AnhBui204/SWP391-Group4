
package Model;

import java.sql.*;



public class Show {
    
    private String showID;
    private Date showDate;
    private Time showTime;
    private String movieID;

    public Show() {
    }

    public Show(String showID, Date showDate, Time showTime, String movieID) {
        this.showID = showID;
        this.showDate = showDate;
        this.showTime = showTime;
        this.movieID = movieID;
    }

    public String getShowID() {
        return showID;
    }

    public void setShowID(String showID) {
        this.showID = showID;
    }

    public Date getShowDate() {
        return showDate;
    }

    public void setShowDate(Date showDate) {
        this.showDate = showDate;
    }

    public Time getShowTime() {
        return showTime;
    }

    public void setShowTime(Time showTime) {
        this.showTime = showTime;
    }

    public String getMovieID() {
        return movieID;
    }

    public void setMovieID(String movieID) {
        this.movieID = movieID;
    }

    @Override
    public String toString() {
        return "Show{" + "showID=" + showID + ", showDate=" + showDate + ", showTime=" + showTime + ", movieID=" + movieID + '}';
    }
    
}