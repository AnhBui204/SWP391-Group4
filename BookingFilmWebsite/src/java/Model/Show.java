
package Model;

import java.time.LocalDate;
import java.time.LocalTime;



public class Show {
    
    private String showID;
    private LocalDate showDate;
    private LocalTime startTime;
    private String movieID;

    public Show() {
    }

    public Show(String showID,LocalDate showDate ,LocalTime startTime,  String movieID) {
        this.showID = showID;
        this.showDate=showDate;
        this.startTime = startTime;

        this.movieID = movieID;
    }

    public LocalDate getShowDate() {
        return showDate;
    }

    public void setShowDate(LocalDate showDate) {
        this.showDate = showDate;
    }

    public String getShowID() {
        return showID;
    }

    public void setShowID(String showID) {
        this.showID = showID;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }



    public String getMovieID() {
        return movieID;
    }

    public void setMovieID(String movieID) {
        this.movieID = movieID;
    }

    @Override
    public String toString() {
        return "Show{" + "showID=" + showID + ", startTime=" + startTime  + ", movieID=" + movieID + '}';
    }
    
    
}
