package com.parking.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

@JsonTypeInfo(
    use = JsonTypeInfo.Id.NAME,
    include = JsonTypeInfo.As.PROPERTY,
    property = "slotType",
    visible = true,
    defaultImpl = StandardSlot.class
)
@JsonSubTypes({
    @JsonSubTypes.Type(value = StandardSlot.class, name = "standard"),
    @JsonSubTypes.Type(value = PremiumSlot.class, name = "premium"),
    @JsonSubTypes.Type(value = LargeVehicleSlot.class, name = "large")
})
public abstract class ParkingSlot {
    private String id;
    private String number;
    private String zoneId;
    private String status;
    private Vehicle vehicle;
    private String reservedBy;

    public ParkingSlot() {}

    // Polymorphic method to get the base rate for this slot type
    @JsonIgnore
    public abstract double getBaseRateMultiplier();

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getNumber() { return number; }
    public void setNumber(String number) { this.number = number; }

    public String getZoneId() { return zoneId; }
    public void setZoneId(String zoneId) { this.zoneId = zoneId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Vehicle getVehicle() { return vehicle; }
    public void setVehicle(Vehicle vehicle) { this.vehicle = vehicle; }

    public String getReservedBy() { return reservedBy; }
    public void setReservedBy(String reservedBy) { this.reservedBy = reservedBy; }
}
