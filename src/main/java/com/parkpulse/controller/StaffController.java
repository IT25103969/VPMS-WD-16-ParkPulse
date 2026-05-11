package com.parkpulse.controller;

import com.parkpulse.model.Staff;
import com.parkpulse.service.StaffService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/staff")
public class StaffController {

    @Autowired
    private StaffService staffService;

    @GetMapping
    public String listStaff(@RequestParam(value = "search", required = false) String search,
                            @RequestParam(value = "tab", required = false, defaultValue = "all") String tab,
                            Model model) {
        List<Staff> staffList;
        if (search != null && !search.isEmpty()) {
            staffList = staffService.searchStaff(search);
        } else {
            staffList = staffService.getAllStaff();
        }

        if ("active".equalsIgnoreCase(tab)) {
            staffList = staffList.stream().filter(s -> "Active".equalsIgnoreCase(s.getStatus())).toList();
        } else if ("offduty".equalsIgnoreCase(tab)) {
            staffList = staffList.stream().filter(s -> "Off Duty".equalsIgnoreCase(s.getStatus())).toList();
        }

        model.addAttribute("staffList", staffList);
        model.addAttribute("activeCount", staffService.getActiveCount());
        model.addAttribute("offDutyCount", staffService.getOffDutyCount());
        model.addAttribute("totalCount", staffService.getAllStaff().size());
        model.addAttribute("search", search);
        model.addAttribute("activeTab", tab);
        model.addAttribute("activePage", "staff");
        return "staff/list";
    }

    @GetMapping("/add")
    public String addStaffForm(Model model) {
        model.addAttribute("staff", new Staff());
        model.addAttribute("title", "Add Staff Member");
        model.addAttribute("activePage", "staff");
        return "staff/form";
    }

    @GetMapping("/edit/{id}")
    public String editStaffForm(@PathVariable Long id, Model model) {
        Staff staff = staffService.getStaffById(id).orElseThrow(() -> new IllegalArgumentException("Invalid staff Id:" + id));
        model.addAttribute("staff", staff);
        model.addAttribute("title", "Edit — " + staff.getName());
        model.addAttribute("activePage", "staff");
        return "staff/form";
    }

    @PostMapping("/save")
    public String saveStaff(@ModelAttribute Staff staff) {
        staffService.saveStaff(staff);
        return "redirect:/staff";
    }

    @GetMapping("/delete/{id}")
    public String deleteStaff(@PathVariable Long id) {
        staffService.deleteStaff(id);
        return "redirect:/staff";
    }

    @GetMapping("/{id}")
    public String viewStaff(@PathVariable Long id, Model model) {
        Staff staff = staffService.getStaffById(id).orElseThrow(() -> new IllegalArgumentException("Invalid staff Id:" + id));
        model.addAttribute("staff", staff);
        model.addAttribute("activePage", "staff");
        return "staff/detail";
    }
}
