package service;

import model.ProblemReport;
import repository.ProblemReportRepository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;


public class ProblemReportService {

    private ProblemReportRepository repository;

    public ProblemReportService(){
        this.repository = new ProblemReportRepository();
    }

    public ProblemReport createReport(Long userId, String userName, String issueType, String description){
        if (userId == null){
            throw new IllegalArgumentException("User ID cannot be null");
        }
        if (description == null || description.trim().isEmpty()){
            throw new IllegalArgumentException("Description cannot be Empty");
        }

        ProblemReport report = new ProblemReport(userId, userName, issueType, description);

        String priority = calculatePriority(issueType, description);
        report.setPriority(priority);

        return repository.save(report);
    }

    private String calculatePriority(String issueType, String description){
        String lowerDesc = description.toLowerCase();

        if (issueType.equals("BROKEN_GATE") || lowerDesc.contains("emergency")){
            return "URGENT";
        } else if (issueType.equals("SLOT_BLOCKED") || lowerDesc.contains("blocked")) {
            return "HIGH";
        } else if (issueType.equals("PAYMENT_ERROR")) {
            return "HIGH";
        } else if (issueType.equals("LIGHT_FAILURE")) {
            return "MEDIUM";
        }
        return "LOW";
    }

    public List<ProblemReport> getAllReports(){
        return repository.findAllOrderByDateDesc();
    }

    public Optional<ProblemReport> getReportById(Long id) {
        return repository.findById(id);
    }

     public List<ProblemReport> getReportsByUser(Long userId){
        return repository.findByUserId(userId);
     }

     public List<ProblemReport> getReportsByStatus(String status){
        return repository.findByStatus(status);
     }

     public long getPendingCount(){
        return repository.countPending();
     }

     public ProblemReport updateStatus(Long reportId, String newStatus, Long adminId, String notes){
        ProblemReport report = repository.findById(reportId)
                .orElseThrow(() -> new RuntimeException("Report not found with ID : "+reportId));

        report.setStatus(newStatus);
        report.setAssignedToAdminId(adminId);

        if (notes != null && !notes.trim().isEmpty()){
            report.setAdminNotes(notes);
        }

        if ("RESERVED".equals(newStatus) || "CLOSED".equals(newStatus)){
            report.setResolvedAt(LocalDateTime.now());
        }

        return repository.update(report);
     }

     public ProblemReport updatePriority(Long reportId, String priority){
        ProblemReport report = repository.findById(reportId)
                .orElseThrow(() -> new RuntimeException("Report not found with ID: "+reportId));

        report.setPriority(priority);
        return repository.update(report);
     }

     public ProblemReport addAdminNotes(Long reportId, String notes){
        ProblemReport report = repository.findById(reportId)
                .orElseThrow(() -> new RuntimeException("Report not found with ID : "+reportId));

        report.setAdminNotes(notes);
        return repository.update(report);
     }

     public void deleteReport(Long reportId){
        if (!repository.existsById(reportId)){
            throw new RuntimeException("Report not found with ID : "+reportId);
        }
        repository.deleteById(reportId);
     }
}
