package com.vpms.membermanagement.model;

import com.vpms.membermanagement.model.enums.MemberStatus;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

/**
 * Demonstrates Inheritance.
 * Member inherits id and joinDate from BaseEntity.
 */
public class Member extends BaseEntity {
    @NotBlank(message = "Name is mandatory")
    private String name;

    @NotBlank(message = "Email is mandatory")
    @Email(message = "Email should be valid")
    private String email;

    @Pattern(regexp = "^\\d{10}$", message = "Phone must be 10 digits")
    private String phone;

    @NotBlank(message = "Vehicle type is mandatory")
    private String vehicle;

    @NotBlank(message = "Vehicle model is mandatory")
    private String vehicleModel;

    @NotBlank(message = "License plate is mandatory")
    private String licensePlate;

    @NotBlank(message = "Plan is mandatory")
    private String plan;

    @NotNull(message = "Status is mandatory")
    private MemberStatus status;

    public Member() {
        super();
    }

    public Member(String id, String name, String email, String phone, String vehicle, String vehicleModel, String licensePlate, String plan, MemberStatus status, String joinDate) {
        super(id, joinDate);
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.vehicle = vehicle;
        this.vehicleModel = vehicleModel;
        this.licensePlate = licensePlate;
        this.plan = plan;
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getVehicle() {
        return vehicle;
    }

    public void setVehicle(String vehicle) {
        this.vehicle = vehicle;
    }

    public String getVehicleModel() {
        return vehicleModel;
    }

    public void setVehicleModel(String vehicleModel) {
        this.vehicleModel = vehicleModel;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public String getPlan() {
        return plan;
    }

    public void setPlan(String plan) {
        this.plan = plan;
    }

    public MemberStatus getStatus() {
        return status;
    }

    public void setStatus(MemberStatus status) {
        this.status = status;
    }
}
