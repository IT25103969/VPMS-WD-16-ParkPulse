package com.parking.management.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
    private String id;
    private String name;
    private String email;
    private String phone;
    private String vehicle;
    private String licensePlate;
    private String plan;
    private String status;
    private String joinDate;

    public String toFileString() {
        return String.join("|", id, name, email, phone, vehicle, licensePlate, plan, status, joinDate);
    }

    public static Member fromFileString(String line) {
        String[] parts = line.split("\\|");
        // Add safety check for split length
        String[] paddedParts = new String[9];
        System.arraycopy(parts, 0, paddedParts, 0, Math.min(parts.length, 9));
        for (int i = 0; i < 9; i++) {
            if (paddedParts[i] == null) paddedParts[i] = "";
        }
        return new Member(paddedParts[0], paddedParts[1], paddedParts[2], paddedParts[3], paddedParts[4], paddedParts[5], paddedParts[6], paddedParts[7], paddedParts[8]);
    }
}
