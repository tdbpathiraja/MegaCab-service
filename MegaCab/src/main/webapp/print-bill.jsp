<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.megacabproject.models.Booking" %>
<%@ page import="com.megacabproject.services.BookingService" %>

<%
  // Get the bookingId from the request
  String bookingId = request.getParameter("bookingId");

  Booking booking = null;
  if (bookingId != null && !bookingId.isEmpty()) {
    // Fetch the booking details from the DB via the service
    BookingService bookingService = new BookingService();
    booking = bookingService.getBookingById(bookingId);
  }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Print Bill</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>

    body {
      background-color: #f4f4f4;
      margin: 0;
      padding: 30px;
    }
    .bill-container {
      max-width: 800px;
      margin: 0 auto;
      background: #fff;
      border: 2px solid #333;
      border-radius: 10px;
      padding: 20px;
    }
    .bill-header {
      text-align: center;
      margin-bottom: 20px;
    }
    .bill-details {
      margin-bottom: 20px;
    }
    .bill-details span {
      display: block;
      font-size: 1.1rem;
      margin-bottom: 5px;
    }
    @media print {
      .no-print {
        display: none;
      }
      .bill-container {
        border: none;
        margin: 0;
      }
    }
  </style>
</head>
<body>
<div class="bill-container">
  <div class="bill-header">
    <h2>Mega City Cab - Booking Bill</h2>
    <p>
      Booking ID:
      <strong><%= (booking != null) ? booking.getBookingId() : "N/A" %></strong>
    </p>
  </div>

  <div class="bill-details">
    <h4>Customer Details</h4>
    <span>Username: <%= (booking != null) ? booking.getUsername() : "N/A" %></span>
    <span>Name: <%= (booking != null) ? booking.getCustomerName() : "N/A" %></span>
    <span>Address: <%= (booking != null) ? booking.getCustomerAddress() : "N/A" %></span>
    <span>Phone: <%= (booking != null) ? booking.getTelephoneNumber() : "N/A" %></span>
  </div>

  <div class="bill-details">
    <h4>Booking Details</h4>
    <span>Vehicle: <%= (booking != null) ? booking.getBookedVehicle() : "N/A" %></span>
    <span>Price per Day: <%= (booking != null) ? booking.getVehiclePricePerDay() : 0.0 %></span>
    <span>Rental Days: <%= (booking != null) ? booking.getRentalDays() : 0 %></span>
    <span>Tax: <%= (booking != null) ? booking.getTaxValue() : 0.0 %></span>
    <span>Total: <%= (booking != null) ? booking.getTotalValue() : 0.0 %></span>
    <span>Start Destination: <%= (booking != null) ? booking.getStartDestination() : "N/A" %></span>
    <span>End Destination: <%= (booking != null) ? booking.getEndDestination() : "N/A" %></span>
    <span>Discount Code: <%= (booking != null) ? booking.getDiscountCode() : "N/A" %></span>
    <span>Discount Value: <%= (booking != null) ? booking.getDiscountValue() : 0.0 %></span>
  </div>

  <div class="text-center no-print">
    <button onclick="window.print()" class="btn btn-primary me-2">Print Bill</button>
    <a href="user-account.jsp" class="btn btn-secondary">Go to Dashboard</a>
  </div>
</div>
</body>
</html>
