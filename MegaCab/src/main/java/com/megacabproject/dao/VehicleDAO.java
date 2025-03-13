package com.megacabproject.dao;

import com.megacabproject.models.Vehicle;
import com.megacabproject.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


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