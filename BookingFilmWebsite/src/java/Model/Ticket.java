/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.io.Serializable;
import java.util.Date;

public class Ticket implements Serializable {
    
    private String ticketID;
    private String bookingID;
    private String showID;
    private String seatID;
    private String comboID;
    private String voucherID;
    private double price;
    private Date bookingDate;

    public Ticket() {
    }

    public Ticket(String ticketID, String bookingID, String showID, String seatID, String comboID, String voucherID, double price, Date bookingDate) {
        this.ticketID = ticketID;
        this.bookingID = bookingID;
        this.showID = showID;
        this.seatID = seatID;
        this.comboID = comboID;
        this.voucherID = voucherID;
        this.price = price;
        this.bookingDate = bookingDate;
    }

    public String getTicketID() {
        return ticketID;
    }

    public void setTicketID(String ticketID) {
        this.ticketID = ticketID;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
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

    public String getComboID() {
        return comboID;
    }

    public void setComboID(String comboID) {
        this.comboID = comboID;
    }

    public String getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(String voucherID) {
        this.voucherID = voucherID;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    @Override
    public String toString() {
        return "Ticket{" + "ticketID=" + ticketID + ", bookingID=" + bookingID + ", showID=" + showID + ", seatID=" + seatID + ", comboID=" + comboID + ", voucherID=" + voucherID + ", price=" + price + ", bookingDate=" + bookingDate + '}';
    }
    
    
}
