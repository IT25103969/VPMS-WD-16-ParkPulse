package com.parking.management.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/membership")
    public String membership() {
        return "membership";
    }

    @GetMapping("/parking-slots")
    public String parkingSlots() {
        return "parking-slots";
    }

    @GetMapping("/analytics")
    public String analytics() {
        return "analytics";
    }

    @GetMapping("/membership-analytics")
    public String membershipAnalytics() {
        return "membership-analytics";
    }

    @GetMapping("/settings")
    public String settings() {
        return "settings";
    }
}
