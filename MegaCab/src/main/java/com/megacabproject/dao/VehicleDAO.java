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
            System.err.println("❌ ERROR: Database connection is NULL in VehicleDAO!");
        } else {
            System.out.println("✅ VehicleDAO connected to the database.");
        }
    }

    /**
     * Fetches all vehicles from the database.
     * - **Used in:** Service Layer
     * - **Returns:** List of Vehicle objects.
     */
    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String query = "SELECT * FROM renting_vehicles";

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
                        rs.getString("vehicle_img"),
                        rs.getString("booking_status")
                ));
            }
        } catch (SQLException e) {
            System.err.println("❌ ERROR: Failed to fetch vehicles: " + e.getMessage());
        }
        return vehicles;
    }

    /**
     * Fetches distinct vehicle categories for filtering.
     * - **Returns:** List of unique vehicle categories.
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
            e.printStackTrace();
        }
        return categories;
    }

}