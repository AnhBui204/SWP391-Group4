/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

public class Ticket implements Serializable {
  private String ticketID;
    private String bookingID;
    private String userID;
    private String bookingSeatID;
    private String roomID;
    private String bookingComboID;
    private Date bookingDate;
    private BigDecimal totalPrice;

    public Ticket() {
    }
 public Ticket(String ticketID, String bookingID, String userID, String bookingSeatID, String roomID, String bookingComboID, Date bookingDate, BigDecimal totalPrice) {
        this.ticketID = ticketID;
        this.bookingID = bookingID;
        this.userID = userID;
        this.bookingSeatID = bookingSeatID;
        this.roomID = roomID;
        this.bookingComboID = bookingComboID;
        this.bookingDate = bookingDate;
        this.totalPrice = totalPrice;
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

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getBookingSeatID() {
        return bookingSeatID;
    }

    public void setBookingSeatID(String bookingSeatID) {
        this.bookingSeatID = bookingSeatID;
    }

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    public String getBookingComboID() {
        return bookingComboID;
    }

    public void setBookingComboID(String bookingComboID) {
        this.bookingComboID = bookingComboID;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    @Override
    public String toString() {
        return "Ticket{" + "ticketID=" + ticketID + ", bookingID=" + bookingID + ", userID=" + userID + ", bookingSeatID=" + bookingSeatID + ", roomID=" + roomID + ", bookingComboID=" + bookingComboID + ", bookingDate=" + bookingDate + ", totalPrice=" + totalPrice + '}';
    }

   


  
  
    
}