package com.megacabproject.services;

import com.megacabproject.dao.VehicleDAO;
import com.megacabproject.models.Vehicle;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service class for Vehicle operations.
 * - **Service Layer:** Handles business logic.
 * - **Encapsulation:** Provides abstraction over DAO operations.
 */
public class VehicleService {
    private VehicleDAO vehicleDAO;

    public VehicleService() {
        this.vehicleDAO = new VehicleDAO();
    }

    public List<Vehicle> getAllVehicles() {
        return vehicleDAO.getAllVehicles();
    }

    public List<String> getUniqueVehicleCategories() {
        List<String> categories = vehicleDAO.getAllVehicleCategories();
        return categories.stream().distinct().collect(Collectors.toList());
    }

}