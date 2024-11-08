package Model;

/**
 *
 * @author ADMIN
 */
public class Combo {
    private String comboName;
    private int quantity;
    private int comboPrice;

    public Combo() {
    }

    public Combo(String comboName, int quantity, int comboPrice) {
        this.comboName = comboName;
        this.quantity = quantity;
        this.comboPrice = comboPrice;
    }

    public String getComboName() {
        return comboName;
    }

    public void setComboName(String comboName) {
        this.comboName = comboName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getComboPrice() {
        return comboPrice;
    }

    public void setComboPrice(int comboPrice) {
        this.comboPrice = comboPrice;
    }
    
}