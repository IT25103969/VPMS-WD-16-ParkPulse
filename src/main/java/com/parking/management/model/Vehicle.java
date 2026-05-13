package com.parking.management.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Vehicle {
    private String id;
    private String licensePlate;
    private String model;
    private String memberId;

    public String toFileString() {
        return String.join("|", id, licensePlate, model, memberId);
    }

    public static Vehicle fromFileString(String line) {
        String[] parts = line.split("\\|");
        return new Vehicle(parts[0], parts[1], parts[2], parts[3]);
    }
}
