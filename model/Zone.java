package com.parking.model;

import java.util.List;

public class Zone {
    private String id;
    private String name;
    private double pricePerHour;
    private List<String> allowedVehicleTypes;

    public Zone() {}

    public Zone(String id, String name, double pricePerHour, List<String> allowedVehicleTypes) {
        this.id = id;
        this.name = name;
        this.pricePerHour = pricePerHour;
        this.allowedVehicleTypes = allowedVehicleTypes;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPricePerHour() { return pricePerHour; }
    public void setPricePerHour(double pricePerHour) { this.pricePerHour = pricePerHour; }

    public List<String> getAllowedVehicleTypes() { return allowedVehicleTypes; }
    public void setAllowedVehicleTypes(List<String> allowedVehicleTypes) { this.allowedVehicleTypes = allowedVehicleTypes; }
}
