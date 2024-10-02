/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.sql.Date;

public class Voucher {

    private String voucherID;
    private String voucherName;
    private double price;
    private Date expiryDate;

    public Voucher() {
    }

    public Voucher(String voucherID, String voucherName, double price, Date expiryDate) {
        this.voucherID = voucherID;
        this.voucherName = voucherName;
        this.price = price;
        this.expiryDate = expiryDate;
    }

    public String getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(String voucherID) {
        this.voucherID = voucherID;
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

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    @Override
    public String toString() {
        return "Voucher{" + "voucherID=" + voucherID + ", voucherName=" + voucherName + ", price=" + price + ", expiryDate=" + expiryDate + '}';
    }
    
}
