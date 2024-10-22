
package Model;
public class SeatDetail {
    private String seatName;
    private int isAvailables;
    private int price;

    public SeatDetail(String seatName,int isAvailables, int price) {
        this.seatName = seatName;
        this.isAvailables = isAvailables;
        this.price = price;
    }

    public String getSeatName() {
        return seatName;
    }

    public void setSeatName(String seatName) {
        this.seatName = seatName;
    }

    public int getIsAvailables() {
        return isAvailables;
    }

    public void setIsAvailables(int isAvailables) {
        this.isAvailables = isAvailables;
    }



    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Seat: " + seatName + ", Available: " + isAvailables + ", Price: " + price;
    }



}
