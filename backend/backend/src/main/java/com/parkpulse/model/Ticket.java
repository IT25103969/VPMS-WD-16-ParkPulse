package com.parkpulse.model;

public class Ticket {
    private String id;
    private String vehiclePlate;
    private String ownerName;
    private String slot;
    private String entryTime;
    private String exitTime;
    private Double amount;
    private String status;
    private String vehicleType;
    private String paymentMethod;

    public Ticket() {}

    public Ticket(String id, String vehiclePlate, String ownerName, String slot, String entryTime, String exitTime, Double amount, String status, String vehicleType, String paymentMethod) {
        this.id = id;
        this.vehiclePlate = vehiclePlate;
        this.ownerName = ownerName;
        this.slot = slot;
        this.entryTime = entryTime;
        this.exitTime = exitTime;
        this.amount = amount;
        this.status = status;
        this.vehicleType = vehicleType;
        this.paymentMethod = paymentMethod;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getVehiclePlate() { return vehiclePlate; }
    public void setVehiclePlate(String vehiclePlate) { this.vehiclePlate = vehiclePlate; }

    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }

    public String getSlot() { return slot; }
    public void setSlot(String slot) { this.slot = slot; }

    public String getEntryTime() { return entryTime; }
    public void setEntryTime(String entryTime) { this.entryTime = entryTime; }

    public String getExitTime() { return exitTime; }
    public void setExitTime(String exitTime) { this.exitTime = exitTime; }

    public Double getAmount() { return amount; }
    public void setAmount(Double amount) { this.amount = amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    /**
     * Demonstrates Encapsulation by handling its own state transition and calculation.
     */
    public void completePayment(String exitTime, String method) {
        this.exitTime = exitTime;
        this.paymentMethod = method;
        this.status = "finished";
        
        // Use polymorphism to get the correct rate
        Vehicle vehicle = Vehicle.create(this.vehiclePlate, this.vehicleType);
        double rate = vehicle.getHourlyRate();
        
        // Calculate duration and amount
        try {
            java.time.LocalDateTime start = java.time.LocalDateTime.parse(this.entryTime);
            java.time.LocalDateTime end = java.time.LocalDateTime.parse(exitTime);
            long minutes = java.time.Duration.between(start, end).toMinutes();
            double hours = Math.ceil(minutes / 60.0);
            if (hours < 1) hours = 1;
            this.amount = hours * rate;
        } catch (Exception e) {
            this.amount = rate; // Fallback to 1 hour
        }
    }

    public String toCsv() {
        return String.format("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
                id,
                vehiclePlate,
                ownerName,
                slot,
                entryTime,
                exitTime != null ? exitTime : "",
                amount != null ? amount : 0.0,
                status,
                vehicleType,
                paymentMethod != null ? paymentMethod : "");
    }

    public static Ticket fromCsv(String csv) {
        String[] parts = csv.split(",", -1);
        if (parts.length < 10) return null;
        Ticket ticket = new Ticket();
        ticket.setId(parts[0]);
        ticket.setVehiclePlate(parts[1]);
        ticket.setOwnerName(parts[2]);
        ticket.setSlot(parts[3]);
        ticket.setEntryTime(parts[4]);
        ticket.setExitTime(parts[5].isEmpty() ? null : parts[5]);
        ticket.setAmount(parts[6].isEmpty() ? 0.0 : Double.parseDouble(parts[6]));
        ticket.setStatus(parts[7]);
        ticket.setVehicleType(parts[8]);
        ticket.setPaymentMethod(parts[9].isEmpty() ? null : parts[9]);
        return ticket;
    }
}
