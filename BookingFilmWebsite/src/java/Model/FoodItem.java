/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.util.List;

/**
 *
 * @author ADMIN
 */
public class FoodItem {
    private List<String> names;
    private int quantity;

    public FoodItem(List<String> names, int quantity) {
        this.names = names;
        this.quantity = quantity;
    }

    // Change getName to return a List<String>
    public List<String> getNames() {
        return names;
    }

    public int getQuantity() {
        return quantity;
    }
}
