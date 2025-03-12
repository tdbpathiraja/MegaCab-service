package com.megacabproject.controllers;

import com.google.gson.Gson;
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

@WebServlet("/VehicleServlet")
public class VehicleServlet extends HttpServlet {
    private final VehicleService vehicleService = new VehicleService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (request.getParameter("categories") != null &&
                Boolean.parseBoolean(request.getParameter("categories"))) {
            List<String> categories = vehicleService.getUniqueVehicleCategories();
            out.print(gson.toJson(categories));
            out.flush();
            return;
        }

        String search = request.getParameter("search");
        List<Vehicle> vehicles = vehicleService.getAllVehicles(search);

        for (Vehicle vehicle : vehicles) {
            System.out.println("Vehicle Name: " + vehicle.getVehicleName() + " | Image: " + vehicle.getVehicleImg());
        }

        out.print(gson.toJson(vehicles));
        out.flush();
    }
}

