package com.megacabproject.controllers.admin;

import com.google.gson.Gson;
import com.megacabproject.models.Booking;
import com.megacabproject.services.BookingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/BookingController")
public class BookingControllerServlet extends HttpServlet {

    private final BookingService bookingService = new BookingService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        if (action == null) {
            out.print(gson.toJson("No action specified"));
            return;
        }

        switch (action.toLowerCase()) {
            case "list":
                // Fetch all bookings
                List<Booking> bookings = bookingService.getAllBookings();
                int totalBookings = bookings.size();
                Map<String, Object> listResult = new HashMap<>();
                listResult.put("bookings", bookings);
                listResult.put("totalBookings", totalBookings);
                out.print(gson.toJson(listResult));
                break;


            default:
                out.print(gson.toJson("Invalid action"));
        }
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        Map<String, Object> result = new HashMap<>();

        if (action == null) {
            result.put("success", false);
            result.put("message", "No action specified");
            out.print(gson.toJson(result));
            out.flush();
            return;
        }

        switch (action.toLowerCase()) {
            case "delete":
                String bookingId = request.getParameter("bookingId");
                if (bookingId == null || bookingId.trim().isEmpty()) {
                    result.put("success", false);
                    result.put("message", "Invalid booking id");
                } else {
                    boolean deleted = bookingService.deleteBooking(bookingId);
                    result.put("success", deleted);
                    result.put("message", deleted ? "Booking deleted successfully" : "Failed to delete booking");
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