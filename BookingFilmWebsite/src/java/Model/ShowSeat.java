package Model;

public class ShowSeat {

    private String showID;
    private String seatID;
    private String roomID;
    private String theatreID;
    private int price;
    private int isAvailable;

    public ShowSeat() {
    }

    public ShowSeat(String showID, String seatID, String roomID, String theatreID, int price, int isAvailable) {
        this.showID = showID;
        this.seatID = seatID;
        this.roomID = roomID;
        this.theatreID = theatreID;
        this.price = price;
        this.isAvailable = isAvailable;
    }

    public String getShowID() {
        return showID;
    }

    public void setShowID(String showID) {
        this.showID = showID;
    }

    public String getSeatID() {
        return seatID;
    }

    public void setSeatID(String seatID) {
        this.seatID = seatID;
    }

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public String getTheatreID() {
        return theatreID;
    }

    public void setTheatreID(String theatreID) {
        this.theatreID = theatreID;
    }

    public int getIsAvailable() {
        return isAvailable;
    }

    public void setIsAvailable(int isAvailable) {
        this.isAvailable = isAvailable;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "ShowSeat{" + "showID=" + showID + ", seatID=" + seatID + ", roomID=" + roomID + ", theatreID=" + theatreID + ", price=" + price + ", isAvailable=" + isAvailable + '}';
    }
    
    
}
