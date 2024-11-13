package Model;

import java.util.Date;

/**
 *
 * @author DELL
 */
public class Revenue {
    
    private Date bookingDate;
    private int totalRevenue;
    private String theatreName;

    public String getTheatreName() {
        return theatreName;
    }

    public void setTheatreName(String theatreName) {
        this.theatreName = theatreName;
    }

    public Revenue(Date bookingDate, int totalRevenue) {
        this.bookingDate = bookingDate;
        this.totalRevenue = totalRevenue;
    }

    public Revenue() {
    }
    
    public Revenue(Date bookingDate, int totalRevenue, String theatreName){
        this.bookingDate = bookingDate;
        this.totalRevenue = totalRevenue;
        this.theatreName = theatreName;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public void setTotalRevenue(int totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    @Override
    public String toString() {
        return "RevenueData{" + "bookingDate=" + bookingDate + ", totalRevenue=" + totalRevenue + '}';
    }

    
}