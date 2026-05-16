package com.vpms.membermanagement.model;

/**
 * Demonstrates Inheritance.
 * Member inherits id and joinDate from BaseEntity.
 */
public class Member extends BaseEntity {
    private String name;
    private String email;
    private String phone;
    private String vehicle;
    private String vehicleModel;
    private String licensePlate;
    private String plan;
    private String status;

    public Member() {
        super();
    }

    public Member(String id, String name, String email, String phone, String vehicle, String vehicleModel, String licensePlate, String plan, String status, String joinDate) {
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
