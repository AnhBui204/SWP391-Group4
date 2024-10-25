/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;


public class TicketDetails {
    private String ticketID;
    private String showName;
    private String seatName;
    private String comboName;
    private String voucherName;
    private double price;
    private String status;
    private Date bookingDate;

    // Constructor
    
    public TicketDetails() {
    }

    public TicketDetails(String ticketID, String showName, String seatName, String comboName, String voucherName, double price,String status, Date bookingDate) {
        this.ticketID = ticketID;
        this.showName = showName;
        this.seatName = seatName;
        this.comboName = comboName;
        this.voucherName = voucherName;
        this.price = price;
        this.status = status;
        this.bookingDate = bookingDate;
    }

    public String getTicketID() {
        return ticketID;
    }

    public void setTicketID(String ticketID) {
        this.ticketID = ticketID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getShowName() {
        return showName;
    }

    public void setShowName(String showName) {
        this.showName = showName;
    }

    public String getSeatName() {
        return seatName;
    }

    public void setSeatName(String seatName) {
        this.seatName = seatName;
    }

    public String getComboName() {
        return comboName;
    }

    public void setComboName(String comboName) {
        this.comboName = comboName;
    }

    public String getVoucherName() {
        return voucherName;
    }

    public void setVoucherName(String voucherName) {
        this.voucherName = voucherName;
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
        return "TicketDetails{" + "ticketID=" + ticketID + " showName=" + showName + ", seatName=" + seatName + ", comboName=" + comboName + ", voucherID=" + voucherName + ", price=" + price + ", bookingDate=" + bookingDate + '}';
    }
    
    
}
