package Model;

import java.sql.Date; 
import java.sql.Time;

public class WorkHistory {
    private String workID;
    private String workDes;
    private Time times; 
    private Date dates; 
    private String staffID;

    public WorkHistory() {
    }

    
    public WorkHistory(String workID, String workDes, Time times, Date dates, String staffID) {
        this.workID = workID;
        this.workDes = workDes;
        this.times = times;
        this.dates = dates;
        this.staffID = staffID;
    }

    // Getters and Setters
    public String getWorkID() {
        return workID;
    }

    public void setWorkID(String workID) {
        this.workID = workID;
    }

    public String getWorkDes() {
        return workDes;
    }

    public void setWorkDes(String workDes) {
        this.workDes = workDes;
    }

    public Time getTimes() {
        return times;
    }

    public void setTimes(Time times) {
        this.times = times;
    }

    public Date getDates() {
        return dates;
    }

    public void setDates(Date dates) {
        this.dates = dates;
    }

    public String getStaffID() {
        return staffID;
    }

    public void setStaffID(String staffID) {
        this.staffID = staffID;
    }

    @Override
    public String toString() {
        return "WorkHistory{" + "workID=" + workID + ", workDes=" + workDes + ", times=" + times + ", dates=" + dates + ", staffID=" + staffID + '}';
    }
    
}
