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


    public boolean addVehicle(Vehicle vehicle) {
        return vehicleDAO.addVehicle(vehicle);
    }


    public boolean updateVehicle(Vehicle vehicle) {
        return vehicleDAO.updateVehicle(vehicle);
    }


    public boolean deleteVehicle(int vehicleId) {
        return vehicleDAO.deleteVehicle(vehicleId);
    }

}
