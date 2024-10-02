/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.io.Serializable;

public class Theatre implements Serializable{
    String TheatreID;
    String TheatreName;
    String TheatreLocation;

    public Theatre(){}
    
    public Theatre(String TheatreID, String TheatreName, String TheatreLocation) {
        this.TheatreID = TheatreID;
        this.TheatreName = TheatreName;
        this.TheatreLocation = TheatreLocation;
    }

    public String getTheatreID() {
        return TheatreID;
    }

    public void setTheatreID(String TheatreID) {
        this.TheatreID = TheatreID;
    }

    public String getTheatreName() {
        return TheatreName;
    }

    public void setTheatreName(String TheatreName) {
        this.TheatreName = TheatreName;
    }

    public String getTheatreLocation() {
        return TheatreLocation;
    }

    public void setTheatreLocation(String TheatreLocation) {
        this.TheatreLocation = TheatreLocation;
    }

    @Override
    public String toString() {
        return "Theatre{" + "TheatreID=" + TheatreID + ", TheatreName=" + TheatreName + ", TheatreLocation=" + TheatreLocation + '}';
    }
    
    
}
