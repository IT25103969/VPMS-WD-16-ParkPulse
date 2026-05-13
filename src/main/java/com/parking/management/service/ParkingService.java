package com.parking.management.service;

import com.parking.management.model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ParkingService {

    @Autowired
    private FileStorageService fileStorageService;

    @Value("${storage.vehicles-file}")
    private String vehiclesFile;

    @Value("${storage.slots-file}")
    private String slotsFile;

    @Value("${storage.records-file}")
    private String recordsFile;

    // Vehicle Management
    public Vehicle addVehicle(Vehicle vehicle) {
        vehicle.setId(UUID.randomUUID().toString());
        fileStorageService.append(vehiclesFile, vehicle.toFileString());
        return vehicle;
    }

    public List<Vehicle> getVehiclesByMember(String memberId) {
        return fileStorageService.readAll(vehiclesFile, Vehicle::fromFileString).stream()
                .filter(v -> v.getMemberId().equals(memberId))
                .collect(Collectors.toList());
    }

    // Parking Slot Management
    public ParkingSlot addSlot(ParkingSlot slot) {
        slot.setId(UUID.randomUUID().toString());
        fileStorageService.append(slotsFile, slot.toFileString());
        return slot;
    }

    public List<ParkingSlot> getAllSlots() {
        return fileStorageService.readAll(slotsFile, ParkingSlot::fromFileString);
    }

    public List<ParkingSlot> getAvailableSlots() {
        return getAllSlots().stream()
                .filter(s -> !s.isOccupied())
                .collect(Collectors.toList());
    }

    // Parking Operations
    public ParkingRecord parkVehicle(String vehicleId, String slotId) {
        List<ParkingSlot> slots = getAllSlots();
        ParkingSlot selectedSlot = null;
        for (ParkingSlot s : slots) {
            if (s.getId().equals(slotId) && !s.isOccupied()) {
                s.setOccupied(true);
                selectedSlot = s;
                break;
            }
        }

        if (selectedSlot == null) {
            throw new RuntimeException("Slot not available or not found");
        }

        fileStorageService.writeAll(slotsFile, slots.stream().map(ParkingSlot::toFileString).collect(Collectors.toList()));

        ParkingRecord record = new ParkingRecord();
        record.setId(UUID.randomUUID().toString());
        record.setVehicleId(vehicleId);
        record.setParkingSlotId(slotId);
        record.setEntryTime(LocalDateTime.now());
        record.setFee(0.0);

        fileStorageService.append(recordsFile, record.toFileString());
        return record;
    }

    public ParkingRecord unparkVehicle(String recordId) {
        List<ParkingRecord> records = fileStorageService.readAll(recordsFile, ParkingRecord::fromFileString);
        ParkingRecord activeRecord = null;
        for (ParkingRecord r : records) {
            if (r.getId().equals(recordId) && r.getExitTime() == null) {
                activeRecord = r;
                break;
            }
        }

        if (activeRecord == null) {
            throw new RuntimeException("Active record not found");
        }

        activeRecord.setExitTime(LocalDateTime.now());
        activeRecord.setFee(calculateFee(activeRecord.getEntryTime(), activeRecord.getExitTime()));

        fileStorageService.writeAll(recordsFile, records.stream().map(ParkingRecord::toFileString).collect(Collectors.toList()));

        // Free the slot
        List<ParkingSlot> slots = getAllSlots();
        for (ParkingSlot s : slots) {
            if (s.getId().equals(activeRecord.getParkingSlotId())) {
                s.setOccupied(false);
                break;
            }
        }
        fileStorageService.writeAll(slotsFile, slots.stream().map(ParkingSlot::toFileString).collect(Collectors.toList()));

        return activeRecord;
    }

    private double calculateFee(LocalDateTime entry, LocalDateTime exit) {
        long minutes = Duration.between(entry, exit).toMinutes();
        if (minutes <= 30) return 0.0;
        return (minutes / 60.0) * 100.0; // 100 per hour
    }
}
