package com.megacabproject.services;

import com.megacabproject.dao.VehicleDAO;
import com.megacabproject.models.Vehicle;
import java.util.List;
import java.util.stream.Collectors;


public class VehicleService {
    private VehicleDAO vehicleDAO;

    public VehicleService() {
        this.vehicleDAO = new VehicleDAO();
    }


    public List<Vehicle> getAllVehicles(String search) {
        return vehicleDAO.getAllVehicles(search);
    }

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
