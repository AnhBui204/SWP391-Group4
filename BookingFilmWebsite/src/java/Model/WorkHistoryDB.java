/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import static Model.DatabaseInfo.DBURL;
import static Model.DatabaseInfo.DRIVERNAME;
import static Model.DatabaseInfo.PASSDB;
import static Model.DatabaseInfo.USERDB;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HongD
 */
public class WorkHistoryDB {
    
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
    
    public static String getNextWorkHisId(){
        String sql = "SELECT 'WH' + RIGHT('0000' + CAST(CAST(SUBSTRING(MAX(WorkId), 3, 4) AS INT) + 1 AS VARCHAR(4)), 4) AS NextID FROM WorkHis";
        try{
            Connection con = getConnect();
            PreparedStatement stmt = con.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                return rs.getString("NextID");
            }
            
            
        } catch (SQLException ex) {
            Logger.getLogger(WorkHistoryDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "WH0001";
    }
    
    public static void addWorkHis(WorkHistory wh){
        String sql = "insert into WorkHis(WorkId, WorkDescription, Dates, Times, StaffId) values (?,?,?,?,?)";
        try {
            PreparedStatement ps = getConnect().prepareStatement(sql);
            ps.setString(1, wh.getWorkID());
            ps.setString(2, wh.getWorkDes());
            ps.setDate(3, wh.getDates());
            ps.setTime(4, wh.getTimes());
            ps.setString(5, wh.getStaffID());
            ResultSet rs = ps.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close your connection here
        }
    }
    
    public static void main(String[] args) {
            System.out.println(getNextWorkHisId());
    }
}
