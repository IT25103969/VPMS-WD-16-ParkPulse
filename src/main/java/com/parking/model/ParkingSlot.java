package com.parking.model;

public class ParkingSlot {
    private String id;
    private String number;
    private String zoneId;
    private String status; // available, occupied, reserved, maintenance
    private String reservedBy; // staff, member
    private Vehicle vehicle;

    public ParkingSlot() {}

    public ParkingSlot(String id, String number, String zoneId, String status, String reservedBy, Vehicle vehicle) {
        this.id = id;
        this.number = number;
        this.zoneId = zoneId;
        this.status = status;
        this.reservedBy = reservedBy;
        this.vehicle = vehicle;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getNumber() { return number; }
    public void setNumber(String number) { this.number = number; }
    public String getZoneId() { return zoneId; }
    public void setZoneId(String zoneId) { this.zoneId = zoneId; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getReservedBy() { return reservedBy; }
    public void setReservedBy(String reservedBy) { this.reservedBy = reservedBy; }
    public Vehicle getVehicle() { return vehicle; }
    public void setVehicle(Vehicle vehicle) { this.vehicle = vehicle; }

    public static class Vehicle {
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
}
