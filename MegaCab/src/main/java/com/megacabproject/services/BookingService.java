package com.megacabproject.services;

import com.megacabproject.dao.BookingDAO;
import com.megacabproject.models.Booking;
import java.util.List;

public class BookingService {
    private final BookingDAO bookingDAO = new BookingDAO();

    public boolean createBooking(Booking booking) {
        return bookingDAO.insertBooking(booking);
    }

    // Retrieve a booking by its ID
    public Booking getBookingById(String bookingId) {
        return bookingDAO.getBookingById(bookingId);
    }

    // Retrieve all bookings
    public List<Booking> getAllBookings() {
        return bookingDAO.getAllBookings();
    }

    // Delete a booking by booking ID
    public boolean deleteBooking(String bookingId) {
        return bookingDAO.deleteBooking(bookingId);
    }
}