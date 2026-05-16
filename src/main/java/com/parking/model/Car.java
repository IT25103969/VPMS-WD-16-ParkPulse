package com.parking.model;

public class Car extends Vehicle {
    @Override
    public double getFeeMultiplier() {
        return 1.0; // Base multiplier for standard cars
    }
}
