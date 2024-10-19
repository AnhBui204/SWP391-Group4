
package Model;
import java.sql.*;

public class ShowInfo {
    private String showID;
    private String movieName;
    private Date showDateValue;
    private Time startTime;

    public ShowInfo() {
    }

    public ShowInfo(String showID, String movieName, Date showDateValue, Time startTime) {
        this.showID = showID;
        this.movieName = movieName;
        this.showDateValue = showDateValue;
        this.startTime = startTime;
    }

    public String getShowID() {
        return showID;
    }

    public void setShowID(String showID) {
        this.showID = showID;
    }

    public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }

    public Date getShowDateValue() {
        return showDateValue;
    }

    public void setShowDateValue(Date showDateValue) {
        this.showDateValue = showDateValue;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    @Override
    public String toString() {
        return "ShowInfo{" + "showID=" + showID + ", movieName=" + movieName + ", showDateValue=" + showDateValue + ", startTime=" + startTime + '}';
    }

    
    
    
    
}
