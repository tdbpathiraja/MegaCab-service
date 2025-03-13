package com.megacabproject.models;

public class Booking {
    private String bookingId;
    private String username;
    private String customerName;
    private String customerAddress;
    private String telephoneNumber;
    private String bookedVehicle;
    private double vehiclePricePerDay;
    private int rentalDays;
    private double totalValue;
    private double taxValue;
    private String startDestination;
    private String endDestination;
    private String discountCode;
    private double discountValue;

    /**
     * 🔹 Constructor: Initializes a new Booking object.
     */
    public Booking(String bookingId, String username, String customerName, String customerAddress, String telephoneNumber,
                   String bookedVehicle, double vehiclePricePerDay, int rentalDays, double totalValue, double taxValue,
                   String startDestination, String endDestination, String discountCode, double discountValue) {
        this.bookingId = bookingId;
        this.username = username;
        this.customerName = customerName;
        this.customerAddress = customerAddress;
        this.telephoneNumber = telephoneNumber;
        this.bookedVehicle = bookedVehicle;
        this.vehiclePricePerDay = vehiclePricePerDay;
        this.rentalDays = rentalDays;
        this.totalValue = totalValue;
        this.taxValue = taxValue;
        this.startDestination = startDestination;
        this.endDestination = endDestination;
        this.discountCode = discountCode;
        this.discountValue = discountValue;
    }

    // 🔹 Getters and Setters


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public String getTelephoneNumber() {
        return telephoneNumber;
    }

    public void setTelephoneNumber(String telephoneNumber) {
        this.telephoneNumber = telephoneNumber;
    }

    public String getBookedVehicle() {
        return bookedVehicle;
    }

    public void setBookedVehicle(String bookedVehicle) {
        this.bookedVehicle = bookedVehicle;
    }

    public double getVehiclePricePerDay() {
        return vehiclePricePerDay;
    }

    public void setVehiclePricePerDay(double vehiclePricePerDay) {
        this.vehiclePricePerDay = vehiclePricePerDay;
    }

    public int getRentalDays() {
        return rentalDays;
    }

    public void setRentalDays(int rentalDays) {
        this.rentalDays = rentalDays;
    }

    public double getTotalValue() {
        return totalValue;
    }

    public void setTotalValue(double totalValue) {
        this.totalValue = totalValue;
    }

    public double getTaxValue() {
        return taxValue;
    }

    public void setTaxValue(double taxValue) {
        this.taxValue = taxValue;
    }

    public String getStartDestination() {
        return startDestination;
    }

    public void setStartDestination(String startDestination) {
        this.startDestination = startDestination;
    }

    public String getEndDestination() {
        return endDestination;
    }

    public void setEndDestination(String endDestination) {
        this.endDestination = endDestination;
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

    public Double getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(Double discountValue) {
        this.discountValue = discountValue;
    }
}