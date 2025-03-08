package com.megacabproject.models;

/**
 * Vehicle Model class representing the 'renting_vehicles' table.
 * - **Encapsulation:** Private fields with public getters & setters.
 * - **Open-Closed Principle:** Allows extension without modification.
 * - **Used in:** DAO Layer, Service Layer.
 */
public class Vehicle {
    private int id;
    private String vehicleName;
    private String vehicleType;
    private String fuelType;
    private String transmission;
    private double pricePerDay;
    private String driverId;      // New field for driver ID
    private String driverName;    // New field for driver name
    private String vehicleImg;
    private String bookingStatus;

    // Constructor with all fields (including new ones)
    public Vehicle(int id, String vehicleName, String vehicleType, String fuelType,
                   String transmission, double pricePerDay, String driverId, String driverName,
                   String vehicleImg, String bookingStatus) {
        this.id = id;
        this.vehicleName = vehicleName;
        this.vehicleType = vehicleType;
        this.fuelType = fuelType;
        this.transmission = transmission;
        this.pricePerDay = pricePerDay;
        this.driverId = driverId;
        this.driverName = driverName;
        this.vehicleImg = vehicleImg;
        this.bookingStatus = bookingStatus;
    }

    // Getters and Setters (Encapsulation)
    public int getId() { return id; }
    public String getVehicleName() { return vehicleName; }
    public String getVehicleType() { return vehicleType; }
    public String getFuelType() { return fuelType; }
    public String getTransmission() { return transmission; }
    public double getPricePerDay() { return pricePerDay; }
    public String getDriverId() { return driverId; }
    public String getDriverName() { return driverName; }
    public String getVehicleImg() { return vehicleImg; }
    public String getBookingStatus() { return bookingStatus; }

    public void setDriverId(String driverId) { this.driverId = driverId; }
    public void setDriverName(String driverName) { this.driverName = driverName; }
    public void setVehicleName(String vehicleName) { this.vehicleName = vehicleName; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
    public void setFuelType(String fuelType) { this.fuelType = fuelType; }
    public void setTransmission(String transmission) { this.transmission = transmission; }
    public void setPricePerDay(double pricePerDay) { this.pricePerDay = pricePerDay; }
    public void setVehicleImg(String vehicleImg) { this.vehicleImg = vehicleImg; }
    public void setBookingStatus(String bookingStatus) { this.bookingStatus = bookingStatus; }
}