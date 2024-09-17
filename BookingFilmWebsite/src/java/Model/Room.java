
package Model;

public class Room {
    private String roomID;
    private String roomName;
    private String cinemaID;

    public Room() {
    }

    public Room(String roomID, String roomName, String cinemaID) {
        this.roomID = roomID;
        this.roomName = roomName;
        this.cinemaID = cinemaID;
    }

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getCinemaID() {
        return cinemaID;
    }

    public void setCinemaID(String cinemaID) {
        this.cinemaID = cinemaID;
    }

    @Override
    public String toString() {
        return "Room{" + "roomID=" + roomID + ", roomName=" + roomName + ", cinemaID=" + cinemaID + '}';
    }

   
}
