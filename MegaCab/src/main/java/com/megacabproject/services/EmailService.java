package com.megacabproject.services;

import com.megacabproject.models.EmailNotification;

public class EmailService {

    public void sendBookingConfirmationEmail(String recipientEmail, String bookingId, String customerName, double totalPrice) {
        String subject = "MegaCab Booking Confirmation - " + bookingId;
        String body = "Dear " + customerName + ",\n\n"
                + "Thank you for your booking with MegaCab! Your booking details are as follows:\n"
                + "Booking ID: " + bookingId + "\n"
                + "Total Price: $" + totalPrice + "\n"
                + "We look forward to serving you!\n\n"
                + "Best Regards,\nMegaCab Team";

        EmailNotification email = new EmailNotification(recipientEmail, subject, body);
        System.out.println("\u2709 Email successfully sent to: " + email.getRecipientEmail());
        System.out.println("Subject: " + email.getSubject());
        System.out.println("Body:\n" + email.getBody());
    }
}
