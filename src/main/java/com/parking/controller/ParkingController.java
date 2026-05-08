package com.parking.controller;

import com.parking.model.ParkingSlot;
import com.parking.model.Zone;
import com.parking.service.DataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ParkingController {

    @Autowired
    private DataService dataService;

    @GetMapping("/")
    public String index(Model model) {
        return "index";
    }

    @GetMapping("/api/data")
    @ResponseBody
    public Map<String, Object> getData() {
        Map<String, Object> data = new HashMap<>();
        data.put("zones", dataService.readZones());
        data.put("slots", dataService.readSlots());
        return data;
    }

    @PostMapping("/api/action")
    @ResponseBody
    public Map<String, Object> handleAction(@RequestBody Map<String, Object> payload) {
        String action = (String) payload.get("action");
        String slotId = (String) payload.get("slotId");
        
        List<ParkingSlot> slots = dataService.readSlots();
        ParkingSlot targetSlot = null;
        for (ParkingSlot s : slots) {
            if (s.getId().equals(slotId)) {
                targetSlot = s;
                break;
            }
        }

        if (targetSlot != null) {
            switch (action) {
                case "enter":
                    Map<String, String> vehicleData = (Map<String, String>) payload.get("vehicle");
                    ParkingSlot.Vehicle v = new ParkingSlot.Vehicle();
                    v.setLicensePlate(vehicleData.get("licensePlate"));
                    v.setType(vehicleData.get("type"));
                    v.setOwner(vehicleData.get("owner"));
                    v.setPhone(vehicleData.get("phone"));
                    v.setEmail(vehicleData.get("email"));
                    v.setEntryTime(LocalTime.now().format(DateTimeFormatter.ofPattern("hh:mm a")));
                    v.setDuration("0h 0m");
                    targetSlot.setVehicle(v);
                    targetSlot.setStatus("occupied");
                    break;
                case "release":
                    targetSlot.setVehicle(null);
                    targetSlot.setStatus("available");
                    break;
                case "reserve":
                    String reservedBy = (String) payload.get("reservedBy");
                    targetSlot.setStatus("reserved");
                    targetSlot.setReservedBy(reservedBy);
                    break;
                case "maintenance":
                    targetSlot.setStatus("maintenance");
                    break;
                case "clear":
                    targetSlot.setStatus("available");
                    targetSlot.setReservedBy("");
                    targetSlot.setVehicle(null);
                    break;
            }
            dataService.updateSlot(targetSlot);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("zones", dataService.readZones());
        response.put("slots", dataService.readSlots());
        return response;
    }
}
