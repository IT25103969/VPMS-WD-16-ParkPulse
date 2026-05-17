package com.parkpulse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class ViewController {

    private static final Logger logger = LoggerFactory.getLogger(ViewController.class);

    @GetMapping("/debug")
    @ResponseBody
    public String debug() {
        logger.info("Debug endpoint hit");
        return "ViewController is active! Current time: " + new java.util.Date();
    }

    @GetMapping({"/", "/tickets"})
    public String tickets() {
        logger.info("Mapping to tickets.jsp");
        return "tickets";
    }

    @GetMapping("/revenue")
    public String revenue() {
        logger.info("Mapping to revenue.jsp");
        return "revenue";
    }

    @GetMapping("/checkout")
    public String checkout() {
        logger.info("Mapping to checkout.jsp");
        return "checkout";
    }
}
