package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ProblemReport {
    private Long id;
    private Long userID;
    private String userName;
    private String issueType;
    private String description;
    private String priority;
    private String status;
    private LocalDateTime reportedAt;
    private LocalDateTime resolvedAt;
    private String adminNotes;
    private Long assignedToAdminId;

    public ProblemReport() {
    }

    public ProblemReport(Long userID, String issueType, String description, String priority, String status, LocalDateTime reportedAt) {
        this.userID = userID;
        this.issueType = issueType;
        this.description = description;
        this.priority = "Medium";
        this.status = "Pending";
        this.reportedAt = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }

    public Long getUserID() {
        return userID;
    }

    public String getUserName() {
        return userName;
    }

    public String getIssueType() {
        return issueType;
    }

    public String getDescription() {
        return description;
    }

    public String getPriority() {
        return priority;
    }

    public String getStatus() {
        return status;
    }

    public LocalDateTime getReportedAt() {
        return reportedAt;
    }

    public LocalDateTime getResolvedAt() {
        return resolvedAt;
    }

    public String getAdminNotes() {
        return adminNotes;
    }

    public Long getAssignedToAdminId() {
        return assignedToAdminId;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUserID(Long userID) {
        this.userID = userID;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setIssueType(String issueType) {
        this.issueType = issueType;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setReportedAt(LocalDateTime reportedAt) {
        this.reportedAt = reportedAt;
    }

    public void setResolvedAt(LocalDateTime resolvedAt) {
        this.resolvedAt = resolvedAt;
    }

    public void setAdminNotes(String adminNotes) {
        this.adminNotes = adminNotes;
    }

    public void setAssignedToAdminId(Long assignedToAdminId) {
        this.assignedToAdminId = assignedToAdminId;
    }

    public String getFormattedReportedAt(){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return reportedAt != null ? reportedAt.format(formatter):"";
    }
}
