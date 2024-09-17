/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;
import java.io.Serializable;

public class Cinema implements Serializable{
    String CinemaID;
    String CinemaName;
    String CinemaLocation;

    public Cinema(){}
    
    public Cinema(String CinemaID, String CinemaName, String CinemaLocation) {
        this.CinemaID = CinemaID;
        this.CinemaName = CinemaName;
        this.CinemaLocation = CinemaLocation;
    }

    public String getCinemaID() {
        return CinemaID;
    }

    public void setCinemaID(String CinemaID) {
        this.CinemaID = CinemaID;
    }

    public String getCinemaName() {
        return CinemaName;
    }

    public void setCinemaName(String CinemaName) {
        this.CinemaName = CinemaName;
    }

    public String getCinemaLocation() {
        return CinemaLocation;
    }

    public void setCinemaLocation(String CinemaLocation) {
        this.CinemaLocation = CinemaLocation;
    }

    @Override
    public String toString() {
        return "Cinema{" + "CinemaID=" + CinemaID + ", CinemaName=" + CinemaName + ", CinemaLocation=" + CinemaLocation + '}';
    }
    
    
}
