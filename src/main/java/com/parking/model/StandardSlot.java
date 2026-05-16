package com.parking.model;

public class StandardSlot extends ParkingSlot {
    @Override
    public double getBaseRateMultiplier() {
        return 1.0;
    }
}
