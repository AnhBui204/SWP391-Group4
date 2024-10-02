package Model;

import java.io.Serializable;

public class Seat implements Serializable {

    private String seatID;
    private String seatName;
    private String RoomID;
    private String TheatreID;

    public Seat() {
    }

    public Seat(String seatID, String seatName, String RoomID, String TheatreID) {
        this.seatID = seatID;
        this.seatName = seatName;
        this.RoomID = RoomID;
        this.TheatreID = TheatreID;
    }

    public String getSeatID() {
        return seatID;
    }

    public void setSeatID(String seatID) {
        this.seatID = seatID;
    }

    public String getSeatName() {
        return seatName;
    }

    public void setSeatName(String seatName) {
        this.seatName = seatName;
    }

    public String getRoomID() {
        return RoomID;
    }

    public void setRoomID(String RoomID) {
        this.RoomID = RoomID;
    }

    public String getTheatreID() {
        return TheatreID;
    }

    public void setTheatreID(String TheatreID) {
        this.TheatreID = TheatreID;
    }

    @Override
    public String toString() {
        return "Seat{" + "seatID=" + seatID + ", seatName=" + seatName + ", RoomID=" + RoomID + ", TheatreID=" + TheatreID + '}';
    }
    
    
    
}
