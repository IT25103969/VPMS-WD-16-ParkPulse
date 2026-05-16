package com.parking.controller;

import com.parking.model.ParkingSlot;
import com.parking.model.Zone;
import com.parking.service.IParkingService;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/parking")
public class ParkingController {
    private final IParkingService parkingService;

    public ParkingController(IParkingService parkingService) {
        this.parkingService = parkingService;
    }

    @GetMapping("/slots")
    public List<ParkingSlot> getSlots() throws IOException {
        return parkingService.getSlots();
    }

    @GetMapping("/zones")
    public List<Zone> getZones() throws IOException {
        return parkingService.getZones();
    }
}
