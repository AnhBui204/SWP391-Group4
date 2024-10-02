/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

public class FoodAndDrink {
    
    private String comboID;
    private String comboName;
    private double price;

    public FoodAndDrink() {
    }

    public FoodAndDrink(String comboID, String comboName, double price) {
        this.comboID = comboID;
        this.comboName = comboName;
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

    @Override
    public String toString() {
        return "FoodAndDrink{" + "comboID=" + comboID + ", comboName=" + comboName + ", price=" + price + '}';
    }
}
