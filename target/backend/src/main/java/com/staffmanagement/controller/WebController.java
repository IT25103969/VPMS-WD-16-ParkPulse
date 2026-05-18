package com.staffmanagement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebController {

    @GetMapping("/")
    public String index() {
        return "redirect:/staff";
    }

    @GetMapping("/staff")
    public String staff() {
        return "staff";
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    @GetMapping("/analytics")
    public String analytics() {
        return "analytics";
    }

    @GetMapping("/membership")
    public String membership() {
        return "membership";
    }

    @GetMapping("/parking_slots")
    public String parkingSlots() {
        return "parking_slots";
    }

    @GetMapping("/settings")
    public String settings() {
        return "settings";
    }

    @GetMapping("/staff_detail")
    public String staffDetail() {
        return "staff_detail";
    }

    @GetMapping("/staff_form")
    public String staffForm() {
        return "staff_form";
    }

    @GetMapping("/staff_panel")
    public String staffPanel() {
        return "staff_panel";
    }

    // Explicit redirects for common legacy JSP links
    @GetMapping({"/staff.jsp", "/staff_form.jsp", "/staff_detail.jsp", "/dashboard.jsp", "/index.jsp"})
    public String handleExplicitLegacyJsp(jakarta.servlet.http.HttpServletRequest request) {
        String uri = request.getRequestURI();
        String cleanRoute = uri.substring(0, uri.lastIndexOf(".jsp"));
        String query = request.getQueryString();
        return "redirect:" + cleanRoute + (query != null ? "?" + query : "");
    }

    // Catch-all for other .jsp requests at the root level
    @GetMapping("/*.jsp")
    public String handleLegacyJsp(jakarta.servlet.http.HttpServletRequest request) {
        String uri = request.getRequestURI();
        String cleanRoute = uri.substring(0, uri.lastIndexOf(".jsp"));
        String query = request.getQueryString();
        return "redirect:" + cleanRoute + (query != null ? "?" + query : "");
    }
}
