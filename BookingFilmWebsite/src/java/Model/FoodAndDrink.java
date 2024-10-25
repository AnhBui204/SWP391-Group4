/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

public class FoodAndDrink {
    
    private String comboID;
    private String comboName;
    private String theatreID;
    private String imagePath;
    private double price;

    public FoodAndDrink() {
    }

    public FoodAndDrink(String comboID, String comboName, String theatreID, String imagePath, double price) {
        this.comboID = comboID;
        this.comboName = comboName;
        this.theatreID = theatreID;
        this.imagePath = imagePath;
        this.price = price;
    }

    

    public String getComboID() {
        return comboID;
    }

    public void setComboID(String comboID) {
        this.comboID = comboID;
    }

    public String getComboName() {
        return comboName;
    }

    public void setComboName(String comboName) {
        this.comboName = comboName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getTheatreID() {
        return theatreID;
    }

    public void setTheatreID(String theatreID) {
        this.theatreID = theatreID;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    @Override
    public String toString() {
        return "FoodAndDrink{" + "comboID=" + comboID + ", comboName=" + comboName + ", theatreID=" + theatreID + ", imagePath=" + imagePath + ", price=" + price + '}';
    }
}
