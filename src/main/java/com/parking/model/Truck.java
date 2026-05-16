package com.parking.model;

public class Truck extends Vehicle {
    @Override
    public double getFeeMultiplier() {
        return 2.0; // Double price for large trucks
    }
}
