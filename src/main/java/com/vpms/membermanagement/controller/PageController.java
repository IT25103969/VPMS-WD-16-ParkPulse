package com.vpms.membermanagement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/ping")
    @org.springframework.web.bind.annotation.ResponseBody
    public String ping() {
        return "Backend is responding! If you see this, routing is working.";
    }

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/members")
    public String members() {
        return "members";
    }
}
