/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;


public class TicketDetails {
    private String ticketID;
    private String bookingID;
    private String showName;
    private String seatName;
    private String comboName;
    private String voucherID;
    private double price;
    private Date bookingDate;

    // Constructor
    public TicketDetails(String ticketID, String bookingID, String showName, String seatName,
                         String comboName, String voucherID, double price, Date bookingDate) {
        this.ticketID = ticketID;
        this.bookingID = bookingID;
        this.showName = showName;
        this.seatName = seatName;
        this.comboName = comboName;
        this.voucherID = voucherID;
        this.price = price;
        this.bookingDate = bookingDate;
    }
}
