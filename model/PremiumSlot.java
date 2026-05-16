package com.parking.model;

public class PremiumSlot extends ParkingSlot {
    @Override
    public double getBaseRateMultiplier() {
        return 1.5; // 50% premium for these slots
    }
}
