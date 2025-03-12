package com.megacabproject.dao;

import com.megacabproject.models.Vehicle;
import com.megacabproject.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO Class for managing database operations related to Vehicles.
 * - **DAO Pattern:** Separates database logic from business logic.
 * - **Encapsulation:** Private fields for database operations.
 */
public class VehicleDAO {
    private Connection conn;

    // Constructor: Establish database connection
    public VehicleDAO() {
        this.conn = DBConnection.getConnection();
        if (this.conn == null) {
            System.err.println("ERROR: Database connection is NULL in VehicleDAO!");
        } else {
            System.out.println("VehicleDAO connected to the database.");
        }
    }

    /**
     * Fetches all vehicles from the database with optional search.
     * - **Used in:** Service Layer, Listing in Vehicles Section.
     * - **DSA Concept:** Uses ArrayList to store and return Vehicle objects.
     * @param search Search string (vehicle name) – if null or empty, returns all vehicles.
     * @return List of Vehicle objects.
     */
    public List<Vehicle> getAllVehicles(String search) {
        List<Vehicle> vehicles = new ArrayList<>();
        String query;
        try {
            if (search == null || search.trim().isEmpty()) {
                query = "SELECT * FROM renting_vehicles";
                try (PreparedStatement stmt = conn.prepareStatement(query);
                     ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        vehicles.add(new Vehicle(
                                rs.getInt("id"),
                                rs.getString("vehicle_name"),
                                rs.getString("vehicle_type"),
                                rs.getString("fuel_type"),
                                rs.getString("transmission"),
                                rs.getDouble("price_per_day"),
                                rs.getString("driver_id"),
                                rs.getString("driver_name"),
                                rs.getString("vehicle_img"),
                                rs.getString("booking_status")
                        ));
                    }
                }
            } else {
                query = "SELECT * FROM renting_vehicles WHERE vehicle_name LIKE ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, "%" + search + "%");
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            vehicles.add(new Vehicle(
                                    rs.getInt("id"),
                                    rs.getString("vehicle_name"),
                                    rs.getString("vehicle_type"),
                                    rs.getString("fuel_type"),
                                    rs.getString("transmission"),
                                    rs.getDouble("price_per_day"),
                                    rs.getString("driver_id"),
                                    rs.getString("driver_name"),
                                    rs.getString("vehicle_img"),
                                    rs.getString("booking_status")
                            ));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("ERROR: Failed to fetch vehicles: " + e.getMessage());
        }
        return vehicles;
    }

    /**
     * Fetches distinct vehicle categories for filtering.
     * - **Returns:** List of unique vehicle category strings.
     */
    public List<String> getAllVehicleCategories() {
        List<String> categories = new ArrayList<>();
        String query = "SELECT DISTINCT vehicle_type FROM renting_vehicles";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("vehicle_type"));
            }
        } catch (SQLException e) {
            System.err.println("ERROR: Failed to fetch vehicle categories: " + e.getMessage());
        }
        return categories;
    }


    /**
     * Adds a new vehicle to the database.
     * - **Design Pattern:** DAO Pattern.
     * @param vehicle Vehicle object containing new vehicle data.
     * @return true if insertion is successful, false otherwise.
     */
    public boolean addVehicle(Vehicle vehicle) {
        String query = "INSERT INTO renting_vehicles (vehicle_name, vehicle_type, fuel_type, transmission, price_per_day, driver_id, driver_name, vehicle_img, booking_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, vehicle.getVehicleName());
            stmt.setString(2, vehicle.getVehicleType());
            stmt.setString(3, vehicle.getFuelType());
            stmt.setString(4, vehicle.getTransmission());
            stmt.setDouble(5, vehicle.getPricePerDay());
            stmt.setString(6, vehicle.getDriverId());
            stmt.setString(7, vehicle.getDriverName());
            stmt.setString(8, vehicle.getVehicleImg());
            // For add, set status to available by default (no status change part)
            stmt.setString(9, "available");
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch(SQLException e) {
            System.err.println("ERROR: Failed to add vehicle: " + e.getMessage());
            return false;
        }
    }

    /**
     * Updates an existing vehicle in the database.
     * - **Design Pattern:** DAO Pattern.
     * @param vehicle Vehicle object containing updated vehicle data.
     * @return true if update is successful, false otherwise.
     */
    public boolean updateVehicle(Vehicle vehicle) {
        String query = "UPDATE renting_vehicles SET vehicle_name = ?, vehicle_type = ?, fuel_type = ?, transmission = ?, price_per_day = ?, driver_id = ?, driver_name = ?, vehicle_img = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, vehicle.getVehicleName());
            stmt.setString(2, vehicle.getVehicleType());
            stmt.setString(3, vehicle.getFuelType());
            stmt.setString(4, vehicle.getTransmission());
            stmt.setDouble(5, vehicle.getPricePerDay());
            stmt.setString(6, vehicle.getDriverId());
            stmt.setString(7, vehicle.getDriverName());
            stmt.setString(8, vehicle.getVehicleImg());
            stmt.setInt(9, vehicle.getId());
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch(SQLException e) {
            System.err.println("ERROR: Failed to update vehicle: " + e.getMessage());
            return false;
        }
    }

    /**
     * Deletes a vehicle from the database by vehicle ID.
     * - **Design Pattern:** DAO Pattern.
     * @param vehicleId Unique identifier for the vehicle.
     * @return true if deletion is successful, false otherwise.
     */
    public boolean deleteVehicle(int vehicleId) {
        String query = "DELETE FROM renting_vehicles WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, vehicleId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch(SQLException e) {
            System.err.println("ERROR: Failed to delete vehicle: " + e.getMessage());
            return false;
        }
    }
}