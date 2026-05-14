package model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ProblemReport {
    private Long id;
    private Long userId;
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

    public ProblemReport(Long userId, String userName, String issueType, String description) {
        this.userId = userId;
        this.userName = userName;
        this.issueType = issueType;
        this.description = description;
        this.priority = "MEDIUM";
        this.status = "PENDING";
        this.reportedAt = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }

    public Long getUserId() {
        return userId;
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

    public void setUserId(Long userId) {
        this.userId = userId;
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
