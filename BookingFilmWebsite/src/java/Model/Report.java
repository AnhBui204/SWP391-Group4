/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Date; 

public class Report {
    private String reportId;
    private String reportTitle;
    private String reportDescription;
    private String userId;
    private Date timeCreate; 


    public Report(String reportId, String reportTitle, String reportDescription, String userId, Date timeCreate) {
        this.reportId = reportId;
        this.reportTitle = reportTitle;
        this.reportDescription = reportDescription;
        this.userId = userId;
        this.timeCreate = timeCreate; 
    }

    // Getters
    public String getReportId() {
        return reportId;
    }

    public String getReportTitle() {
        return reportTitle;
    }

    public String getReportDescription() {
        return reportDescription;
    }

    public String getUserId() {
        return userId;
    }

    public Date getTimeCreate() { 
        return timeCreate;
    }

    @Override
    public String toString() {
        return "Report{" + "reportId=" + reportId + ", reportTitle=" + reportTitle + ", reportDescription=" + reportDescription + ", userId=" + userId + ", timeCreate=" + timeCreate + '}';
    }
    
}
