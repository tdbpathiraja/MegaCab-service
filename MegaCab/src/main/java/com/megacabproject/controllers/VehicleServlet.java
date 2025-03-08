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

        // If 'categories' parameter is provided, return unique vehicle categories
        if (request.getParameter("categories") != null &&
                Boolean.parseBoolean(request.getParameter("categories"))) {
            List<String> categories = vehicleService.getUniqueVehicleCategories();
            out.print(gson.toJson(categories));
            out.flush();
            return;
        }

        // Otherwise, fetch and return the list of vehicles
        String search = request.getParameter("search");  // optional search string
        List<Vehicle> vehicles = vehicleService.getAllVehicles(search);
        out.print(gson.toJson(vehicles));
        out.flush();
    }
}
