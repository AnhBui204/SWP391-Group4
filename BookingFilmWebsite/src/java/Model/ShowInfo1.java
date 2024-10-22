package Model;
import java.math.BigDecimal;
import java.util.Date;

public class ShowInfo1 {
    private String theatreName;
    private String seatName;
    private Date showDate;
    private String startTime;
    private String roomName;
     private BigDecimal price; 
    public ShowInfo1(String theatreName, String seatName, Date showDate, String startTime, String roomName, BigDecimal price) {
        this.theatreName = theatreName;
        this.seatName = seatName;
        this.showDate = showDate;
        this.startTime = startTime;
        this.roomName = roomName;
         this.price = price;
    }

    // Getter và Setter
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getRoomName() {
        return roomName;
    }
}
