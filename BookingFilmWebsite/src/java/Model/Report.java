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
}
