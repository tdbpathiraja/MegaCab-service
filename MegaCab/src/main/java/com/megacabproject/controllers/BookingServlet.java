package com.megacabproject.controllers;

import com.megacabproject.models.Booking;
import com.megacabproject.services.BookingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * 🔹 BookingServlet - Handles Booking Submission
 * - **Design Pattern Used:** Singleton (for BookingService)
 * - **OOP Concepts:** Encapsulation (Booking object), Abstraction & Inheritance
 */
@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private final BookingService bookingService = new BookingService(); // Singleton Pattern

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // ✅ **Log Parameters to Identify Missing Values**
        System.out.println("Received Booking Request...");
        System.out.println("Logged  User: " + request.getParameter("username"));
        System.out.println("Customer Name: " + request.getParameter("customerName"));
        System.out.println("Customer Email: " + request.getParameter("customerEmail"));
        System.out.println("Customer Address: " + request.getParameter("customerAddress"));
        System.out.println("Customer Phone: " + request.getParameter("telephoneNumber"));
        System.out.println("Vehicle ID: " + request.getParameter("vehicleId"));
        System.out.println("Vehicle Name: " + request.getParameter("vehicleName"));
        System.out.println("Vehicle Price: " + request.getParameter("vehiclePrice"));
        System.out.println("Rental Days: " + request.getParameter("rentalDays"));
        System.out.println("Start Destination: " + request.getParameter("startDestination"));
        System.out.println("End Destination: " + request.getParameter("endDestination"));
        System.out.println("Discount Code: " + request.getParameter("discountCode"));
        System.out.println("Discount Percentage: " + request.getParameter("discountPercentage"));

        // ✅ **Retrieve Parameters & Trim to Prevent Errors**
        String login = request.getParameter("username");
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String customerAddress = request.getParameter("customerAddress");
        String customerPhone = request.getParameter("telephoneNumber");
        String vehicleId = request.getParameter("vehicleId");
        String vehicleName = request.getParameter("vehicleName");
        String vehiclePriceStr = request.getParameter("vehiclePrice");
        String rentalDaysStr = request.getParameter("rentalDays");
        String startDestination = request.getParameter("startDestination");
        String endDestination = request.getParameter("endDestination");
        String discountCode = request.getParameter("discountCode");
        String discountPercentageStr = request.getParameter("discountPercentage");

        // 🚨 **Check for Missing Parameters**
        if (login == null || customerName == null || customerEmail == null || customerAddress == null ||
                customerPhone == null || vehicleId == null || vehicleName == null ||
                vehiclePriceStr == null || rentalDaysStr == null ||
                startDestination == null || endDestination == null ||
                vehicleId.isEmpty() || startDestination.isEmpty() || endDestination.isEmpty()) {
            System.err.println("❌ ERROR: Missing required parameters in the booking request!");
            response.sendRedirect("booking-cab.jsp?error=missing_params");
            return;
        }

        // ✅ **Parse Numeric Values Safely**
        double vehiclePrice = 0.0;
        int rentalDays = 1;
        double discountPercentage = 0.0; // Default to 0%

        try {
            vehiclePrice = Double.parseDouble(vehiclePriceStr.trim());
            rentalDays = Integer.parseInt(rentalDaysStr.trim());

            if (discountPercentageStr != null && !discountPercentageStr.trim().isEmpty()) {
                discountPercentage = Double.parseDouble(discountPercentageStr.trim());
            }
        } catch (NumberFormatException e) {
            System.err.println("❌ ERROR: Invalid number format in price, rental days, or discount! " + e.getMessage());
            response.sendRedirect("booking-cab.jsp?error=invalid_number_format");
            return;
        }

        // ✅ **Generate Unique Booking ID**
        String bookingId = "BKG-" + System.currentTimeMillis();

        // ✅ **Calculate Price Breakdown**
        double basePrice = vehiclePrice * rentalDays;
        double tax = basePrice * 0.1; // 10% tax
        double discountValue = (discountPercentage / 100) * basePrice; // Calculate discount
        double total = basePrice + tax - discountValue; // Total after discount & tax

        // ✅ **Create Booking Object (Encapsulating all booking details)**
        Booking booking = new Booking(bookingId, login, customerName, customerAddress, customerPhone,
                vehicleName, vehiclePrice, rentalDays, total, tax, startDestination, endDestination,
                discountCode, discountValue);

        // ✅ **Save Booking via Singleton Service**
        boolean isSuccess = bookingService.createBooking(booking);

        if (isSuccess) {
            // Forward to booking-success.jsp with booking details
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("booking-success.jsp").forward(request, response);
        } else {
            response.sendRedirect("booking-cab.jsp?error=failed");
        }
    }
}