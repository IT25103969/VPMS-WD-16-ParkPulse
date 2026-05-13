package com.parking.management.controller;

import com.parking.management.model.ParkingRecord;
import com.parking.management.model.ParkingSlot;
import com.parking.management.model.Vehicle;
import com.parking.management.service.ParkingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/parking")
public class ParkingController {

    @Autowired
    private ParkingService parkingService;

    // Vehicles
    @PostMapping("/vehicles")
    public Vehicle addVehicle(@RequestBody Vehicle vehicle) {
        return parkingService.addVehicle(vehicle);
    }

    @GetMapping("/vehicles/member/{memberId}")
    public List<Vehicle> getVehiclesByMember(@PathVariable String memberId) {
        return parkingService.getVehiclesByMember(memberId);
    }

    // Slots
    @PostMapping("/slots")
    public ParkingSlot addSlot(@RequestBody ParkingSlot slot) {
        return parkingService.addSlot(slot);
    }

    @GetMapping("/slots")
    public List<ParkingSlot> getAllSlots() {
        return parkingService.getAllSlots();
    }

    @GetMapping("/slots/available")
    public List<ParkingSlot> getAvailableSlots() {
        return parkingService.getAvailableSlots();
    }

    // Operations
    @PostMapping("/park")
    public ParkingRecord parkVehicle(@RequestParam String vehicleId, @RequestParam String slotId) {
        return parkingService.parkVehicle(vehicleId, slotId);
    }

    @PostMapping("/unpark/{recordId}")
    public ParkingRecord unparkVehicle(@PathVariable String recordId) {
        return parkingService.unparkVehicle(recordId);
    }
}
