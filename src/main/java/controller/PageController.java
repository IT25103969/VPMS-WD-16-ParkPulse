package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

public class PageController {
    @GetMapping("/submit-report")
    public String submitReport() {
        return "submit-report";
    }

    @GetMapping("/my-reports")
    public String myReports() {
        return "my-reports";
    }

    @GetMapping("/report-details")
    public String reportDetails() {
        return "report-details";
    }

    @GetMapping("/track-status")
    public String trackStatus() {
        return "track-status";
    }
}
