package com.parking.management.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ParkingSlot {
    private String id;
    private String slotNumber;
    private boolean isOccupied;
    private SlotType slotType;

    public String toFileString() {
        return String.join("|", id, slotNumber, String.valueOf(isOccupied), slotType.name());
    }

    public static ParkingSlot fromFileString(String line) {
        String[] parts = line.split("\\|");
        return new ParkingSlot(parts[0], parts[1], Boolean.parseBoolean(parts[2]), SlotType.valueOf(parts[3]));
    }
}
