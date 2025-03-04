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
    private String vehicleImg;
    private String bookingStatus;

    // Constructor
    public Vehicle(int id, String vehicleName, String vehicleType, String fuelType,
                   String transmission, double pricePerDay, String vehicleImg, String bookingStatus) {
        this.id = id;
        this.vehicleName = vehicleName;
        this.vehicleType = vehicleType;
        this.fuelType = fuelType;
        this.transmission = transmission;
        this.pricePerDay = pricePerDay;
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
    public String getVehicleImg() { return vehicleImg; }
    public String getBookingStatus() { return bookingStatus; }

    public void setBookingStatus(String bookingStatus) { this.bookingStatus = bookingStatus; }
}