package com.parkpulse.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "staff")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Staff {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String role;
    private String shift;
    private String status; // "Active" or "Off Duty"
    private String avatar;
    private String phone;
    private String email;
    private String joinDate;
    private String address;
    private String vehicleNumber;
    private String vehicleType;
}
