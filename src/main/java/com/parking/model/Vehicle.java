package com.parking.model;

public class Vehicle {
    private String licensePlate;
    private String type;
    private String owner;
    private String phone;
    private String email;
    private String entryTime;
    private String duration;

    public Vehicle() {}

    public String getLicensePlate() { return licensePlate; }
    public void setLicensePlate(String licensePlate) { this.licensePlate = licensePlate; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getOwner() { return owner; }
    public void setOwner(String owner) { this.owner = owner; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getEntryTime() { return entryTime; }
    public void setEntryTime(String entryTime) { this.entryTime = entryTime; }

    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }
}
