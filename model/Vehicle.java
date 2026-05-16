package com.parking.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;

@JsonTypeInfo(
    use = JsonTypeInfo.Id.NAME,
    include = JsonTypeInfo.As.PROPERTY,
    property = "type",
    visible = true,
    defaultImpl = Car.class
)
@JsonSubTypes({
    @JsonSubTypes.Type(value = Car.class, name = "Sedan"),
    @JsonSubTypes.Type(value = Car.class, name = "SUV"),
    @JsonSubTypes.Type(value = Car.class, name = "Hatchback"),
    @JsonSubTypes.Type(value = Motorcycle.class, name = "Motorcycle"),
    @JsonSubTypes.Type(value = Motorcycle.class, name = "Motorbike"),
    @JsonSubTypes.Type(value = Truck.class, name = "Truck"),
    @JsonSubTypes.Type(value = Van.class, name = "Van")
})
public abstract class Vehicle {
    private String licensePlate;
    private String type; // This matches the frontend's vehicle type string
    private String owner;
    private String phone;
    private String email;
    private String entryTime;
    private String duration;

    public Vehicle() {}

    // Polymorphic method: each vehicle type provides its own fee multiplier
    @JsonIgnore
    public abstract double getFeeMultiplier();

    public String getLicensePlate() { return licensePlate; }
    public void setLicensePlate(String licensePlate) { this.licensePlate = licensePlate; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getOwner() { return owner; }
    public void setOwner(String owner) { this.owner = owner; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getEntryTime() { return entryTime; }
    public void setEntryTime(String entryTime) { this.entryTime = entryTime; }

    public String getDuration() { return duration; }
    public void setDuration(String duration) { this.duration = duration; }
}
