package com.megacabproject.services;

import com.megacabproject.dao.BookingDAO;
import com.megacabproject.models.Booking;
import java.util.List;

public class BookingService {
    private final BookingDAO bookingDAO = new BookingDAO();
    private final EmailService emailService = new EmailService();

    public boolean createBooking(Booking booking) {
        boolean success = bookingDAO.insertBooking(booking);
        if (success) {
            emailService.sendBookingConfirmationEmail(booking.getUsername(), booking.getBookingId(), booking.getCustomerName(), booking.getTotalValue());
        }
        return success;
    }

    // Retrieve a booking by its ID
    public Booking getBookingById(String bookingId) {
        return bookingDAO.getBookingById(bookingId);
    }

    public List<Booking> getBookingsByUsername(String username) {
        return bookingDAO.getBookingsByUsername(username);
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