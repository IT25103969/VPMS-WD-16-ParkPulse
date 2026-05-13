package com.parking.management.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ParkingRecord {
    private String id;
    private String vehicleId;
    private String parkingSlotId;
    private LocalDateTime entryTime;
    private LocalDateTime exitTime;
    private double fee;

    public String toFileString() {
        return String.join("|", 
            id, 
            vehicleId, 
            parkingSlotId, 
            entryTime.toString(), 
            exitTime != null ? exitTime.toString() : "null", 
            String.valueOf(fee)
        );
    }

    public static ParkingRecord fromFileString(String line) {
        String[] parts = line.split("\\|");
        return new ParkingRecord(
            parts[0], 
            parts[1], 
            parts[2], 
            LocalDateTime.parse(parts[3]), 
            parts[4].equals("null") ? null : LocalDateTime.parse(parts[4]), 
            Double.parseDouble(parts[5])
        );
    }
}
