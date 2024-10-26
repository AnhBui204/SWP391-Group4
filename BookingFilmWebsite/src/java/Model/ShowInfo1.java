package Model;
import java.math.BigDecimal;
import java.util.Date;
public class ShowInfo1 {
    private String TicketID;
 private String theatreName;
    private String seatName;
    private Date showDate;
    private String startTime;
    private String roomName;
    private int price;
    private String movieName;
    private String status;
     public ShowInfo1(String TicketID,String theatreName, String seatName, Date showDate, String startTime, String roomName, int price, String movieName, String status) {
         this.TicketID=TicketID;
        this.theatreName = theatreName;
        this.seatName = seatName;
        this.showDate = showDate;
        this.startTime = startTime;
        this.roomName = roomName;
        this.price = price;
        this.movieName = movieName;
        this.status = status; 
    }

    public String getTicketID() {
        return TicketID;
    }

    public void setTicketID(String TicketID) {
        this.TicketID = TicketID;
    }
    public String getTheatreName() {
        return theatreName;
    }

    public String getSeatName() {
        return seatName;
    }

    public Date getShowDate() {
        return showDate;
    }

    public String getStartTime() {
        return startTime;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getRoomName() {
        return roomName;
    }
      public String getMovieName() {
        return movieName;
    }

    public void setMovieName(String movieName) {
        this.movieName = movieName;
    }
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}