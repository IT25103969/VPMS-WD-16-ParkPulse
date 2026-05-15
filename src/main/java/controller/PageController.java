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
}
