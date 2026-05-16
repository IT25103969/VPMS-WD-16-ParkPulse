package com.parking.model;

public class Motorcycle extends Vehicle {
    @Override
    public double getFeeMultiplier() {
        return 0.5; // 50% discount for motorcycles
    }
}
