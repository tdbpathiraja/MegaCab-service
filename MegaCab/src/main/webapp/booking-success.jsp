<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.megacabproject.models.Booking" %>
<%
    Booking booking = (Booking) request.getAttribute("booking");
    String bookingId = (booking != null) ? booking.getBookingId() : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Successful</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            padding-top: 50px;
            background-color: #f4f4f4;
        }
        .success-container {
            max-width: 500px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
    </style>
</head>
<body>
<div class="container success-container">
    <h2>Booking Successful!</h2>
    <p>Your booking has been saved successfully.</p>
    <div class="mt-4">
        <a href="print-bill.jsp?bookingId=<%= bookingId %>" class="btn btn-primary me-2">Print Bill</a>
        <a href="user-account.jsp" class="btn btn-secondary">Go to Dashboard</a>
    </div>
</div>
</body>
</html>