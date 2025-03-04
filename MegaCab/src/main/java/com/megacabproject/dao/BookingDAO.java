package com.megacabproject.dao;

import com.megacabproject.models.Booking;
import com.megacabproject.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class BookingDAO {
    private Connection conn;

    public BookingDAO() {
        this.conn = DBConnection.getConnection();
        if (this.conn == null) {
            System.err.println("❌ ERROR: Database connection is NULL!");
        } else {
            System.out.println("✅ BookingDAO connected successfully.");
        }
    }

    // ✅ **Insert Booking Data into Database**
    public boolean insertBooking(Booking booking) {
        String query = "INSERT INTO bookings (booking_id, client_username, customer_name, customer_address, telephone_number, " +
                "booked_vehicle, vehicle_price_per_day, rental_days, total_value, tax_value, " +
                "start_destination, end_destination, discount_code, discount_value) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, booking.getBookingId());
            stmt.setString(2, booking.getUsername());
            stmt.setString(3, booking.getCustomerName());
            stmt.setString(4, booking.getCustomerAddress());
            stmt.setString(5, booking.getTelephoneNumber());
            stmt.setString(6, booking.getBookedVehicle());
            stmt.setDouble(7, booking.getVehiclePricePerDay());
            stmt.setInt(8, booking.getRentalDays());
            stmt.setDouble(9, booking.getTotalValue());
            stmt.setDouble(10, booking.getTaxValue());
            stmt.setString(11, booking.getStartDestination());
            stmt.setString(12, booking.getEndDestination());
            stmt.setString(13, booking.getDiscountCode());
            stmt.setDouble(14, booking.getDiscountValue());

            int rowsInserted = stmt.executeUpdate();
            System.out.println("✅ Booking inserted successfully. Booking ID: " + booking.getBookingId());
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("❌ ERROR: Booking insertion failed! SQL Error: " + e.getMessage());
            return false;
        }
    }

    // ✅ **Retrieve a Booking by Booking ID**
    public Booking getBookingById(String bookingId) {
        String query = "SELECT booking_id, client_username, customer_name, customer_address, telephone_number, " +
                "booked_vehicle, vehicle_price_per_day, rental_days, total_value, tax_value, " +
                "start_destination, end_destination, discount_code, discount_value " +
                "FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String id = rs.getString("booking_id");
                String username = rs.getString("client_username");
                String customerName = rs.getString("customer_name");
                String customerAddress = rs.getString("customer_address");
                String telephoneNumber = rs.getString("telephone_number");
                String bookedVehicle = rs.getString("booked_vehicle");
                double vehiclePricePerDay = rs.getDouble("vehicle_price_per_day");
                int rentalDays = rs.getInt("rental_days");
                double totalValue = rs.getDouble("total_value");
                double taxValue = rs.getDouble("tax_value");
                String startDestination = rs.getString("start_destination");
                String endDestination = rs.getString("end_destination");
                String discountCode = rs.getString("discount_code");
                double discountValue = rs.getDouble("discount_value");

                // Construct and return the Booking object with all details
                return new Booking(id, username, customerName, customerAddress, telephoneNumber,
                        bookedVehicle, vehiclePricePerDay, rentalDays, totalValue, taxValue,
                        startDestination, endDestination, discountCode, discountValue);
            }
        } catch (SQLException e) {
            System.err.println("❌ ERROR: Could not retrieve booking. " + e.getMessage());
        }
        return null;
    }
}