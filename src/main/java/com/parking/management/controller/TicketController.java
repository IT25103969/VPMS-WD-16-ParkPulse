package com.parking.management.controller;

import com.parking.management.model.Ticket;
import com.parking.management.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class TicketController {

    @Autowired
    private TicketService ticketService;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("activeTickets", ticketService.getActiveTickets());
        return "index";
    }

    @PostMapping("/check-in")
    public String checkIn(@RequestParam String licensePlate) {
        ticketService.checkIn(licensePlate);
        return "redirect:/";
    }

    @PostMapping("/check-out")
    public String checkOut(@RequestParam Long id) {
        ticketService.checkOut(id);
        return "redirect:/";
    }

    @GetMapping("/management")
    public String management(Model model) {
        model.addAttribute("checkedOutTickets", ticketService.getCheckedOutTickets());
        return "management";
    }

    @PostMapping("/update-ticket")
    @ResponseBody
    public String updateTicket(@RequestParam Long id, @RequestParam String licensePlate, @RequestParam Double amount) {
        Ticket updated = ticketService.updateTicket(id, licensePlate, amount);
        return updated != null ? "Success" : "Error";
    }
}
