package com.megacabproject.dao;

import com.megacabproject.models.Booking;
import com.megacabproject.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private Connection conn;

    public BookingDAO() {
        this.conn = DBConnection.getConnection();
        if (this.conn == null) {
            System.err.println("ERROR: Database connection is NULL!");
        } else {
            System.out.println("BookingDAO connected successfully.");
        }
    }

    // Existing method to insert a booking
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
            System.out.println("Booking inserted successfully. Booking ID: " + booking.getBookingId());
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.err.println("ERROR: Booking insertion failed! SQL Error: " + e.getMessage());
            return false;
        }
    }

    // Method to retrieve all bookings from the database
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getString("booking_id"),
                        rs.getString("client_username"),
                        rs.getString("customer_name"),
                        rs.getString("customer_address"),
                        rs.getString("telephone_number"),
                        rs.getString("booked_vehicle"),
                        rs.getDouble("vehicle_price_per_day"),
                        rs.getInt("rental_days"),
                        rs.getDouble("total_value"),
                        rs.getDouble("tax_value"),
                        rs.getString("start_destination"),
                        rs.getString("end_destination"),
                        rs.getString("discount_code"),
                        rs.getDouble("discount_value")
                );
                bookings.add(booking);
            }
        } catch (SQLException e) {
            System.err.println("ERROR: Failed to fetch all bookings: " + e.getMessage());
        }
        return bookings;
    }

    // Method to delete a booking by booking ID
    public boolean deleteBooking(String bookingId) {
        String query = "DELETE FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, bookingId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.err.println("ERROR: Failed to delete booking: " + e.getMessage());
            return false;
        }
    }

    public List<Booking> getBookingsByUsername(String username) {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT * FROM bookings WHERE client_username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking(
                        rs.getString("booking_id"),
                        rs.getString("client_username"),
                        rs.getString("customer_name"),
                        rs.getString("customer_address"),
                        rs.getString("telephone_number"),
                        rs.getString("booked_vehicle"),
                        rs.getDouble("vehicle_price_per_day"),
                        rs.getInt("rental_days"),
                        rs.getDouble("total_value"),
                        rs.getDouble("tax_value"),
                        rs.getString("start_destination"),
                        rs.getString("end_destination"),
                        rs.getString("discount_code"),
                        rs.getDouble("discount_value")
                );
                bookings.add(booking);
            }
        } catch (SQLException e) {
            System.err.println("ERROR: Failed to fetch bookings by username: " + e.getMessage());
        }
        return bookings;
    }


    // Existing method to retrieve a booking by booking ID
    public Booking getBookingById(String bookingId) {
        String query = "SELECT booking_id, client_username, customer_name, customer_address, telephone_number, " +
                "booked_vehicle, vehicle_price_per_day, rental_days, total_value, tax_value, " +
                "start_destination, end_destination, discount_code, discount_value " +
                "FROM bookings WHERE booking_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Booking(
                        rs.getString("booking_id"),
                        rs.getString("client_username"),
                        rs.getString("customer_name"),
                        rs.getString("customer_address"),
                        rs.getString("telephone_number"),
                        rs.getString("booked_vehicle"),
                        rs.getDouble("vehicle_price_per_day"),
                        rs.getInt("rental_days"),
                        rs.getDouble("total_value"),
                        rs.getDouble("tax_value"),
                        rs.getString("start_destination"),
                        rs.getString("end_destination"),
                        rs.getString("discount_code"),
                        rs.getDouble("discount_value")
                );
            }
        } catch (SQLException e) {
            System.err.println("ERROR: Could not retrieve booking. " + e.getMessage());
        }
        return null;
    }
}