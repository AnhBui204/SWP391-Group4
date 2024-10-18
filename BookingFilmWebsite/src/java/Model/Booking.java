/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.sql.Date;

public class Booking {
    private String bookingID;
    private String userID;
    private String ticketID;
    private String comboID;
    private Date bookingDate;

    public Booking() {
    }

    public Booking(String bookingID, String userID, String ticketID, String comboID, Date bookingDate) {
        this.bookingID = bookingID;
        this.userID = userID;
        this.ticketID = ticketID;
        this.comboID = comboID;
        this.bookingDate = bookingDate;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getTicketID() {
        return ticketID;
    }

    public void setTicketID(String ticketID) {
        this.ticketID = ticketID;
    }

    public String getComboID() {
        return comboID;
    }

    public void setComboID(String comboID) {
        this.comboID = comboID;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    @Override
    public String toString() {
        return "Booking{" + "bookingID=" + bookingID + ", userID=" + userID + ", ticketID=" + ticketID + ", comboID=" + comboID + ", bookingDate=" + bookingDate + '}';
    }
    
    
}
