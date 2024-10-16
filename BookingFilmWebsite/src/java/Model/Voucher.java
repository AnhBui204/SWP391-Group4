/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.sql.Date;

public class Voucher {

    private String voucherID;
    private String voucherName;
    private String TheatreID;
    private String imgPath;
    private double price;
    private Date expiryDate;

    public Voucher() {
    }

    public Voucher(String voucherID, String voucherName, String TheatreID, String imgPath, double price, Date expiryDate) {
        this.voucherID = voucherID;
        this.voucherName = voucherName;
        this.TheatreID = TheatreID;
        this.imgPath = imgPath;
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

    public String getTheatreID() {
        return TheatreID;
    }

    public void setTheatreID(String TheatreID) {
        this.TheatreID = TheatreID;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    @Override
    public String toString() {
        return "Voucher{" + "voucherID=" + voucherID + ", voucherName=" + voucherName + ", TheatreID=" + TheatreID + ", imgPath=" + imgPath + ", price=" + price + ", expiryDate=" + expiryDate + '}';
    }
    
}
