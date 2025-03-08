package com.megacabproject.services;

import com.megacabproject.dao.VehicleDAO;
import com.megacabproject.models.Vehicle;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service class for Vehicle operations.
 * - **Service Layer:** Handles business logic and acts as an intermediary between the controller and DAO.
 * - **Encapsulation:** Provides abstraction over DAO operations.
 */
public class VehicleService {
    private VehicleDAO vehicleDAO;

    public VehicleService() {
        this.vehicleDAO = new VehicleDAO();
    }

    /**
     * Retrieves all vehicles based on a search parameter.
     * @param search Search string for filtering vehicles by name.
     * @return List of Vehicle objects.
     */
    public List<Vehicle> getAllVehicles(String search) {
        return vehicleDAO.getAllVehicles(search);
    }

    /**
     * Retrieves unique vehicle categories.
     * - **DSA Concept:** Uses Java Streams to filter distinct categories.
     * @return List of unique vehicle category strings.
     */
    public List<String> getUniqueVehicleCategories() {
        List<String> categories = vehicleDAO.getAllVehicleCategories();
        return categories.stream().distinct().collect(Collectors.toList());
    }

    /**
     * Adds a new vehicle.
     * @param vehicle Vehicle object with new vehicle data.
     * @return true if vehicle added successfully, false otherwise.
     */
    public boolean addVehicle(Vehicle vehicle) {
        return vehicleDAO.addVehicle(vehicle);
    }

    /**
     * Updates an existing vehicle.
     * @param vehicle Vehicle object with updated data.
     * @return true if update successful, false otherwise.
     */
    public boolean updateVehicle(Vehicle vehicle) {
        return vehicleDAO.updateVehicle(vehicle);
    }

    /**
     * Deletes a vehicle by its ID.
     * @param vehicleId Unique identifier of the vehicle.
     * @return true if deletion successful, false otherwise.
     */
    public boolean deleteVehicle(int vehicleId) {
        return vehicleDAO.deleteVehicle(vehicleId);
    }

}
