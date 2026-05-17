package com.parkpulse.model;

/**
 * Abstract base class for all vehicles.
 * Demonstrates the principle of Inheritance and Abstraction.
 */
public abstract class Vehicle {
    private String plate;
    private String type;

    public Vehicle(String plate, String type) {
        this.plate = plate;
        this.type = type;
    }

    public String getPlate() { return plate; }
    public String getType() { return type; }

    /**
     * Polimorphic method to get the hourly rate.
     */
    public abstract double getHourlyRate();

    /**
     * Factory method to create a Vehicle instance based on type.
     */
    public static Vehicle create(String plate, String type) {
        if (type == null) return new Car(plate);
        switch (type.toLowerCase()) {
            case "suv": return new SUV(plate);
            case "motorcycle": return new Motorcycle(plate);
            case "truck": return new Truck(plate);
            case "van": return new Van(plate);
            default: return new Car(plate);
        }
    }
}

/**
 * Concrete Vehicle implementations.
 */
class Car extends Vehicle {
    public Car(String plate) { super(plate, "Car"); }
    @Override public double getHourlyRate() { return 300.0; }
}

class SUV extends Vehicle {
    public SUV(String plate) { super(plate, "SUV"); }
    @Override public double getHourlyRate() { return 300.0; }
}

class Motorcycle extends Vehicle {
    public Motorcycle(String plate) { super(plate, "Motorcycle"); }
    @Override public double getHourlyRate() { return 200.0; }
}

class Truck extends Vehicle {
    public Truck(String plate) { super(plate, "Truck"); }
    @Override public double getHourlyRate() { return 400.0; }
}

class Van extends Vehicle {
    public Van(String plate) { super(plate, "Van"); }
    @Override public double getHourlyRate() { return 300.0; }
}
