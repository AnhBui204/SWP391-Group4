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