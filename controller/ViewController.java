package com.parking.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.parking.model.ParkingSlot;
import com.parking.model.Vehicle;
import com.parking.model.Zone;
import com.parking.service.IParkingService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
public class ViewController {

    private final IParkingService parkingService;
    private final ObjectMapper mapper = new ObjectMapper();

    public ViewController(IParkingService parkingService) {
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

    @GetMapping("/entry")
    public String entry(@RequestParam(required = false) String slot, Model model) throws JsonProcessingException {
        addDataToModel(model);
        model.addAttribute("slotNumber", slot != null ? slot : "A1");
        return "entry";
    }

    @GetMapping("/checkout")
    public String checkout(@RequestParam(required = false) String slot, Model model) throws JsonProcessingException {
        addDataToModel(model);
        model.addAttribute("slotNumber", slot != null ? slot : "A1");
        
        ParkingSlot parkingSlot = parkingService.getSlots().stream()
                .filter(s -> s.getNumber().equals(slot))
                .findFirst()
                .orElse(null);
        
        if (parkingSlot != null && parkingSlot.getVehicle() != null) {
            model.addAttribute("vehicle", parkingSlot.getVehicle());
            model.addAttribute("vehicleJson", mapper.writeValueAsString(parkingSlot.getVehicle()));
        }
        
        return "checkout";
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
        Map<String, Object> stats = parkingService.getStats();
        
        model.addAttribute("zones", zones);
        model.addAttribute("slots", slots);
        model.addAttribute("stats", stats);
        
        model.addAttribute("zonesJson", mapper.writeValueAsString(zones));
        model.addAttribute("slotsJson", mapper.writeValueAsString(slots));
        model.addAttribute("statsJson", mapper.writeValueAsString(stats));
        
        model.addAttribute("totalSlots", stats.get("totalSlots"));
        model.addAttribute("occupiedSlots", stats.get("occupiedSlots"));
        model.addAttribute("availableSlots", stats.get("availableSlots"));
        model.addAttribute("occupancyRate", stats.get("occupancyRate") + "%");
    }
}
