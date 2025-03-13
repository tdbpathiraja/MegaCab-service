package com.megacabproject.controllers.customer;

import com.megacabproject.models.Booking;
import com.megacabproject.services.BookingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/downloadBooking")
public class DownloadBookingServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        if (bookingId == null || bookingId.isEmpty()){
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Booking ID is required");
            return;
        }
        BookingService bookingService = new BookingService();
        Booking booking = bookingService.getBookingById(bookingId);
        if (booking == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Booking not found");
            return;
        }

        // Set headers to trigger file download
        response.setContentType("text/plain");
        response.setHeader("Content-Disposition", "attachment; filename=" + bookingId + ".txt");

        PrintWriter out = response.getWriter();
        out.println("Booking ID: " + booking.getBookingId());
        out.println("Client Username: " + booking.getUsername());
        out.println("Customer Name: " + booking.getCustomerName());
        out.println("Customer Address: " + booking.getCustomerAddress());
        out.println("Telephone Number: " + booking.getTelephoneNumber());
        out.println("Booked Vehicle: " + booking.getBookedVehicle());
        out.println("Vehicle Price Per Day: " + booking.getVehiclePricePerDay());
        out.println("Rental Days: " + booking.getRentalDays());
        out.println("Total Value: " + booking.getTotalValue());
        out.println("Tax Value: " + booking.getTaxValue());
        out.println("Start Destination: " + booking.getStartDestination());
        out.println("End Destination: " + booking.getEndDestination());
        out.println("Discount Code: " + booking.getDiscountCode());
        out.println("Discount Value: " + booking.getDiscountValue());
        out.flush();
    }
}