package com.parking.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.parking.model.ParkingSlot;
import com.parking.model.Zone;
import com.parking.service.ParkingService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.List;

@Controller
public class ViewController {

    private final ParkingService parkingService;
    private final ObjectMapper mapper = new ObjectMapper();

    public ViewController(ParkingService parkingService) {
        this.parkingService = parkingService;
    }

    @GetMapping("/")
    public String dashboard(Model model) throws JsonProcessingException {
        addDataToModel(model);
        return "dashboard";
    }

    @GetMapping("/slots")
    public String slots(@RequestParam(required = false) String zoneId, Model model) throws JsonProcessingException {
        addDataToModel(model);
        List<Zone> zones = parkingService.getZones();
        String activeId = zoneId;
        if (activeId == null && !zones.isEmpty()) {
            activeId = zones.get(0).getId();
        }
        model.addAttribute("activeZoneId", activeId);
        return "slots";
    }

    @GetMapping("/vehicles")
    public String vehicles(Model model) throws JsonProcessingException {
        addDataToModel(model);
        return "vehicles";
    }

    @GetMapping("/analytics")
    public String analytics(Model model) throws JsonProcessingException {
        addDataToModel(model);
        return "analytics";
    }

    @PostMapping("/action")
    public String handleAction(HttpServletRequest request, @RequestParam String action) throws IOException {
        parkingService.handleAction(action, request.getParameterMap());
        String referer = request.getHeader("Referer");
        return "redirect:" + (referer != null ? referer : "/");
    }

    private void addDataToModel(Model model) throws JsonProcessingException {
        List<Zone> zones = parkingService.getZones();
        List<ParkingSlot> slots = parkingService.getSlots();
        
        model.addAttribute("zones", zones);
        model.addAttribute("slots", slots);
        model.addAttribute("zonesJson", mapper.writeValueAsString(zones));
        model.addAttribute("slotsJson", mapper.writeValueAsString(slots));
        
        long total = slots.size();
        long occupied = slots.stream().filter(s -> "occupied".equals(s.getStatus())).count();
        long reserved = slots.stream().filter(s -> "reserved".equals(s.getStatus()) || "maintenance".equals(s.getStatus())).count();
        long available = total - occupied - reserved;
        
        model.addAttribute("totalSlots", total);
        model.addAttribute("occupiedSlots", occupied);
        model.addAttribute("availableSlots", available);
        model.addAttribute("occupancyRate", total > 0 ? (occupied * 100 / total) + "%" : "0%");
    }
}
