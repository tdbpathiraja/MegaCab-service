package com.megacabproject.services;

import com.megacabproject.dao.BookingDAO;
import com.megacabproject.models.Booking;

/**
 * 🔹 BookingService - Business Logic for Bookings
 * - **Design Pattern:** Singleton, DAO
 * - **OOP Concepts:** Encapsulation, Abstraction
 */
public class BookingService {
    private final BookingDAO bookingDAO = new BookingDAO(); // Singleton Pattern

    public boolean createBooking(Booking booking) {
        return bookingDAO.insertBooking(booking);
    }

    // New method to retrieve booking details by booking ID
    public Booking getBookingById(String bookingId) {
        return bookingDAO.getBookingById(bookingId);
    }
}