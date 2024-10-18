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

    public String getComboName() {
        return comboName;
    }

    public String getTheatreID() {
        return theatreID;
    }

    public String getImagePath() {
        return imagePath;
    }

    public double getPrice() {
        return price;
    }

    public void setComboID(String comboID) {
        this.comboID = comboID;
    }

    public void setComboName(String comboName) {
        this.comboName = comboName;
    }

    public void setTheatreID(String theatreID) {
        this.theatreID = theatreID;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    

    @Override
    public String toString() {
        return "FoodAndDrink{" + "comboID=" + comboID + ", comboName=" + comboName + ", price=" + price + '}';
    }
}
