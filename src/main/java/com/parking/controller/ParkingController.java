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

        return getFullDataResponse();
    }

    @PostMapping("/api/zones/create")
    @ResponseBody
    public Map<String, Object> createZone(@RequestBody Map<String, Object> payload) {
        String name = (String) payload.get("name");
        int slotCount = (Integer) payload.get("slotCount");
        
        List<Zone> zones = dataService.readZones();
        String id = name.toUpperCase().replace(" ", "_");
        // Ensure unique ID
        String baseId = id;
        int counter = 1;
        while (true) {
            boolean exists = false;
            for (Zone z : zones) {
                if (z.getId().equals(id)) {
                    exists = true;
                    break;
                }
            }
            if (!exists) break;
            id = baseId + "_" + counter++;
        }
        
        Zone newZone = new Zone(id, name);
        zones.add(newZone);
        dataService.saveZones(zones);
        
        List<ParkingSlot> slots = dataService.readSlots();
        for (int i = 1; i <= slotCount; i++) {
            slots.add(new ParkingSlot(id + "-" + i, id + i, id, "available", "", null));
        }
        dataService.saveSlots(slots);
        
        return getFullDataResponse();
    }

    @DeleteMapping("/api/zones/{id}")
    @ResponseBody
    public Map<String, Object> deleteZone(@PathVariable String id) {
        List<Zone> zones = dataService.readZones();
        zones.removeIf(z -> z.getId().equals(id));
        dataService.saveZones(zones);
        
        List<ParkingSlot> slots = dataService.readSlots();
        slots.removeIf(s -> s.getZoneId().equals(id));
        dataService.saveSlots(slots);
        
        return getFullDataResponse();
    }

    @PostMapping("/api/slots/add")
    @ResponseBody
    public Map<String, Object> addSlot(@RequestBody Map<String, String> payload) {
        String zoneId = payload.get("zoneId");
        List<ParkingSlot> slots = dataService.readSlots();
        
        long count = slots.stream().filter(s -> s.getZoneId().equals(zoneId)).count();
        String number = zoneId + (count + 1);
        String id = zoneId + "-" + System.currentTimeMillis();
        
        slots.add(new ParkingSlot(id, number, zoneId, "available", "", null));
        dataService.saveSlots(slots);
        
        return getFullDataResponse();
    }

    @DeleteMapping("/api/slots/{id}")
    @ResponseBody
    public Map<String, Object> deleteSlot(@PathVariable String id) {
        List<ParkingSlot> slots = dataService.readSlots();
        slots.removeIf(s -> s.getId().equals(id));
        dataService.saveSlots(slots);
        
        return getFullDataResponse();
    }

    private Map<String, Object> getFullDataResponse() {
        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        response.put("zones", dataService.readZones());
        response.put("slots", dataService.readSlots());
        return response;
    }
}
