
package Model;

import java.time.LocalDateTime;



public class Show {
    
    private String showID;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String movieID;

    public Show() {
    }

    public Show(String showID, LocalDateTime startTime, LocalDateTime endTime, String movieID) {
        this.showID = showID;
        this.startTime = startTime;
        this.endTime = endTime;
        this.movieID = movieID;
    }

    public String getShowID() {
        return showID;
    }

    public void setShowID(String showID) {
        this.showID = showID;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalDateTime startTime) {
        this.startTime = startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public String getMovieID() {
        return movieID;
    }

    public void setMovieID(String movieID) {
        this.movieID = movieID;
    }

    @Override
    public String toString() {
        return "Show{" + "showID=" + showID + ", startTime=" + startTime + ", endTime=" + endTime + ", movieID=" + movieID + '}';
    }
    
    
}
