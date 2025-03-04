package com.megacabproject.controllers;

import com.megacabproject.models.Vehicle;
import com.megacabproject.services.VehicleService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet to handle vehicle data retrieval.
 * - **Application Layer:** Web Service that provides vehicle data.
 * - **Used in:** Frontend (our-vehicles.jsp)
 */
@WebServlet("/VehicleServlet")
public class VehicleServlet extends HttpServlet {
    private VehicleService vehicleService = new VehicleService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoriesRequest = request.getParameter("categories");

        if (categoriesRequest != null && categoriesRequest.equals("true")) {
            // Return unique vehicle categories
            List<String> uniqueCategories = vehicleService.getUniqueVehicleCategories();
            JSONArray jsonArray = new JSONArray(uniqueCategories);

            response.setContentType("application/json");
            response.getWriter().write(jsonArray.toString());
        } else {
            // Default: Return all vehicles
            List<Vehicle> vehicles = vehicleService.getAllVehicles();
            JSONArray jsonArray = new JSONArray();

            for (Vehicle v : vehicles) {
                JSONObject json = new JSONObject();
                json.put("id", v.getId());
                json.put("vehicleName", v.getVehicleName());
                json.put("vehicleType", v.getVehicleType());
                json.put("fuelType", v.getFuelType());
                json.put("transmission", v.getTransmission());
                json.put("pricePerDay", v.getPricePerDay());
                json.put("vehicleImg", v.getVehicleImg());
                json.put("bookingStatus", v.getBookingStatus());
                jsonArray.put(json);
            }

            response.setContentType("application/json");
            response.getWriter().write(jsonArray.toString());
        }
    }
}
