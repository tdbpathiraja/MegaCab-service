package com.megacabproject.controllers.admin;

import com.google.gson.Gson;
import com.megacabproject.models.Vehicle;
import com.megacabproject.services.VehicleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet("/VehicleController")
@MultipartConfig
public class VehicleControllerServlet extends HttpServlet {

    private final VehicleService vehicleService = new VehicleService();
    private final Gson gson = new Gson();
    private String uploadPath;

    @Override
    public void init() throws ServletException {
        // Set the absolute path for vehicle image storage.
        uploadPath = getServletContext().getRealPath("src/img/Vehicles/");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // JSON response for AJAX
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String search = request.getParameter("search");
        String action = request.getParameter("action");
        if (action == null) {
            out.print(gson.toJson("No action specified"));
            return;
        }
        if (action.equalsIgnoreCase("list")) {
            List<Vehicle> vehicles = vehicleService.getAllVehicles(search);
            Map<String, Object> listResult = new HashMap<>();
            listResult.put("vehicles", vehicles);
            listResult.put("totalVehicles", vehicles.size());
            out.print(gson.toJson(listResult));
        } else {
            out.print(gson.toJson("Invalid action"));
        }
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // JSON response for AJAX
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Map<String, Object> result = new HashMap<>();
        String action = request.getParameter("action");
        if (action == null) {
            result.put("success", false);
            result.put("message", "No action specified");
            out.print(gson.toJson(result));
            out.flush();
            return;
        }

        String newFileName = "";
        Part filePart = null;

        switch (action.toLowerCase()) {
            case "add":
                // Handle file upload for new vehicle
                filePart = request.getPart("vehicleImg");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    newFileName = System.currentTimeMillis() + "_" + fileName;
                    filePart.write(uploadPath + File.separator + newFileName);
                }
                // Retrieve vehicle details; auto-generate driver ID if needed.
                String vehicleName = request.getParameter("vehicleName");
                String vehicleType = request.getParameter("vehicleType");
                String fuelType = request.getParameter("fuelType");
                String transmission = request.getParameter("transmission");
                double pricePerDay = Double.parseDouble(request.getParameter("pricePerDay"));
                String driverId = request.getParameter("driverId");
                String driverName = request.getParameter("driverName");
                // For new vehicles, status is set to "available"
                Vehicle newVehicle = new Vehicle(0, vehicleName, vehicleType, fuelType, transmission,
                        pricePerDay, driverId, driverName, newFileName, "available");
                boolean added = vehicleService.addVehicle(newVehicle);
                result.put("success", added);
                result.put("message", added ? "Vehicle added successfully" : "Failed to add vehicle");
                break;

            case "update":
                int id = Integer.parseInt(request.getParameter("vehicleId"));
                String oldVehicleImg = request.getParameter("oldVehicleImg");
                filePart = request.getPart("vehicleImg");
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    newFileName = System.currentTimeMillis() + "_" + fileName;
                    filePart.write(uploadPath + File.separator + newFileName);
                    // Delete old image file if present
                    if (oldVehicleImg != null && !oldVehicleImg.isEmpty()) {
                        File oldFile = new File(uploadPath + File.separator + oldVehicleImg);
                        if (oldFile.exists()) {
                            oldFile.delete();
                        }
                    }
                } else {
                    newFileName = oldVehicleImg;
                }
                vehicleName = request.getParameter("vehicleName");
                vehicleType = request.getParameter("vehicleType");
                fuelType = request.getParameter("fuelType");
                transmission = request.getParameter("transmission");
                pricePerDay = Double.parseDouble(request.getParameter("pricePerDay"));
                driverId = request.getParameter("driverId");
                driverName = request.getParameter("driverName");
                // In update, driverId is not changed.
                Vehicle updatedVehicle = new Vehicle(id, vehicleName, vehicleType, fuelType, transmission,
                        pricePerDay, driverId, driverName, newFileName, null);
                boolean updated = vehicleService.updateVehicle(updatedVehicle);
                result.put("success", updated);
                result.put("message", updated ? "Vehicle updated successfully" : "Failed to update vehicle");
                break;

            case "delete":
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                // Lookup vehicle without filtering by search term
                List<Vehicle> vehicles = vehicleService.getAllVehicles("");
                Vehicle vehicleToDelete = vehicles.stream().filter(v -> v.getId() == vehicleId).findFirst().orElse(null);
                if (vehicleToDelete != null && "booked".equalsIgnoreCase(vehicleToDelete.getBookingStatus())) {
                    result.put("success", false);
                    result.put("message", "Vehicle is booked and cannot be deleted.");
                } else {
                    if (vehicleToDelete != null && vehicleToDelete.getVehicleImg() != null && !vehicleToDelete.getVehicleImg().isEmpty()) {
                        File fileToDelete = new File(uploadPath + File.separator + vehicleToDelete.getVehicleImg());
                        if (fileToDelete.exists()) {
                            fileToDelete.delete();
                        }
                    }
                    boolean deleted = vehicleService.deleteVehicle(vehicleId);
                    result.put("success", deleted);
                    result.put("message", deleted ? "Vehicle deleted successfully" : "Failed to delete vehicle");
                }
                break;

            default:
                result.put("success", false);
                result.put("message", "Invalid action");
        }

        out.print(gson.toJson(result));
        out.flush();
    }
}