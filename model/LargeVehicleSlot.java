package com.parking.model;

public class LargeVehicleSlot extends ParkingSlot {
    @Override
    public double getBaseRateMultiplier() {
        return 1.2; // 20% extra for large slots
    }
}
