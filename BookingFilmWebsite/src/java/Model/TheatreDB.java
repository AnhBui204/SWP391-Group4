/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import static Model.UserDB.getConnect;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TheatreDB {
    
    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver" + e);
        }
        try {
            Connection con = DriverManager.getConnection(DBURL, USERDB, PASSDB);
            return con;
        } catch (SQLException e) {
            System.out.println("Error: " + e);
        }
        return null;
    }
    
    public Theatre getTheatre(String id) {
        Theatre a = null;
        String query = "select TheatreID, TheatreName , TheatreLocation"
                + "from Theatres where TheatreID =? ";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // String id = rs.getString("UserId");
                id = rs.getString(1);
                String name = rs.getString(2);
                String location = rs.getString(3);
                a = new Theatre(id, name, location);
            }

        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return a;
    }
    
    public static ArrayList<Theatre> listAllTheatres() {
        ArrayList<Theatre> cinemaList = new ArrayList<>();
        String query = "select TheatreID, TheatreName , TheatreLocation FROM Theatres";

        try (Connection con = getConnect(); PreparedStatement stmt = con.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String cID = rs.getString("TheatreID");
                String cName = rs.getString("TheatreName");
                String cLocation = rs.getString("TheatreLocation");
                Theatre cinema = new Theatre(cID, cName, cLocation);
                cinemaList.add(cinema);
            }
        } catch (Exception ex) {
            Logger.getLogger(UserDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cinemaList;
    }
    
    public static void main(String[] args) {
        ArrayList<Theatre> list = TheatreDB.listAllTheatres();
        for (Theatre ci : list) {
            System.out.println(ci);
        }
    }
}
