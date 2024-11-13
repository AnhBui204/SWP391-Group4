/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.Date;

/**
 *
 * @author DELL
 */
public class Revenue {
    
    private Date bookingDate;
    private double totalRevenue;

    public Revenue(Date bookingDate, double totalRevenue) {
        this.bookingDate = bookingDate;
        this.totalRevenue = totalRevenue;
    }

    public Revenue() {
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

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    @Override
    public String toString() {
        return "RevenueData{" + "bookingDate=" + bookingDate + ", totalRevenue=" + totalRevenue + '}';
    }

    
}
