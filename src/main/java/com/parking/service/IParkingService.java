package com.parking.service;

import com.parking.model.ParkingSlot;
import com.parking.model.Zone;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * IParkingService defines the contract for parking management operations.
 * Demonstrates the pillar of Abstraction by hiding implementation details.
 */
public interface IParkingService {
    List<Zone> getZones();
    List<ParkingSlot> getSlots();
    Map<String, Object> getStats();
    void handleAction(String action, Map<String, String[]> params) throws IOException;
    double calculateFee(String slotId);
}
