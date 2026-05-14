package controller;

import model.ProblemReport;
import service.ProblemReportService;
import java.util.List;
import java.util.Optional;

public class ProblemReportController {

    private ProblemReportService service;

    public ProblemReportController() {
        this.service = new ProblemReportService();
    }

    public ProblemReport createReport(Long userId, String userName, String issueType, String description){
        return service.createReport(userId, userName, issueType, description);
    }

    public List<ProblemReport> getAllReports(){
        return service.getAllReports();
    }

    public Optional<ProblemReport> getReportById(Long id){
        return service.getReportById(id);
    }

    public List<ProblemReport> getReportsByUser(Long userId){
        return service.getReportsByUser(userId);
    }

    public List<ProblemReport> getReportsByStatus(String status){
        return service.getReportsByStatus(status);
    }

    public long getPendingCount(){
        return service.getPendingCount();
    }

    public ProblemReport updateStatus(Long reportId, String newStatus, Long adminId, String notes){
        return service.updateStatus(reportId, newStatus, adminId, notes);
    }

    public ProblemReport updatePriority(Long reportId, String priority){
        return service.updatePriority(reportId, priority);
    }

    public ProblemReport addAdminNotes(Long reportId, String notes){
        return service.addAdminNotes(reportId, notes);
    }

    public void deleteReport(Long reportId){
        service.deleteReport(reportId);
    }
}
