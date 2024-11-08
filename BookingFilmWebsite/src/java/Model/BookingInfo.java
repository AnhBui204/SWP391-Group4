package Model;

public class BookingInfo {

    private String bookingID;
    private String bookingDate;
    private double totalPrice;
    private String status;

    public BookingInfo(String bookingID, String bookingDate, double totalPrice, String status) {
        this.bookingID = bookingID;
        this.bookingDate = bookingDate;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
