package com.parking.model;

public class Van extends Vehicle {
    @Override
    public double getFeeMultiplier() {
        return 1.5; // 50% extra for vans
    }
}
